RSpec.describe Shops::Actions::Delete do
  subject { described_class.new(current_user, args) }

  let(:current_user) { create(:operator) }
  let(:user) { create(:seller) }

  let!(:shop) { create(:shop, user: user) }

  let(:args) do
    {
      shop_id: shop_id
    }
  end

  let(:shop_id) { shop.id }

  it "succeeds" do
    subject.execute!
    expect(subject.success?).to be true
  end

  it "destroys shop" do
    expect { subject.execute! }.to change { Models::Shop.count }.by(-1)
  end

  context "when current user is shop owner" do
    let(:current_user) { create(:seller) }
    let(:another_shop) { create(:shop, user: current_user) }

    let!(:shop_id) { another_shop.id }

    it "succeeds" do
      subject.execute!
      expect(subject.success?).to be true
    end
  
    it "destroys shop" do
      expect { subject.execute! }.to change { Models::Shop.count }.by(-1)
    end    
  end

  context "when current user is not shop owner" do
    let(:current_user) { create(:buyer) }

    it "raises ActiveRecord::RecordNotFound" do
      expect { subject.execute! }.to raise_error(Action::AccessDenied)
    end
  end

  context "when sho_id is invalid" do
    let(:shop_id) { 100500 }

    it "raises ActiveRecord::RecordNotFound" do
      expect { subject.execute! }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
