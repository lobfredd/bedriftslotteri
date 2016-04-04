class RemoveColumnsFromLotteryUsers < ActiveRecord::Migration
  def change
    remove_column :lottery_users, :won, :integer
    remove_column :lottery_users, :tickets_bought, :integer
  end
end
