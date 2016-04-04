class AddIdToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :id, :primary_key
  end
end
