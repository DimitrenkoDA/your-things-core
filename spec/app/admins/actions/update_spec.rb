RSpec.describe Admins::Actions::Update do
  subject { described_class.new(current_user, args) }

  let(:current_user) { create(:operator) }

  let(:admin) { create(:admin) }

  let(:args) do
    {
      admin_id: admin_id,
      email: email,
      phone: phone,
      first_name: first_name,
      last_name: last_name
    }
  end

  let(:admin_id) { admin.id }

  let(:email) { FFaker::Internet.email }
  let(:phone) { FFaker::PhoneNumberRU.phone_number }
  let(:first_name) { FFaker::Name.first_name }
  let(:last_name) { FFaker::Name.last_name }

  it "succeeds" do
    subject.execute!
    expect(subject.success?).to be true
  end

  it "updates attributes" do
    subject.execute!
    expect(subject.admin.email).to eq(email)
    expect(subject.admin.phone).to eq(phone)
    expect(subject.admin.first_name).to eq(first_name)
    expect(subject.admin.last_name).to eq(last_name)
  end

  context "when one of args is nil" do
    let(:email) { nil }

    it "fails" do
      subject.execute!
      expect(subject.fail?).to be true
    end
  end

  context "when admin_id is invalid" do
    let(:admin_id) { 'test'}

    it "fails" do
      subject.execute!
      expect(subject.fail?).to be true
    end
  end

  context "when current user is not operator" do
    let!(:current_user) { create(:admin) }
    let!(:admin_id) { current_user.id }

    it "succeeds" do
      subject.execute!
      expect(subject.success?).to be true
    end
  
    it "updates attributes" do
      subject.execute!
      expect(subject.admin.email).to eq(email)
      expect(subject.admin.phone).to eq(phone)
      expect(subject.admin.first_name).to eq(first_name)
      expect(subject.admin.last_name).to eq(last_name)
    end

    context "when current user updates someone else's profile" do
      let(:another_admin) { create(:admin) }
      let!(:admin_id) { another_admin.id }

      it "raises Action::AccessDenied" do
        expect { subject.execute! }.to raise_error(Action::AccessDenied)
      end
    end
  end
end
