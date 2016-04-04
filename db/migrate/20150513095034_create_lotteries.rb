class CreateLotteries < ActiveRecord::Migration
  def change
    create_table :lotteries do |t|
      t.string :lottery_name
      t.datetime :start_date
      t.datetime :end_date
      t.integer :tickets
      t.decimal :price_per_ticket

      t.timestamps null: false
    end
  end
end
