class AddWonAndTicketsboughtToLotteries < ActiveRecord::Migration
  def change
    add_column :lotteries, :won, :integer
    add_column :lotteries, :tickets_bought, :integer
  end
end
