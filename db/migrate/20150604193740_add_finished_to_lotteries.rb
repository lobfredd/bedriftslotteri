class AddFinishedToLotteries < ActiveRecord::Migration
  def change
    add_column :lotteries, :finished, :boolean, default: false, null: false
  end
end
