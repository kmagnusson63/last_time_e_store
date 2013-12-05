class AddTaxRateToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :tax_rate, :decimal
  end
end
