RSpec.describe Shops::Actions::Review do
  subject { described_class.new(current_user, args) }

  let!(:current_user) { create(:operator) }
  let!(:user) { create(:seller) }
  let!(:shop) { create(:shop, :unreviewed, user: user) }

  let(:args) do
    {
      shop_id: shop_id
    }
  end

  let(:shop_id) { shop.id }

  it "succeeds" do
    subject.execute!
    expect(subject).to be_success
  end

  it "reviewed shop" do
    subject.execute!
    expect(subject.shop.reviewed_at).to be_present
  end

  context "when shop is already reviewed" do
    let!(:shop) { create(:shop, :reviewed) }

    it "returns with errors" do
      subject.execute!
      expect(subject.errors).to eq(shop_id: "alredy reviewed")
    end
  end

  context "when current user is admin" do
    let!(:current_user) { create(:admin) }

    it "succeeds" do
      subject.execute!
      expect(subject).to be_success
    end
  
    it "reviewed shop" do
      subject.execute!
      expect(subject.shop.reviewed_at).to be_present
    end
  end

  context "when current user is not admin" do
    let!(:current_user) { create(:seller) }

    it "raises ActiveRecord::RecordNotFound" do
      expect { subject.execute! }.to raise_error(Action::AccessDenied)
    end
  end
end
