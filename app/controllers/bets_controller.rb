class BetsController < ApplicationController
  before_action :set_bet, only: [:show, :edit, :update, :destroy]

  def index
  	@bets = Bet.all
  	@bet = "aaas"
  end

  def new
	@bets = Bet.new  
  end

  def create
  	@bets = Bet.new(bet_params)
  	if @bets.save!
  		redirect_to @bets
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
  	params.require(:bet).permit(:name, :description, :user_1_id, :user_2_id, :credit, :image)
  end

end
