RSpec.describe "POST /admins", :with_access_token do

  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  let(:body) do
    {
      email: email,
      password: password,
      password_confirmation: password_confirmation
    }
  end

  let(:email) { FFaker::Internet.email }
  let(:password) { SecureRandom.hex(16) }
  let(:password_confirmation) { password }

  it "responds with 200" do
    post "/admins", body.to_json
    expect(last_response.status).to eq(200)
  end

  context "when current user is not operator" do
    let(:current_user) { create(:buyer) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::User::KIND, current_user) }

    it "responds with 404" do
      post "/admins", body.to_json
      expect(last_response.status).to eq(404)
    end
  end

  context "when email is nil" do
    let(:email) { nil }

    it "responds with 422" do
      post "/admins", body.to_json
      expect(last_response.status).to eq(422)
    end
  end
end
