class RemoveFieldsFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :username, :string
    remove_column :users, :adress, :string
    remove_column :users, :zipcode, :string
    remove_column :users, :county, :string
    remove_column :users, :phone, :integer
  end
end
