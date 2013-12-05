class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :order
  validates :product_id, :order_id, :quantity, :price, :presence => true
end
