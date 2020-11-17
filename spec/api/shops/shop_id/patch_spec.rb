RSpec.describe "PATCH /shops/:shop_id", :with_access_token do
  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  let(:user) { create(:seller) }

  let!(:shop) { create(:shop, name: 'Old shop', user: user) }

  let(:body) do
    {
      name: FFaker::Company.name,
      description: FFaker::Lorem.paragraph
    }
  end

  it "responds with 200" do
    patch "/shops/#{shop.id}", body.to_json
    expect(last_response.status).to eq(200)
  end

  it "responds with updated shop" do
    patch "/shops/#{shop.id}", body.to_json
    expect(last_response_json[:id]).to be_present
  end

  context "when current user is shop owner" do
    let(:current_user) { create(:seller) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::User::KIND, current_user) }

    let!(:shop) { create(:shop, name: 'Another old shop', user: current_user) }

    it "responds with 200" do
      patch "/shops/#{shop.id}", body.to_json
      expect(last_response.status).to eq(200)
    end
  
    it "responds with updated shop" do
      patch "/shops/#{shop.id}", body.to_json
      expect(last_response_json[:id]).to be_present
    end
  end

  context "when current user is not shop owner" do
    let(:current_user) { create(:buyer) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::User::KIND, current_user) }

    it "responds with 404" do
      patch "/shops/#{shop.id}", body.to_json
      expect(last_response.status).to eq(404)
    end
  end
end
