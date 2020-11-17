RSpec.describe "DELETE /shops/:shop_id", :with_access_token do
  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  let(:user) { create(:seller) }

  let(:shop) { create(:shop, user: user) }

  it "responds with 200" do
    delete "/shops/#{shop.id}"
    expect(last_response.status).to eq(200)
  end

  context "when current user is shop owner" do
    let(:current_user) { create(:seller) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::User::KIND, current_user) }

    let!(:shop) { create(:shop, user: current_user) }

    it "responds with 200" do
      delete "/shops/#{shop.id}"
      expect(last_response.status).to eq(200)
    end
  end

  context "when current user is not shop owner" do
    let(:current_user) { create(:buyer) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::User::KIND, current_user) }

    it "responds with 404" do
      delete "/shops/#{shop.id}"
      expect(last_response.status).to eq(404)
    end
  end

  context "when access token is invalid" do
    let(:access_token) { SecureRandom.hex(16) }

    it "responds with 401" do
      delete "/shops/#{shop.id}"
      expect(last_response.status).to eq(401)
    end
  end
end
