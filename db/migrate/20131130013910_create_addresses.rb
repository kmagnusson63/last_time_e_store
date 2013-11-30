class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :city
      t.integer :state_id
      t.string :country
      t.string :zip_code

      t.timestamps
    end
  end
end
