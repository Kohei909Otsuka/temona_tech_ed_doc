FactoryBot.define do
  factory :unread_msg do
    room {build(:room)}
    user {build(:user)}
    msg {build(:msg, user: user, room: room)}
  end
end
