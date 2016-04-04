class CreateContactforms < ActiveRecord::Migration
  def change
    create_table :contactforms do |t|
      t.string :name
      t.string :subject
      t.string :img_url
      t.text :message

      t.timestamps null: false
    end
  end
end
