#User
User.create(name: "Minh la Tung", email: "vtungcntt12t1@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  is_admin: true,
  created_at: Time.zone.now)
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "123456"
  User.create(name: name, email: email, password: password,
    password_confirmation: password,
    created_at: Time.zone.now)
end
# Following relationships
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each {|followed| user.follow(followed)}
followers.each {|follower| follower.follow(user)}
