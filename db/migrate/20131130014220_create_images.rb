class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :filename
      t.string :location
      t.integer :image_id
      t.integer :product_id

      t.timestamps
    end
  end
end
