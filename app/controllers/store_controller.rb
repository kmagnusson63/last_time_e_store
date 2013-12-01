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
	if params[:category].present?
  	  @cat = params[:category]
  	  @products = Product.all.where("category_id = #{params[:category]}")
  	else
  	  #@products = Product.category.where("name = '#{params[:category]}'").all
  	  @products = Product.where("name like '%#{params[:keywords]}%'")
  	end
  	@navbar = NavBar.all
  end

  def list_product_by_category
  	@categories = Category.all
  	@products = Product.where("name like '%#{params[:keywords]}%'")
  	@navbar = NavBar.all

  end
end
