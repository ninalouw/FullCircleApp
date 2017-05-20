# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
5.times do
  User.create ({first_name: Faker::Name.first_name, last_name: Faker::Name.last_name,
    email: Faker::Internet.email, password: "123"})
  end

  users = User.all

  puts Cowsay.say('Generated 5 users', 'random')


5.times do |i|
  g = Goal.create(id: rand(100) + i, name: Faker::Book.title, minutes:rand(20) + 1, count_consecutive_days_completed: rand(10) + 1,
  latest_date_completed: DateTime.now.to_date,
  user_id: User.first.id )
end

puts Cowsay.say('Generated 5 goals', 'random')
