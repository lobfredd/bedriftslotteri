class AddCompanyRefToLotteries < ActiveRecord::Migration
  def change
    add_reference :lotteries, :company, index: true, foreign_key: true
  end
end
