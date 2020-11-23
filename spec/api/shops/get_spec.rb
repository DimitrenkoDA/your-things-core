RSpec.describe "GET /shops", :with_access_token do
  let!(:one_user) { create(:seller) }
  let!(:second_user) { create(:seller) }
  let!(:third_user) { create(:seller) }

  let!(:first_shop) { create(:shop, :reviewed, user: one_user) }
  let!(:second_shop) { create(:shop, :reviewed, user: second_user) }
  let!(:third_shop) { create(:shop, :unreviewed, user: third_user) }

  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  it "responds with 200" do
    get "/shops"
    expect(last_response.status).to eq(200)
  end

  it "responds with shops" do
    get "/shops"
    expect(last_response_json[:shops].size).to eq(3)
  end

  context "when current user is admin" do
    let(:current_user) { create(:admin) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::Admin::KIND, current_user) }

    it "responds with 200" do
      get "/shops"
      expect(last_response.status).to eq(200)
    end

    it "responds with shops" do
      get "/shops"
      expect(last_response_json[:shops].size).to eq(1)
    end
  end

  context "when current user is regular user" do
    let(:current_user) { create(:buyer) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::User::KIND, current_user) }

    it "responds with 200" do
      get "/shops"
      expect(last_response.status).to eq(200)
    end

    it "responds with shops" do
      get "/shops"
      expect(last_response_json[:shops].size).to eq(2)
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
