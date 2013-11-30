class CreateManufacturers < ActiveRecord::Migration
  def change
    create_table :manufacturers do |t|
      t.string :name
      t.integer :address_id
      t.string :email
      t.string :phone_number
      t.string :contact_name

      t.timestamps
    end
  end
end
