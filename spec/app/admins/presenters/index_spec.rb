RSpec.describe Admins::Presenters::Index do
  subject { described_class.new(admins) }

  let(:admins) { create_list(:admin, 2) }

  describe "#as_json" do
    it "returns required attributes" do
      json = subject.as_json

      expect(json[:admins].size).to eq(2)
      expect(json[:admins][0]).to eq(Admins::Presenters::Show.new(admins[0]).as_json)
      expect(json[:admins][1]).to eq(Admins::Presenters::Show.new(admins[1]).as_json)
    end
  end
end
