RSpec.describe "POST /users/:user_id/seller", :with_access_token do
  let!(:user) { create(:buyer) }

  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  before { Models::Role.find_or_create_by(code: 'seller', title: 'Продавец') }

  it "responds with 200" do
    post "/users/#{user.id}/seller"
    expect(last_response.status).to eq(200)
  end

  context "when access token is invalid" do
    let(:access_token) { SecureRandom.hex(16) }

    it "responds with 401" do
      post "/users/#{user.id}/seller"
      expect(last_response.status).to eq(401)
    end
  end

  context "when current user is not operator" do
    let(:current_user) { create(:buyer) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::User::KIND, current_user) }

    it "responds with 200" do
      post "/users/#{current_user.id}/seller"
      expect(last_response.status).to eq(200)
    end
  end
end
