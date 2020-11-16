RSpec.describe "POST /shops", :with_access_token do

  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  let!(:user) { create(:seller) }

  let(:body) do
    {
      user_id: user.id,
      name: name,
      description: description
    }
  end

  let(:name) { FFaker::Company.name }
  let(:description) { FFaker::Lorem.paragraph }

  it "responds with 200" do
    post "/shops", body.to_json
    expect(last_response.status).to eq(200)
  end

  context "when current user is seller" do
    let(:current_user) { create(:seller) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::User::KIND, current_user) }

    it "responds with 200" do
      post "/shops", body.to_json
      expect(last_response.status).to eq(200)
    end
  end

  context "when current user is buyer" do
    let(:current_user) { create(:buyer) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::User::KIND, current_user) }

    it "responds with 403" do
      post "/shops", body.to_json
      expect(last_response.status).to eq(404)
    end
  end
end
