RSpec.describe "POST /shops/:shop_id/review", :with_access_token do
  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  let!(:user) { create(:seller) }
  let!(:shop) { create(:shop, :unreviewed, user: user) }

  it "responds with 200" do
    post "/shops/#{shop.id}/review"
    expect(last_response.status).to eq(200)
  end

  context "when current user is admin" do
    let(:current_user) { create(:admin) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::Admin::KIND, current_user) }

    it "responds with 200" do
      post "/shops/#{shop.id}/review"
      expect(last_response.status).to eq(200)
    end
  end

  context "when current user is not admin" do
    let(:current_user) { create(:seller) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::User::KIND, current_user) }

    it "responds with 404" do
      post "/shops/#{shop.id}/review"
      expect(last_response.status).to eq(404)
    end
  end
end
