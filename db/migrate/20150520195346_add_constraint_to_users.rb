class AddConstraintToUsers < ActiveRecord::Migration
  def change
    change_column :users, :role, :string, null: false, default: "user"
  end
end
