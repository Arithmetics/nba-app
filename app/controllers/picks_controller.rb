class PicksController < ApplicationController
before_action :logged_in_user, only: [:create, :destroy]
before_action :correct_user, only: :destroy

  def new
    @bets = Bet.all
    @pick = Pick.new
  end

  def create

  end

  def destroy
    if !@pick.locked?
      @pick.destroy
      flash[:success] = "Pick deleted"
      redirect_to request.referrer || root_url
    else
      flash[:danger] = "Pick is locked, sorry!"
      redirect_to user_url
    end
  end

  def index
    @picks = Pick.all
    @users = User.all
  end






 ###########################################################3

  private

    def pick_params
      params.require(:pick).permit(:title, :benchmark, :locked, :super, :bet_id,
                                   :user_id, :selection)
    end

    def correct_user
      @pick = current_user.picks.find_by(id: params[:id])
      redirect_to root_url if @pick.nil?
    end





end
