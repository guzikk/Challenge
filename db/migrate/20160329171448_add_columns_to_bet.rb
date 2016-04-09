class AddColumnsToBet < ActiveRecord::Migration
  def change
    add_column :bets, :invitation, :string
    add_column :bets, :video_url, :string
    add_reference :bets, :user_winner, index: true
    add_column :bets, :status, :integer
  end
end
