RSpec.describe Shops::Actions::Create do
  subject { described_class.new(current_user, args) }

  let(:current_user) { create(:operator) }

  let(:user) { create(:seller) }

  let(:args) do
    {
      user_id: user_id,
      name: name,
      description: description
    }
  end

  let(:user_id) { user.id }
  let(:name) { FFaker::Company.name }
  let(:description) { FFaker::Lorem.paragraph }

  it "succeeds" do
    subject.execute!
    expect(subject.success?).to be true
  end

  it "creates new shop" do
    expect { subject.execute! }.to change { Models::Shop.count }.by(1)
  end

  context "when name is not provided" do
    before do
      args.delete(:name)
    end

    it "fails" do
      subject.execute!
      expect(subject.success?).to be false
    end

    it "does not create new shop" do
      expect { subject.execute! }.to_not change { Models::Shop.count }
    end
  end

  context "when current user seller" do
    let(:current_user) { create(:seller) }

    let(:args) do
      {
        user_id: user_id,
        name: name,
        description: description
      }
    end
  
    let(:user_id) { current_user.id }
    let(:name) { FFaker::Company.name }
    let(:description) { FFaker::Lorem.paragraph }


    it "succeeds" do
      subject.execute!
      expect(subject.success?).to be true
    end
  
    it "creates new shop" do
      expect { subject.execute! }.to change { Models::Shop.count }.by(1)
    end
  end
end
