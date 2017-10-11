desc "Fetch current standings"
task :fetch_standings => :environment do

  require 'nokogiri'
  require 'open-uri'

  page = Nokogiri::HTML(open("https://www.basketball-reference.com/leagues/NBA_2018.html"))

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
           wins: wins[id], losses: losses[id], win_loss_pct: win_loss_pcts[id])
    end
  end



end
