class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.decimal :price
      t.string :sku
      t.integer :manufacturer_id
      t.string :category_id

      t.timestamps
    end
  end
end
