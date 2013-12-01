class StoreController < ApplicationController

  def index
  	@categories = Category.all
  	@products = Product.all
  	@navbar = NavBar.all
  end
end
