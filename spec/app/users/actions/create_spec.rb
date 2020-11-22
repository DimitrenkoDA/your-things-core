RSpec.describe Users::Actions::Create do
  subject { described_class.new(current_user, args) }

  let(:current_user) { create(:operator) }

  let(:args) do
    {
      email: email,
      password: password,
      password_confirmation: password_confirmation
    }
  end

  let(:email) { FFaker::Internet.email }
  let(:password) { SecureRandom.hex(16) }
  let(:password_confirmation) { password }

  it "succeeds" do
    subject.execute!
    expect(subject.success?).to be true
  end

  it "creates new user" do
    expect { subject.execute! }.to change { Models::User.count }.by(1)
  end

  it "returns new user" do
    subject.execute!
    expect(subject.user).not_to be_nil
  end

  context "when password is nil" do
    let(:password) { nil }

    it "fails" do
      subject.execute!
      expect(subject.fail?).to be true
    end
  end

  context "when password_confirmation is nil" do
    let(:password_confirmation) { nil }

    it "fails" do
      subject.execute!
      expect(subject.fail?).to be true
    end
  end

  context "when password and password_confirmation do not match" do
    let(:password_confirmation) { SecureRandom.hex(16) }

    it "fails" do
      subject.execute!
      expect(subject.fail?).to be true
    end

    it "returns with error" do
      subject.execute!
      expect(subject.errors).to eq(password: 'password and password confirmation do not match')
    end
  end

  context "when current user is not operator" do
    let(:current_user) { create(:admin) }

    it "raises Action::AccessDenied" do
      expect { subject.execute! }.to raise_error(Action::AccessDenied)
    end
  end
end
