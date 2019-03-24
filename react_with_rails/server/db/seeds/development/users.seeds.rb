user_names = [
  "Iron Man",
  "Captain America",
  "Black Widow",
  "Hulk",
  "HawkEye",
  "Thor",
  "Thanos",
  "Batman",
  "Spiderman",
  "Superman",
]

user_names.each_with_index do |name, i|
  user = User.find_or_initialize_by(mail: "test#{i+1}@example.com", name: name)
  user.save!
end
