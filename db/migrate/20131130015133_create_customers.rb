class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :username
      t.string :name
      t.integer :address_id
      t.string :email
      t.string :phone_number

      t.timestamps
    end
  end
end
