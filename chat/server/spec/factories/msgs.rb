FactoryBot.define do
  factory :msg do
    content {"Hello World"}
    user {build(:user)}
    room {build(:room)}
  end
end
