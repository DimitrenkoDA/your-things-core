RSpec.describe Shops::Actions::Update do
  subject { described_class.new(current_user, args) }

  let(:current_user) { create(:operator) }
  let(:user) { create(:seller) }

  let!(:shop) { create(:shop, name: 'Old shop', user: user) }

  let(:args) do
    {
      shop_id: shop_id,
      name: name,
      description: description
    }
  end

  let(:shop_id) { shop.id }
  let(:name) { FFaker::Company.name }
  let(:description) { FFaker::Lorem.paragraph }

  it "succeeds" do
    subject.execute!
    expect(subject.success?).to be true
  end

  it "updates shop name" do
    subject.execute!
    expect(subject.shop.name).to eq(name)
  end

  it "updates shop description" do
    subject.execute!
    expect(subject.shop.description).to eq(description)
  end

  context "when current user is shop owner" do
    let(:current_user) { create(:seller) }
    let(:another_shop) { create(:shop, user: current_user) }

    let!(:shop_id) { another_shop.id }

    it "succeeds" do
      subject.execute!
      expect(subject.success?).to be true
    end
  
    it "updates shop name" do
      subject.execute!
      expect(subject.shop.name).to eq(name)
    end
  
    it "updates shop description" do
      subject.execute!
      expect(subject.shop.description).to eq(description)
    end
  end

  context "when current user is not shop owner" do
    let(:current_user) { create(:buyer) }

    it "raises ActiveRecord::RecordNotFound" do
      expect { subject.execute! }.to raise_error(Action::AccessDenied)
    end
  end

  context "when name is nil" do
    let(:name) { nil }

    it "fails" do
      subject.execute!
      expect(subject.fail?).to be true
    end
  end
end
