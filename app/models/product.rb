class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :manufacturer
  has_many :images
  validates :name, :price,:sku, :presence =>true
end
