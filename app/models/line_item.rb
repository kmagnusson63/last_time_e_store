class LineItem < ActiveRecord::Base
  belongs_to :products
  belongs_to :orders
  validates :product_id, :order_id, :quantity, :price, :presence => true
end
