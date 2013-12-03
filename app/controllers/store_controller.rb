class StoreController < ApplicationController

  def index
    if session[:cart].nil?
      session[:cart] = Array.new
    end
    @categories = Category.find(:all, :order => 'category_id')
  	@products = Product.all
  	@navbar = NavBar.all
  end

  def show
    @categories = Category.all
    @navbar = NavBar.all
    @product = Product.find(params[:id])
  end

  def search_results
	  @categories = Category.all
	  if params[:category].present?
      categ = Category.where("category_id = #{params[:category]}")
      if categ.count > 1
        x = 1
        where_clause = ""
        where_words = ""
        categ.each do |cat|
          if x > 1
            where_clause += " OR "
            where_words += ", "
          end
          where_clause += "category_id = '"
          where_clause += cat[:id].to_s
          where_clause += "'"
          where_words += Category.find(cat[:id]).name
          x += 1
        end
        @products = Product.where(where_clause)
        @keywords = where_words
      elsif categ.count > 0
        @products = Product.where("id = #{category[:id]}")
        @keywords = category[:id].name
      else
        @keywords = Category.where("id = #{params[:category]}").first.name
        @products = Product.all.where("category_id = #{params[:category]}")
      end
    else
      @keywords = params[:keywords]
  	  @products = Product.where("name like '%#{params[:keywords]}%'")
  	end
  	@navbar = NavBar.all
  end
  
  def shopping_cart
    @categories = Category.find(:all, :order => 'category_id')
    @products = Product.all
    @navbar = NavBar.all
    

  end

  def add_to_shopping_cart
    @categories = Category.find(:all, :order => 'category_id')
    @navbar = NavBar.all
   
    session[:cart].push(params[:id])
    
    redirect_to action: 'index'

  end

  def del_from_shopping_cart
    session[:cart] = session[:cart] - [params[:id]]
    redirect_to action: 'index'
  end
end
