class RemoveColoumnsFromLotteries < ActiveRecord::Migration
  def change
    remove_column :lotteries, :won
    remove_column :lotteries, :tickets_bought
  end
end
