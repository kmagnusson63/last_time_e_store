class Category < ActiveRecord::Base
  belongs_to :category
  has_many :categories

  validates :name, :presence => true
end
