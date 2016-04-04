class RenameColumnTicketsToNumberOfTicketsInLotteries < ActiveRecord::Migration
  def change
    rename_column :lotteries, :tickets, :number_of_tickets
  end
end
