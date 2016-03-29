class BetsController < ApplicationController
  before_action :set_bet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :inactive]

  layout 'bootstrap'

  def index
  	@bets = Bet.active
    @current_date = DateTime.now
  	
  end

  def new
    @user = current_user
	@bets = Bet.new  
  end

  def my
    @bets = current_user.bets
    @current_date = DateTime.now
    render :index
  end

  def inactive
    @bets = Bet.inactive
    @current_date = DateTime.now
    render :index
  end

  def create

  	@bets = current_user.bets.new(bet_params)
  	if @bets.save!
  		BetMailer.welcome_email(@bets).deliver
      redirect_to action: 'index'
  	else
  		redirect_to 'new'	
  	end	
  end	

  def show
  	@bets = Bet.find(params[:id])
  end

  def edit
  end

  def update
  	
  if	@bets.update(bet_params)
  	BetMailer.welcome_email(@bets).deliver
		redirect_to @bets
  	else
  		redirect 'new'	
  	end	  		
  end

  private

  def set_bet
      @bets = Bet.find(params[:id])
  end

  def bet_params
  	params.require(:bet).permit(:name, :description, :credit, :image, :user_owner_id, :user_participant_id, :end_date_of_challenge, :invitation)
  end

end
