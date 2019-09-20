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
    room_a = create(:room, name: "room_a")
    room_b = create(:room, name: "room_b")

    @user = User.register(
      login_info[:name],
      login_info[:email],
      login_info[:password]
    ).data
    another_user = User.register(
      "another",
      "another@example.com",
      "another-00"
    ).data

    # room_a, room_bに@user, another_userが所属している
    @user.rooms = [room_a, room_b]
    another_user.rooms = [room_a, room_b]

    # @userにとって、room_aに0件room_bに1件の未読メッセージがある
    create(:msg, user: another_user, room: room_a)
    msg = create(:msg, user: another_user, room: room_b)
    create(:unread_msg, room: room_b, user: @user, msg: msg)

    emulate_login(login_info[:email], login_info[:password])
  end

  describe "GET /rooms" do
    it "returns 200 ok with user's rooms" do
      get "/rooms"
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status :ok
      expect(json[:data].length).to eq @user.rooms.length
      attrs = json[:data]
        .map {|d| d[:attributes].slice(:name,  :unread)}
        .to_set

      expect(attrs).to eq [
        {name: "room_a", unread: 0},
        {name: "room_b", unread: 1},
      ].to_set
    end
  end
end
