RSpec.describe Shops::Presenters::Show do
  subject { described_class.new(shop) }

  let(:user) { create(:seller) }
  let(:shop) { create(:shop, :reviewed, user: user) }

  describe "#as_json" do
    it "returns required attributes" do
      json = subject.as_json

      expect(json[:id]).to eq(shop.id)
      expect(json[:name]).to eq(shop.name)
      expect(json[:rewiewed_at]).to be_nil
      expect(json[:created_at]).to eq(shop.created_at)
      expect(json[:updated_at]).to eq(shop.updated_at)
    end
  end
end
