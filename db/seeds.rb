# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'

# Create Users
5.times do
    User.create!(
      username: Faker::Name.name,
      email: Faker::Internet.email,
      password: 'password',
      confirmed_at: Time.now,
      role: 'standard'
    )
end
users = User.all
puts "#{User.count} users created."

# Create Admin
unless User.find_by(email: "rosswaguespack@gmail.com")
  admin = User.create!(
    username: "Wagues23",
    email: "rosswaguespack@gmail.com",
    password: "password",
    confirmed_at: Time.now,
    role: 'admin'
  )
  puts "created Admin User."
  puts "Email: #{admin.email} Password: #{admin.password}"
else
  puts "Skipped creation of \"rosswaguespack@gmail.com\""
end

# Create Wikis
20.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body:  Faker::Lorem.paragraph(3),
    user:  users.sample
  )
end
puts "#{Wiki.count} wikis created."
