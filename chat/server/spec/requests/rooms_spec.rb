require "rails_helper"

RSpec.describe "/rooms", type: :request do
  let(:login_info) do
    {
      name: "kohei",
      email: "kohei@example.com",
      password: "password-00"
    }
  end

  before do
    @user = User.register(
      login_info[:name],
      login_info[:email],
      login_info[:password]
    ).data
    emulate_login(login_info[:email], login_info[:password])
  end

  describe "GET /rooms" do
    it "returns 200 ok with user's rooms" do
      @user.rooms << build_list(:room, 2)

      get "/rooms"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status :ok
      expect(json[:data].length).to eq @user.rooms.length
    end
  end
end
