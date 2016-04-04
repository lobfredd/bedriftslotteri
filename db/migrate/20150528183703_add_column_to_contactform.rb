class AddColumnToContactform < ActiveRecord::Migration
  def change
    add_column :contactforms, :email, :string
  end
end
