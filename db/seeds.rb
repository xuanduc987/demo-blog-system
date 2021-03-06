# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(name: "Duc Nghiem Xuan", email: "xuanduc987@gmail.com",
             password: "password", password_confirmation: "password")

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

users = User.order(:created_at).take(6)

50.times do
  title = Faker::Lorem.sentence
  content = Faker::Lorem.paragraph(55)
  comment = Faker::Lorem.sentence(5)
  users.each do |u|
    entry = u.entries.create!(title: title, content: content)
    u.comments.create!(entry_id: entry.id, content: comment)
    20.times do
      u.followers.take(5).each do |follower|
        follower.comments.create!(entry_id: entry.id,
                                  content: Faker::Lorem.sentence(5))
      end
    end
  end
end
