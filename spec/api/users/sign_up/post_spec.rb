RSpec.describe "POST /users/sign_up" do
  let(:email) { 'email@test.frj'  }

  let(:headers) do
    {
      "Accept" => "application/json"
    }
  end

  let(:body) do
    {
      email: email
    }
  end

  before do
    headers.each { |key, value| header key, value }

    Models::Role.find_or_create_by(code: 'buyer', title: 'Покупатель')
  end

  it "responds with 200" do
    post "/users/sign_up", body.to_json
    expect(last_response.status).to eq(200)
  end
end
