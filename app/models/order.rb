class Order < ActiveRecord::Base
  belongs_to :customer
  belongs_to :address
  has_many :line_items
  validates :customer_id, :address_id, :presence => true
end
