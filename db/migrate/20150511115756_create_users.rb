class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :first_name
      t.string :last_name
      t.string :role
      t.string :email
      t.string :adress
      t.integer :zipcode
      t.string :county
      t.integer :phone
      t.integer :credits

      t.timestamps null: false
    end
  end
end
