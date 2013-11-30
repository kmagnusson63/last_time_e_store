class StoreController < ApplicationController
  def index
  	@categories = Categories.all
  	@products = Products.all
  end
end
