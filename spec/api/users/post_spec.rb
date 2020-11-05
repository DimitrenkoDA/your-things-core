RSpec.describe "POST /users", :with_access_token do

  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  let(:body) do
    {
      email: email,
      first_name: first_name,
      last_name: last_name,
    }
  end

  let(:email) { FFaker::Internet.email }
  let(:first_name) { FFaker::Name.first_name }
  let(:last_name) { FFaker::Name.last_name }

  it "responds with 200" do
    post "/users", body.to_json
    expect(last_response.status).to eq(200)
  end

  context "when current user is not operator" do
    let(:current_user) { create(:buyer) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::User::KIND, current_user) }

    it "responds with 404" do
      post "/users", body.to_json
      expect(last_response.status).to eq(404)
    end
  end

  context "when email is nil" do
    let(:email) { nil }

    it "responds with 422" do
      post "/users", body.to_json
      expect(last_response.status).to eq(422)
    end
  end
end
