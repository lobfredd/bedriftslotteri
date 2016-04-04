class AddImgToContactForm < ActiveRecord::Migration
  def change
    add_attachment :contactforms, :img
    remove_column :contactforms, :img_url, :string
  end
end
