class RemoveEndDateFromLotteries < ActiveRecord::Migration
  def change
    remove_column :lotteries, :end_date, :datetime
  end
end
