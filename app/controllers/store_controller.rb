class StoreController < ApplicationController

  def index
  	@categories = Category.all
  	@products = Product.all
  	@navbar = NavBar.all
  end

  def show

  end

  def search_results
	@categories = Category.all
  	@products = Product.where("name like '%#{params[:keywords]}%'")
  	@navbar = NavBar.all
  end
end
