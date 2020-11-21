RSpec.describe "GET /admins/:admin_id", :with_access_token do
  let!(:admin) { create(:admin) }

  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  it "responds with 200" do
    get "/admins/#{admin.id}"
    expect(last_response.status).to eq(200)
  end

  it "responds with admin" do
    get "/admins/#{admin.id}"
    expect(last_response_json[:id]).to eq(admin.id)
  end

  context "when access token is invalid" do
    let(:access_token) { SecureRandom.hex(16) }

    it "responds with 401" do
      get "/admins/#{admin.id}"
      expect(last_response.status).to eq(401)
    end
  end

  context "when current user is admin" do
    let(:current_user) { create(:admin) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::Admin::KIND, current_user) }

    it "responds with 200" do
      get "/admins/#{current_user.id}"
      expect(last_response.status).to eq(200)
    end
  end

  context "when current user is regular user" do
    let(:current_user) { create(:seller) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::User::KIND, current_user) }

    it "responds with 200" do
      get "/admins/#{current_user.id}"
      expect(last_response.status).to eq(404)
    end
  end
end
