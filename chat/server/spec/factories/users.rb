FactoryBot.define do
  factory :user do
    name { "IronMan" }
    email { "iron_man@example.com" }
    hashed_password { Digest::SHA256.hexdigest("password-00") }
  end
end
