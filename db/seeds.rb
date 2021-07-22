20.times do
  email = Faker::Internet.email
  password = 'admin_password123'

  User.create!(email: email, password: password)
end