RSpec.describe Roles::Presenters::Show do
  subject { described_class.new(role) }

  let(:role) { Models::Role.find_or_create_by(code: 'admin', title: 'Администратор') }

  describe "#as_json" do
    it "returns required attributes" do
      json = subject.as_json
      expect(json[:id]).to eq(role.id)
      expect(json[:code]).to eq(role.code)
      expect(json[:title]).to eq(role.title)
    end
  end
end
