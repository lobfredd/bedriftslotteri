class AddKeyToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :key, :string, null: false
  end
end
