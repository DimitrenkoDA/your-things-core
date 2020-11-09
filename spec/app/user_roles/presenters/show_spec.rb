RSpec.describe UserRoles::Presenters::Show do
  subject { described_class.new(user_role) }

  let(:user_role) { create(:user_role, :buyer) }

  describe "#as_json" do
    it "returns required attributes" do
      json = subject.as_json
      
      expect(json[:id]).to eq(user_role.id)
    end
  end
end
