RSpec.describe Users::Presenters::Index do
  subject { described_class.new(users) }

  let(:users) { create_list(:user, 2) }

  describe "#as_json" do
    it "returns required attributes" do
      json = subject.as_json

      expect(json[:users].size).to eq(2)
      expect(json[:users][0]).to eq(Users::Presenters::Show.new(users[0]).as_json)
      expect(json[:users][1]).to eq(Users::Presenters::Show.new(users[1]).as_json)
    end
  end
end
