# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..5).each do |i|
  pp User.create(
    name: "user#{i}",
    email: "email#{i}@email.com",
    password: "password",
  )
end

User.all.each do |user|
  (1..5).each do |i|
    pp user.environments.create(
      situation: "#{user.name}のケース#{i}",
    )
  end
end