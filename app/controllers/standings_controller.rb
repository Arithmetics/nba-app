class StandingsController < ApplicationController
  def index
    @standings = Standing.all
    @atlanta = Standing.where(team_name: "Atlanta Hawks")
    @boston = Standing.where(team_name: "Boston Celtics")
  end

  def show
  end
end
