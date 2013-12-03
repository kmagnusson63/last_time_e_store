class Image < ActiveRecord::Base
  belongs_to :product
  validates :filename, :location, :products_id, :presence => true
end
