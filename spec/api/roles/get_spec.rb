RSpec.describe "GET /roles", :with_access_token do
  let!(:first_role) { Models::Role.find_or_create_by(code: 'admin', title: 'Администратор') }
  let!(:second_role) { Models::Role.find_or_create_by(code: 'buyer', title: 'Покупатель') }
  let!(:third_role) { Models::Role.find_or_create_by(code: 'seller', title: 'Продавец') }

  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  it "responds with 200" do
    get "/roles"
    expect(last_response.status).to eq(200)
  end

  it "responds witt list of roles" do
    get "/roles"
    expect(last_response_json[:roles]).to be_present
  end

  context "when access token is invalid" do
    let(:access_token) { SecureRandom.hex(16) }

    it "responds with 401" do
      get "/roles"
      expect(last_response.status).to eq(401)
    end
  end
end
