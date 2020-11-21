RSpec.describe "DELETE /users/:user_id", :with_access_token do
  let!(:user) { create(:user) }

  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  it "responds with 200" do
    delete "/users/#{user.id}"
    expect(last_response.status).to eq(200)
  end

  context "when user_id is invalid" do
    it "responds with 404" do
      delete "/users/test"
      expect(last_response.status).to eq(404)
    end
  end

  context "when user_id is unknown" do
    it "responds with 404" do
      delete "/users/100500"
      expect(last_response.status).to eq(404)
    end
  end

  context "when access token is invalid" do
    let(:access_token) { SecureRandom.hex(16) }

    it "responds with 401" do
      delete "/users/#{user.id}"
      expect(last_response.status).to eq(401)
    end
  end

  context "when current user is not operator" do
    let(:current_user) { create(:seller) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::User::KIND, current_user) }

    it "responds with 404" do
      delete "/users/#{user.id}"
      expect(last_response.status).to eq(404)
    end
  end
end
