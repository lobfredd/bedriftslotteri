class CreateLotteryUsers < ActiveRecord::Migration
  def change
    create_table :lottery_users, id: false do |t|
      t.references :lottery, :user
    end
  end
end
