RSpec.describe Users::Actions::Seller do
  subject { described_class.new(current_user, args) }

  let!(:user) { create(:user) }
  let(:current_user) { create(:operator) }

  before { Models::Role.find_or_create_by(code: 'seller', title: 'Продавец') }

  let(:args) do
    {
      user_id: user_id
    }
  end

  let(:user_id) { user.id }

  it "succeeds" do
    subject.execute!
    expect(subject.success?).to be true
  end

  it "Add seller role to user" do
    expect { subject.execute! }.to change { Models::UserRole.count }.by(1)
  end

  context "when current user is not operator" do
    let(:current_user) { create(:buyer) }
    let(:user_id) { current_user.id }

    it "succeeds" do
      subject.execute!
      expect(subject.success?).to be true
    end

    it "Add seller role to current user" do
      expect { subject.execute! }.to change { Models::UserRole.count }.by(2)
    end

    context "when current user made someone else's seller" do
      let(:user_id) { user.id }

      it "raises Action::AccessDenied error" do
        expect { subject.execute! }.to raise_error(Action::AccessDenied)
      end
    end
  end
end
