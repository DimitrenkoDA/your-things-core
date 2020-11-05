RSpec.describe Users::Actions::Create do
  subject { described_class.new(current_user, args) }

  let(:current_user) { create(:operator) }

  let(:args) do
    {
      email: email,
      first_name: first_name,
      last_name: last_name
    }
  end

  let(:email) { FFaker::Internet.email }
  let(:first_name) { FFaker::Name.first_name }
  let(:last_name) { FFaker::Name.last_name }

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

  context "when first_name is nil" do
    let(:first_name) { nil }

    it "fails" do
      subject.execute!
      expect(subject.fail?).to be true
    end
  end

  context "when last_name is nil" do
    let(:last_name) { nil }

    it "fails" do
      subject.execute!
      expect(subject.fail?).to be true
    end
  end

  context "when email is nil" do
    let(:email) { nil }

    it "fails" do
      subject.execute!
      expect(subject.fail?).to be true
    end
  end

  context "when current user is not operator" do
    let(:current_user) { create(:admin) }

    it "raises Action::AccessDenied" do
      expect { subject.execute! }.to raise_error(Action::AccessDenied)
    end
  end
end
