RSpec.describe Users::Actions::Delete do
  subject { described_class.new(current_user, args) }

  let!(:user) { create(:user) }
  let(:current_user) { create(:operator) }

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

  it "deletes user" do
    expect { subject.execute! }.to change { Models::User.count }.by(-1)
  end

  context "when current user is not operator" do
    let(:current_user) { create(:seller) }
    let(:user_id) { current_user.id }

    it "succeeds" do
      subject.execute!
      expect(subject.success?).to be true
    end

    context "when current user delete someone else's profile" do
      let(:user_id) { user.id }

      it "raises Action::AccessDenied error" do
        expect { subject.execute! }.to raise_error(Action::AccessDenied)
      end
    end
  end
end
