class Image < ActiveRecord::Base
  belongs_to :image
  belongs_to :product
  has_many :images
  validates :filename, :location, :product_id, :presence => true
end
