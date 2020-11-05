RSpec.describe Users::Presenters::Show do
  subject { described_class.new(user) }

  let(:user) { create(:user) }

  describe "#as_json" do
    it "returns required attributes" do
      json = subject.as_json

      expect(json[:id]).to eq(user.id)
      expect(json[:email]).to eq(user.email)
      expect(json[:created_at]).to eq(user.created_at)
      expect(json[:updated_at]).to eq(user.updated_at)
    end
  end
end
