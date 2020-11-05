RSpec.describe Roles::Presenters::Index do
  subject { described_class.new(roles) }

  let(:first_role) { Models::Role.find_or_create_by(code: 'admin', title: 'Администратор') }
  let(:second_role) { Models::Role.find_or_create_by(code: 'buyer', title: 'Покупатель') }
  let(:third_role) { Models::Role.find_or_create_by(code: 'seller', title: 'Продавец') }

  let(:roles) { [first_role, second_role, third_role] }

  describe "#as_json" do
    it "returns required attributes" do
      json = subject.as_json

      expect(json[:roles].size).to eq(3)
      expect(json[:roles][0]).to eq(Roles::Presenters::Show.new(first_role).as_json)
      expect(json[:roles][1]).to eq(Roles::Presenters::Show.new(second_role).as_json)
      expect(json[:roles][2]).to eq(Roles::Presenters::Show.new(third_role).as_json)
    end
  end
end
