class Customer < ActiveRecord::Base
  has_many :orders

  validates :name, :address_id, :email, :username, :presence => true
end
