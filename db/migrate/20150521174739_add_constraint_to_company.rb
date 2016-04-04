class AddConstraintToCompany < ActiveRecord::Migration
  def change
    change_column :companies, :company_name, :string, null: false
  end
end
