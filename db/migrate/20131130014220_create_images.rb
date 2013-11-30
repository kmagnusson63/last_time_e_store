class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :filename
      t.string :location
      t.integer :images_id
      t.integer :products_id

      t.timestamps
    end
  end
end
