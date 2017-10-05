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


Bet.create!(title: "Atlanta Hawks",
            benchmark: 25.5,
            locked: false)


Bet.create!(title: "Boston Celtics",
            benchmark: 55.5,
            locked: false)

Bet.create!(title: "Brooklyn Nets",
            benchmark: 27.7,
            locked: true)

Bet.create!(title: "Charlotte Hornets",
            benchmark: 42.5,
            locked: false)


Bet.create!(title: "Chicago Bulls",
            benchmark: 22,
            locked: false)

Bet.create!(title: "Cleveland Cavaliers",
            benchmark: 53.5,
            locked: true)


Bet.create!(title: "Dallas Mavericks",
            benchmark: 35.5,
            locked: true)

Bet.create!(title: "Seattle Mariners",
            benchmark: 88,
            locked: true)

Bet.create!(title: "Denver Nuggets",
            benchmark: 45.5,
            locked: false)


Bet.create!(title: "Detroit Pistons",
            benchmark: 38.5,
            locked: false)

Bet.create!(title: "Golden State Warriors",
            benchmark: 67.5,
            locked: true)

Bet.create!(title: "Houston Rockets",
            benchmark: 55.5,
            locked: false)


Bet.create!(title: "Indiana Pacers",
            benchmark: 31.5,
            locked: false)

Bet.create!(title: "Los Angeles Clippers",
            benchmark: 43.5,
            locked: true)


Bet.create!(title: "Los Angeles Lakers",
            benchmark: 33.5,
            locked: true)

Bet.create!(title: "Memphis Grizzlies",
            benchmark: 37.5,
            locked: true)

Bet.create!(title: "Miami Heat",
            benchmark: 43.5,
            locked: true)


Bet.create!(title: "Milwaukee Bucks",
            benchmark: 47.5,
            locked: true)

Bet.create!(title: "Minnesota Timberwolves",
            benchmark: 48.5,
            locked: true)


Bet.create!(title: "New Orleans Pelicans",
            benchmark: 39.5,
            locked: true)

Bet.create!(title: "New York Knicks",
            benchmark: 30.5,
            locked: true)


Bet.create!(title: "Oklahoma City Thunder",
            benchmark: 50.5,
            locked: true)

Bet.create!(title: "Orlando Magic",
            benchmark: 33.5,
            locked: true)

Bet.create!(title: "Philadelphia 76ers",
            benchmark: 41.5,
            locked: true)


Bet.create!(title: "Phoenix Suns",
            benchmark: 29,
            locked: true)

Bet.create!(title: "Portland Trail Blazers",
            benchmark: 42.5,
            locked: true)

Bet.create!(title: "Sacramento Kings",
            benchmark: 27.5,
            locked: true)

Bet.create!(title: "San Antonio Spurs",
            benchmark: 54.5,
            locked: true)


Bet.create!(title: "Toronto Raptors",
            benchmark: 48.5,
            locked: true)

Bet.create!(title: "Utah Jazz",
            benchmark: 41,
            locked: true)

Bet.create!(title: "Washington Wizards",
            benchmark: 48,
            locked: true)


#set up variables
@users = User.all
@bets = Bet.all
bet_ids = (1..30).to_a

#give each better 5 super bets and 5 regular votes
@users.each do |user|
  selected_bets = @bets.shuffle[0..9]

  super_bets = selected_bets[0..4]
  reg_bets = selected_bets[5..9]

  super_bets.each do |bet|
    user.picks.create!(title: bet.title,
                       benchmark: bet.benchmark,
                       locked: bet.locked,
                       super: true,
                       bet_id: bet.id,
                       selection: ["under", "over"].sample)
  end

  reg_bets.each do |bet|
    user.picks.create!(title: bet.title,
                       benchmark: bet.benchmark,
                       locked: bet.locked,
                       super: false,
                       bet_id: bet.id,
                       selection: ["under", "over"].sample)
  end

end
