RSpec.describe "GET /shops", :with_access_token do
  let!(:one_user) { create(:seller) }
  let!(:second_user) { create(:seller) }
  let!(:first_shop) { create(:shop, user: one_user) }
  let!(:second_shop) { create(:shop, user: second_user) } 

  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  it "responds with 200" do
    get "/shops"
    expect(last_response.status).to eq(200)
  end

  it "responds with shops" do
    get "/shops"
    expect(last_response_json[:shops].size).to eq(2)
  end

  context "when current user is user" do
    let(:current_user) { create(:seller) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::User::KIND, current_user) }

    it "responds with 200" do
      get "/shops"
      expect(last_response.status).to eq(200)
    end
  end

  context "when access token is invalid" do
    let(:access_token) { SecureRandom.hex(16) }

    it "responds with 401" do
      get "/shops"
      expect(last_response.status).to eq(401)
    end
  end
end