# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

users = [
  {name: "大塚", email: "otsuka@example.com", password: "password-00"},
  {name: "うの", email: "uno@example.com", password: "password-00"},
  {name: "太田", email: "ota@example.com", password: "password-00"},
  {name: "清水", email: "shimizu@example.com", password: "password-00"},
]

users.each do |user_attr|
  User.register(user_attr[:name], user_attr[:email],  user_attr[:password])
end

rooms = [
  {
    name: "テクニカル",
    users: ["大塚", "うの", "太田", "清水"],
  },
  {
    name: "哲学科",
    users: ["大塚", "うの", "太田"],
  },
]

rooms.each do |room_attr|
  room = Room.create!(name: room_attr[:name])
  room.users << User.where(name: room_attr[:users])
end
