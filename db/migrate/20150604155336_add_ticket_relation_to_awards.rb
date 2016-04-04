class AddTicketRelationToAwards < ActiveRecord::Migration
  def change
    remove_column :awards, :image_url, :string
    remove_column :awards, :quantity, :integer
    add_reference :awards, :ticket, index: true, foreign_key: true
  end
end
