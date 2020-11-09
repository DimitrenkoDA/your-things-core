RSpec.describe "GET /users/:user_id/user_roles", :with_access_token do
  let!(:user) { create(:buyer) }
  let!(:role) { Models::Role.find_or_create_by(code: 'seller', title: 'Продавец') } 
  let!(:user_role) { create(:user_role, role: role, user: user) }

  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  it "responds with 200" do
    get "/users/#{user.id}/user_roles"
    expect(last_response.status).to eq(200)
  end

  it "responds with user roles" do
    get "/users/#{user.id}/user_roles"
    expect(last_response_json[:user_roles].size).to eq(2)
  end

  context "when access token is invalid" do
    let(:access_token) { SecureRandom.hex(16) }

    it "responds with 401" do
      get "/users/#{user.id}/user_roles"
      expect(last_response.status).to eq(401)
    end
  end
end
