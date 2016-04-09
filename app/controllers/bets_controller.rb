class BetsController < ApplicationController
  
  before_action :check_finished
  before_action :set_bet, only: [:show, :edit, :update, :join]
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

    #adding or removing credit for users
    bets = Bet.finished
    bets.each do |t|
      if t.active == true && !t.user_winner_id.blank?
        if t.user_owner_id == t.user_winner_id
          t.user_owner.credit = t.user_owner.credit + t.credit
          t.user_participant.credit = t.user_participant.credit - t.credit
          t.active = false
          t.save
          t.user_owner.save
          t.user_participant.save
        elsif t.user_participant_id == t.user_winner_id
          t.user_participant.credit = t.user_participant.credit + t.credit
          t.user_owner.credit = t.user_owner.credit - t.credit
          t.active = false
          t.save
          t.user_participant.save
          t.user_owner.save
        end
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
    @bets = Bet.my_bets_owner(current_user)
    @bets_participant = Bet.my_bets_participant(current_user)
    @current_date = DateTime.now
  end

  def inactive
    @bets = Bet.inactive(current_user)
    @current_date = DateTime.now
    render :index
  end

  def create
    
  	@bets = Bet.new(bet_params)
    @bets.user_owner = current_user 
  	if @bets.save!

      BetMailer.welcome_email(@bets).deliver if !@bets.invitation.empty?
      redirect_to action: 'index'
  	else
  		redirect_to 'new'	
  	end	
  end	

  def show
  	@post = Post.new
  end

  def edit
  end

  def join #join to challenge
    if @bets.status == 1 && @bets.active == true && @bets.user_owner_id != current_user.id
       @bets.user_participant_id = current_user.id
       @bets.save
    else
      flash[:notice] = "I'm sorry you can't join to this challenge"
    end
    @post = Post.new
    render :show
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
  	params.require(:bet).permit(:name, :description, :image, :user_owner_id, :user_participant_id, :end_date_of_challenge, :invitation, :status, :proof, :video_url, :credit)
  end

end
