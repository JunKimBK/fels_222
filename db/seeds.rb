#User
User.create(name: t"admin", email: t"email_admin",
  password: t"password",
  password_confirmation: t"password",
  is_admin: true,
  activated: true,
  activated_at: Time.zone.now)
99.times do |n|
  name = Faker::Name.name
  email = t"email_correct"
  password = t"password"
  User.create(name: name, email: email, password: password,
    password_confirmation: password,
    activated: true, activated_at: Time.zone.now)
end
