RSpec.describe Admins::Actions::Delete do
  subject { described_class.new(current_user, args) }

  let!(:admin) { create(:admin) }
  let(:current_user) { create(:operator) }

  let(:args) do
    {
      admin_id: admin_id
    }
  end

  let(:admin_id) { admin.id }

  it "succeeds" do
    subject.execute!
    expect(subject.success?).to be true
  end

  it "deletes admin" do
    expect { subject.execute! }.to change { Models::Admin.count }.by(-1)
  end

  context "when current user is not operator" do
    let(:current_user) { create(:admin) }
    let(:admin_id) { current_user.id }

    it "succeeds" do
      subject.execute!
      expect(subject.success?).to be true
    end

    context "when current user delete someone else's profile" do
      let(:admin_id) { admin.id }

      it "raises Action::AccessDenied error" do
        expect { subject.execute! }.to raise_error(Action::AccessDenied)
      end
    end
  end
end
