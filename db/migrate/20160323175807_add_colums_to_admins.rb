class AddColumsToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :name, :string
    add_column :admins, :surname, :string
    add_column :admins, :credit, :integer
  end
end
