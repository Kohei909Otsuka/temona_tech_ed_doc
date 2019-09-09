require "rails_helper"

RSpec.describe "/auth", type: :request do
  let(:login_info) do
    {
      name: "kohei",
      email: "kohei@example.com",
      password: "password-00"
    }
  end
  before do
    User.register(
      login_info[:name],
      login_info[:email],
      login_info[:password]
    )
  end

  describe "POST /login" do

    before do
      allow(SecureRandom).to receive(:uuid)
        .and_return("some-session-id")
    end

    it "returns 200 ok when succeess" do
      post "/login", params: {
        email: login_info[:email],
        password: login_info[:password]
      }
      expect(response).to have_http_status :ok

      header = response.header
      expect(header["Set-Cookie"]).to eq "session_id=some-session-id; path=/"
    end

    it "returns 404 not found when fail" do
      post "/login", params: {
        email: login_info[:email],
        password: login_info[:password] + "extra"
      }
      expect(response).to have_http_status :not_found
    end
  end

  describe "DELETE /logout" do
    it "returns 200 ok when success" do
      emulate_login(login_info[:email], login_info[:password])

      delete "/logout"
      expect(response).to have_http_status :ok
    end

    it "returns 401 unauthorized when not logined" do
      delete "/logout"
      expect(response).to have_http_status :unauthorized
    end
  end
end
