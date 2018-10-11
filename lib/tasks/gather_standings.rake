desc "Fetch current standings"
task :fetch_standings => :environment do

  require 'nokogiri'
  require 'open-uri'

  team_benchmarks = {
                      "Atlanta Hawks" => 22.5/82,
                      "Boston Celtics" => 58.5/82,
                      "Brooklyn Nets" => 31.5/82,
                      "Charlotte Hornets" => 35.5/82,
                      "Chicago Bulls" => 29.5/82,
                      "Cleveland Cavaliers" => 53.5/82,
                      "Dallas Mavericks" => 34.5/82,
                      "Denver Nuggets" => 47.5/82,
                      "Detroit Pistons" => 38.5/82,
                      "Golden State Warriors" => 63.5/82,
                      "Houston Rockets" => 56.5/82,
                      "Indiana Pacers" => 47.5/82,
                      "Los Angeles Clippers" => 36.5/82,
                      "Los Angeles Lakers" => 48.5/82,
                      "Memphis Grizzlies" => 34.5/82,
                      "Miami Heat" => 42.5/82,
                      "Milwaukee Bucks" => 47.5/82,
                      "Minnesota Timberwolves" => 41.5/82,
                      "New Orleans Pelicans" => 45.5/82,
                      "New York Knicks" => 28.5/82,
                      "Oklahoma City Thunder" => 48.5/82,
                      "Orlando Magic" => 30.5/82,
                      "Philadelphia 76ers" => 54.5/82,
                      "Phoenix Suns" => 29.5/82,
                      "Portland Trail Blazers" => 42.5/82,
                      "Sacramento Kings" => 25.5/82,
                      "San Antonio Spurs" => 45.5/82,
                      "Toronto Raptors" => 55.5/82,
                      "Utah Jazz" => 49.5/82,
                      "Washington Wizards" => 45.5/82
                     }

  page = Nokogiri::HTML(open("https://www.basketball-reference.com/leagues/NBA_2019.html"))

  team_names = page.css("th[data-stat='team_name'] a").map do |team_name|
                team_name.text
              end

  wins = page.css("td[data-stat='wins']").map do |win|
           win.text.to_i
         end

  losses = page.css("td[data-stat='losses']").map do |loss|
          loss.text.to_i
        end

  win_loss_pcts = page.css("td[data-stat='win_loss_pct']").map do |per|
                   per.text.to_f
                 end

  ids = (0..29).to_a

  ids.each do |id|
    if Standing.where(team_name: team_names[id], games_played: (wins[id]+losses[id])).empty?
       #create standing value
       Standing.create!(
         team_name: team_names[id], games_played: (wins[id]+losses[id]),
         wins: wins[id], losses: losses[id], win_loss_pct: win_loss_pcts[id])
         #create cooresponding graph goal point
         Standing.create!(
           team_name: "#{team_names[id]} Goal", games_played: (wins[id]+losses[id]),
           wins: wins[id], losses: losses[id], win_loss_pct: team_benchmarks[team_names[id]])
    end
  end



end
