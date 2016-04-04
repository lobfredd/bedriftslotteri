class ChangeColumnType < ActiveRecord::Migration

  def change
    change_table :users do |t|
    t.change :zipcode, :string
    end
  end
end
