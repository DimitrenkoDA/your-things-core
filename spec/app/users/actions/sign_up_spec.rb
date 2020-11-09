RSpec.describe Users::Actions::SignUp do
  subject { described_class.new(args) }

  let(:args) do
    {
      email: email
    }
  end

  before { Models::Role.find_or_create_by(code: 'buyer', title: 'Покупатель') }

  let(:email) { 'email@test.frj' }

  it "succeeds" do
    subject.execute!
    expect(subject.success?).to be_present
  end

  it "creates new user" do
    expect { subject.execute! }.to change { Models::User.count }.by(1)
  end

  it "creates new user_role" do
    expect { subject.execute! }.to change { Models::UserRole.count }.by(1)
  end

  context "when user with such email already exits" do
    before { create(:buyer, email: email) }

    it "does not create new user" do
      expect { subject.execute! }.to change { Models::User.count }.by(0)
    end

    it "does not create new user role" do
      expect { subject.execute! }.to change { Models::UserRole.count }.by(0)
    end
  end
end
