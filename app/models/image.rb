class Image < ActiveRecord::Base
  belongs_to :product
  validates :filename, :product_id, :presence => true
end
