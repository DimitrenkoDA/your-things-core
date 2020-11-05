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

    it "raises ActiveRecord::RecordNotFound" do
      expect { subject.execute! }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context "when user_id is invalid" do
    let(:user_id) { "test" }

    it "fails" do
      subject.execute!
      expect(subject.fail?).to be true
    end
  end
end
