class Address < ActiveRecord::Base
  has_many :orders
  has_many :customers
  has_many :manufacturers
  belongs_to :state
  validates :street, :city, :state_id, :zip_code, :presence => true
end
