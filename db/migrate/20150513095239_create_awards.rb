class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.references :lottery_id
      t.string :name
      t.integer :quantity
      t.string :image_url

      t.timestamps null: false
    end
  end
end
