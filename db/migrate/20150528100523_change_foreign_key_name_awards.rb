class ChangeForeignKeyNameAwards < ActiveRecord::Migration
  def change
    rename_column :awards, :lottery_id_id, :lottery_id
  end
end
