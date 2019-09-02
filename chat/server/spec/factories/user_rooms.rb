FactoryBot.define do
  factory :user_room do
    user {build(:user)}
    room {build(:room)}
  end
end
