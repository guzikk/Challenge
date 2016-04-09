class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.string :name
      t.text :description
      t.integer :credit
      t.attachment :proof
      t.boolean :active
      t.datetime :end_date_of_challenge
      t.references :user_owner, index: true
      t.references :user_participant, index: true

      t.timestamps null: false
    end
  end
end
