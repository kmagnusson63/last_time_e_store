class Image < ActiveRecord::Base
  belongs_to :product
  validates :filename, :products_id, :presence => true
end
