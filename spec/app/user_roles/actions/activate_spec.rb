RSpec.describe UserRoles::Actions::Activate do
  subject { described_class.new(current_user, args) }

  let!(:current_user) { create(:operator) }
  let!(:user) { create(:user) }
  let!(:role) { Models::Role.find_or_create_by(code: 'seller', title: 'Продавец') } 
  let!(:user_role) { create(:user_role, role: role, user: user) }

  let(:args) do
    {
      user_id: user_id,
      user_role_id: user_role_id
    }
  end

  let(:user_id) { user.id }
  let(:user_role_id) { user_role.id }

  it "succeeds" do
    subject.execute!
    expect(subject).to be_success
  end

  it "activates user role" do
    subject.execute!
    expect(subject.user_role).to be_active
  end

  context "when driver is already active" do
    let!(:user_role) { create(:user_role, role: role, user: user, activated_at: 2.day.ago) }

    it "raises ActiveRecord::RecordNotFound" do
      expect { subject.execute! }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context "when current user is admin" do
    let(:current_user) { create(:admin) }

    it "succeeds" do
      subject.execute!
      expect(subject).to be_success
    end
  
    it "activates user role" do
      subject.execute!
      expect(subject.user_role).to be_active
    end
  end
end
