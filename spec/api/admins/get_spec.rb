RSpec.describe "GET /admins", :with_access_token do
  let!(:admins) { create_list(:admin, 2) }

  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  it "responds with 200" do
    get "/admins"
    expect(last_response.status).to eq(200)
  end

  it "responds with users" do
    get "/admins"
    expect(last_response_json[:admins].size).to eq(2)
  end

  context "when current user is admin" do
    let(:current_user) { create(:admin) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::Admin::KIND, current_user) }

    it "responds with 200" do
      get "/admins"
      expect(last_response.status).to eq(200)
    end

    it "responds with current user only" do
      get "/admins"

      expect(last_response_json[:admins].size).to eq(1)
      expect(last_response_json[:admins][0][:id]).to eq(current_user.id)
    end
  end

  context "when access token is invalid" do
    let(:access_token) { SecureRandom.hex(16) }

    it "responds with 401" do
      get "/admins"
      expect(last_response.status).to eq(401)
    end
  end
end
