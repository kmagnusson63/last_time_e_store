class State < ActiveRecord::Base
  has_many :addresses
  validates :name, :tax_rate, :presence => true
end
