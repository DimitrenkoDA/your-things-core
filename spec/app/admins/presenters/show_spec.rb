RSpec.describe Admins::Presenters::Show do
  subject { described_class.new(admin) }

  let(:admin) { create(:admin) }

  describe "#as_json" do
    it "returns required attributes" do
      json = subject.as_json

      expect(json[:id]).to eq(admin.id)
      expect(json[:email]).to eq(admin.email)
    end
  end
end
