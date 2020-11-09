RSpec.describe UserRoles::Presenters::Index do
  subject { described_class.new(user_roles) }

  let(:user) { create(:user) }
  let(:buyer_role) { Models::Role.find_or_create_by(code: 'buyer', title: 'Покупатель') }
  let(:seller_role) { Models::Role.find_or_create_by(code: 'seller', title: 'Продавец') }
  let(:first_user_role) { create(:user_role, user: user, role: buyer_role) }
  let(:second_user_role) { create(:user_role, user: user, role: seller_role) }

  let(:user_roles) {[ first_user_role, second_user_role ]}

  describe "#as_json" do
    it "returns required attributes" do
      json = subject.as_json
      
      expect(json[:user_roles].size).to eq(2)
      expect(json[:user_roles][0]).to eq(UserRoles::Presenters::Show.new(user_roles[0]).as_json)
      expect(json[:user_roles][1]).to eq(UserRoles::Presenters::Show.new(user_roles[1]).as_json)
    end
  end
end
