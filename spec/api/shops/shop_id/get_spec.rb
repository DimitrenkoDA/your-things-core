RSpec.describe "GET /shops/:shop_id", :with_access_token do
  let!(:user) { create(:seller) }
  let!(:first_shop) { create(:shop, user: user) }

  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  it "responds with 200" do
    get "/shops/#{first_shop.id}"
    expect(last_response.status).to eq(200)
  end

  it "responds with shop" do
    get "/shops/#{first_shop.id}"
    expect(last_response_json[:id]).to eq(first_shop.id)
  end

  context "when access token is invalid" do
    let(:access_token) { SecureRandom.hex(16) }

    it "responds with 401" do
      get "/shops/#{first_shop.id}"
      expect(last_response.status).to eq(401)
    end
  end
end
