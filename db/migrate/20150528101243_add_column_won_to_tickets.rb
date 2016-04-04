class AddColumnWonToTickets < ActiveRecord::Migration
  def change
    add_column :tickets, :won, :boolean
  end
end
