RSpec.describe Users::Actions::Update do
  subject { described_class.new(current_user, args) }

  let(:current_user) { create(:operator) }

  let(:user) { create(:user) }

  let(:args) do
    {
      user_id: user_id,
      email: email,
      first_name: first_name,
      last_name: last_name
    }
  end

  let(:user_id) { user.id }

  let(:email) { FFaker::Internet.email }
  let(:first_name) { FFaker::Name.first_name }
  let(:last_name) { FFaker::Name.last_name }

  it "succeeds" do
    subject.execute!
    expect(subject.success?).to be true
  end

  it "updates email" do
    subject.execute!
    expect(subject.user.email).to eq(email)
  end

  context "when email is nil" do
    let(:email) { nil }

    it "fails" do
      subject.execute!
      expect(subject.fail?).to be true
    end
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

  context "when user_id is unknown" do
    let(:user_id) { 100500 }

    it "raises ActiveRecord::RecordNotFound" do
      expect { subject.execute! }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context "when user_id is invalid" do
    let(:user_id) { "test "}

    it "fails" do
      subject.execute!
      expect(subject.fail?).to be true
    end
  end

  context "when current user is not operator" do
    let(:current_user) { create(:admin) }
    let(:user_id) { current_user.id }

    it "succeeds" do
      subject.execute!
      expect(subject.success?).to be true
    end
  
    it "updates email" do
      subject.execute!
      expect(subject.user.email).to eq(email)
    end

    context "when current user updates someone else's profile" do
      let(:user_id) { user.id }

      it "raises ActiveRecord::RecordNotFound" do
        expect { subject.execute! }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
