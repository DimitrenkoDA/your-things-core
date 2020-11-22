RSpec.describe "DELETE /admins/:admin_id", :with_access_token do
  let!(:admin) { create(:admin) }

  let(:current_user) { create(:operator) }
  let(:access_token) { Sessions::Session.token(Sessions::Owners::Operator::KIND, current_user) }

  it "responds with 200" do
    delete "/admins/#{admin.id}"
    expect(last_response.status).to eq(200)
  end

  context "when access token is invalid" do
    let(:access_token) { SecureRandom.hex(16) }

    it "responds with 401" do
      delete "/admins/#{admin.id}"
      expect(last_response.status).to eq(401)
    end
  end

  context "when current user is not operator" do
    let(:current_user) { create(:admin) }
    let(:access_token) { Sessions::Session.token(Sessions::Owners::Admin::KIND, current_user) }

    it "responds with 200" do
      delete "/admins/#{current_user.id}"
      expect(last_response.status).to eq(200)
    end

    context "when current user try delete another admin" do
      it "responds with 404" do
        delete "/admins/#{admin.id}"
        expect(last_response.status).to eq(404)
      end
    end
  end
end
