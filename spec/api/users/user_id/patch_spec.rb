RSpec.describe "PATCH /users/:user_id", :with_access_token do
  let!(:user) { create(:buyer) }

  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  let(:body) do
    {
      email: email,
      first_name: first_name,
      last_name: last_name
    }
  end

  let(:email) { FFaker::Internet.email }
  let(:first_name) { FFaker::Name.first_name }
  let(:last_name) { FFaker::Name.last_name }

  it "responds with 200" do
    patch "/users/#{user.id}", body.to_json
    expect(last_response.status).to eq(200)
  end

  context "when user_id is invalid" do
    it "responds with 404" do
      patch "/users/test"
      expect(last_response.status).to eq(404)
    end
  end

  context "when user_id is unknown" do
    it "responds with 404" do
      patch "/users/100500", body.to_json
      expect(last_response.status).to eq(404)
    end
  end

  context "when access token is invalid" do
    let(:access_token) { SecureRandom.hex(16) }

    it "responds with 401" do
      patch "/users/#{user.id}", body.to_json
      expect(last_response.status).to eq(401)
    end
  end

  context "when current user is not operator" do
    let(:current_user) { create(:buyer) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::User::KIND, current_user) }

    it "responds with 404" do
      patch "/users/#{user.id}", body.to_json
      expect(last_response.status).to eq(404)
    end
  end
end
