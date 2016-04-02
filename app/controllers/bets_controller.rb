class BetsController < ApplicationController
  
  before_action :check_finished
  before_action :set_bet, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :finished]
  

  layout 'bootstrap'

  def check_finished
    current_date = DateTime.now
    bet = Bet.all
    bet.each do |t|
      if current_date.to_date == t.end_date_of_challenge.to_date
        t.status = 0
        t.save
      end
    end
  end

  def index
  	@bets = Bet.active
    @current_date = DateTime.now
  end

  def finished
    @bets = Bet.finished
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
      BetMailer.welcome_email(@bets).deliver if !@bets.invitation.empty?
      redirect_to action: 'index'
  	else
  		redirect_to 'new'	
  	end	
  end	

  def show
  	@bets = Bet.find(params[:id])
    @post = Post.new
  end

  def edit
  end

  def join
    @bets = Bet.find(params[:id])
    @bets.user_participant_id = current_user.id
    @bets.save
    @post = Post.new
    render :show
  end

  def update
    if	@bets.update(bet_params)
  	  BetMailer.welcome_email(@bets).deliver if !@bets.invitation.empty?
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
  	params.require(:bet).permit(:name, :description, :image, :user_owner_id, :user_participant_id, :end_date_of_challenge, :invitation)
  end

end
