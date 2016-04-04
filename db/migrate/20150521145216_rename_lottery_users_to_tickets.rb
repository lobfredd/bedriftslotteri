class RenameLotteryUsersToTickets < ActiveRecord::Migration
  def change
    rename_table :lottery_users, :tickets
  end
end
