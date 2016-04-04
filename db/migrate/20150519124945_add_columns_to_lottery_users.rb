class AddColumnsToLotteryUsers < ActiveRecord::Migration
  def change
    add_column :lottery_users, :won, :integer
    add_column :lottery_users, :tickets_bought, :integer
  end
end
