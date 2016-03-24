class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.string :name
      t.text :description
      t.references :user_1, index: true, foreign_key: true
      t.references :user_2, index: true, foreign_key: true
      t.integer :credit
      t.attachment :image

      t.timestamps null: false
    end
  end
end
