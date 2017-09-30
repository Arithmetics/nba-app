class BetsController < ApplicationController
  before_action :admin_user, only: [:create, :edit, :destroy, :new]


  def index
    @bet = Bet.new
    @bets = Bet.all
  end

  def create
    @bet = Bet.new(bet_params)
    if @bet.save
      flash[:success] = "Bet created!"
      redirect_to bets_path
    else
      flash[:danger] = "No bet created!"
      redirect_to bets_path
    end
  end

  def edit
    @bet = Bet.find(params[:id])
  end

  def update
    @bet = Bet.find(params[:id])
    if @bet.update_attributes(bet_params)
      flash[:success] = "Bet updated"
      redirect_to bets_path
    else
      render 'edit'
    end
  end

  def destroy
    @bet = Bet.find_by(id: params[:id])
    bet_deleted = @bet.title
    @bet.destroy
    flash[:success] = "Bet: #{bet_deleted} deleted"
    redirect_to bets_path
  end

  def new
    @bet= Bet.new
  end
########################################################################


  private

    def bet_params
      params.require(:bet).permit(:title, :benchmark, :locked)
    end

end
