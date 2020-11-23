RSpec.describe Shops::Presenters::Index do
  subject { described_class.new(shops) }

  let(:current_user) { create(:operator) }

  let(:one_user) { create(:seller) }
  let(:next_user) { create(:seller) }

  let(:first_shop) { create(:shop, :reviewed, user: one_user) }
  let(:second_shop) { create(:shop, :reviewed, user: next_user) }

  let(:shops) {[ first_shop, second_shop ]}

  describe "#as_json" do
    it "returns required attributes" do
      json = subject.as_json

      expect(json[:shops].size).to eq(2)
      expect(json[:shops][0]).to eq(Shops::Presenters::Show.new(shops[0]).as_json)
      expect(json[:shops][1]).to eq(Shops::Presenters::Show.new(shops[1]).as_json)
    end
  end
end
