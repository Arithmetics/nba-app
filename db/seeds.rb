# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



User.create!(name: "Example User",
             email: "example@railstutorial.org",
             password: "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

10.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end


Bet.create!(title: "Toronto Maple Leafs",
            benchmark: 40.5,
            locked: false)


Bet.create!(title: "San Jose Sharks",
            benchmark: 22,
            locked: false)

Bet.create!(title: "Kansas City Chiefs",
            benchmark: 9.5,
            locked: true)


Bet.create!(title: "Seattle Mariners",
            benchmark: 88,
            locked: true)

@users = User.all
@bets = Bet.all

@users.each do |user|
  @bets.each do |bet|
    user.picks.create!(title: bet.title,
                       benchmark: bet.benchmark,
                       locked: bet.locked,
                       super: [true, false].sample,
                       bet_id: bet.id,
                       selection: ["under", "over"].sample)
  end
end
