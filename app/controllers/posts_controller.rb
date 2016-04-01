class PostsController < ApplicationController

  def index
  end

  def create
    @post = Post.new(post_params)
    @bet = Bet.find(@post.bet_id)
    @post.save!
    redirect_to @bet
  end

  private

  def post_params
    params.require(:post).permit(:content, :user_id, :bet_id)
  end

end
