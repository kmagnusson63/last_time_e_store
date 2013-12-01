class CreateNavBars < ActiveRecord::Migration
  def change
    create_table :nav_bars do |t|
      t.string :title
      t.text :content
      t.string :permalink
      t.integer :order

      t.timestamps
    end
  end
end
