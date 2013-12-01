class Image < ActiveRecord::Base
  has_many :images
  belongs_to :image
  belongs_to :product
  validates :filename, :location, :products_id, :presence => true
end
