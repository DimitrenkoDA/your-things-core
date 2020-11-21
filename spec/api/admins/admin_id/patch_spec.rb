RSpec.describe "PATCH /admins/:admin_id", :with_access_token do
  let!(:admin) { create(:admin) }

  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  let(:body) do
    {
      email: email,
      phone: phone,
      first_name: first_name,
      last_name: last_name
    }
  end

  let(:email) { FFaker::Internet.email }
  let(:phone) { FFaker::PhoneNumberRU.phone_number }
  let(:first_name) { FFaker::Name.first_name }
  let(:last_name) { FFaker::Name.last_name }

  it "responds with 200" do
    patch "/admins/#{admin.id}", body.to_json
    expect(last_response.status).to eq(200)
  end

  context "when access token is invalid" do
    let(:access_token) { SecureRandom.hex(16) }

    it "responds with 401" do
      patch "/admins/#{admin.id}", body.to_json
      expect(last_response.status).to eq(401)
    end
  end

  context "when current user is not admin" do
    let!(:current_user) { create(:admin) }
    let!(:access_token) { Sessions::Session.token(Sessions::Owners::Admin::KIND, current_user) }

    it "responds with 200" do
      patch "/admins/#{current_user.id}", body.to_json
      expect(last_response.status).to eq(200)
    end

    context "when current user try update another admin" do
      it "responds with 404" do
        patch "/admins/#{admin.id}", body.to_json
        expect(last_response.status).to eq(404)
      end
    end
  end
end
