RSpec.describe "GET /users/:user_id", :with_access_token do
  let!(:user) { create(:seller) }

  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  it "responds with 200" do
    get "/users/#{user.id}"
    expect(last_response.status).to eq(200)
  end

  it "responds with user" do
    get "/users/#{user.id}"
    expect(last_response_json[:id]).to eq(user.id)
  end

  context "when user_id is invalid" do
    it "responds with 404" do
      get "/users/test"
      expect(last_response.status).to eq(404)
    end
  end

  context "when user_id is unknown" do
    it "responds with 404" do
      get "/users/100500"
      expect(last_response.status).to eq(404)
    end
  end

  context "when access token is invalid" do
    let(:access_token) { SecureRandom.hex(16) }

    it "responds with 401" do
      get "/users/#{user.id}"
      expect(last_response.status).to eq(401)
    end
  end

  context "when current user is user" do
    let(:current_user) { create(:seller) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::User::KIND, current_user) }

    it "responds with 404" do
      get "/users/#{user.id}"
      expect(last_response.status).to eq(404)
    end
  end
end
