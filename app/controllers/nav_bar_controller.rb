class NavBarController < ApplicationController
	def index
		@page = NavBar.where(:permalink => params[:permalk]).first
		@parm = params[:permalk]
		@categories = Category.all
		@navbar = NavBar.all
		@cart_products = Product.all
	end
end
