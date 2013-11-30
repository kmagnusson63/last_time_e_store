class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :address_id
      t.decimal :amount_paid
      t.integer :customer_id

      t.timestamps
    end
  end
end
