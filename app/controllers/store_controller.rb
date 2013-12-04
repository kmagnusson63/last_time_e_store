class StoreController < ApplicationController

  def index
    if session[:cart].nil?
      session[:cart] = Array.new
    end
    @categories = Category.find(:all, :order => 'category_id')
  	@products = Product.all
  	@navbar = NavBar.all
    @cart_products = Product.all
    
  end

  def show
    @categories = Category.all
    @navbar = NavBar.all
    @product = Product.find(params[:id])
    @cart_products = Product.all
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
        if params[:keywords].present?
          @keywords = params[:keywords] + " in " + where_words
          @products = Product.where(where_clause).where("name like '%#{params[:keywords]}%'")
        else
          @products = Product.where(where_clause).all
          @keywords = where_words
        end
      elsif categ.count > 0
        if !params[:category].empty? and !params[:keywords].empty?
          @products = Product.where("id = #{category[:id]}").where("name like '%#{params[:keywords]}%'")
          @keywords = params[:keywords] + " in " + category[:id].name
        else
          @products = Product.where("id = #{category[:id]}")
          @keywords = category[:id].name
        end
      else
        @keywords = Category.where("id = #{params[:category]}").first.name
        @products = Product.all.where("category_id = #{params[:category]}")
      end
    else
      @keywords = params[:keywords]
  	  @products = Product.where("name like '%#{params[:keywords]}%'")
  	end
    

  	@navbar = NavBar.all
    @cart_products = Product.all
  end
  
  def shopping_cart
    @categories = Category.find(:all, :order => 'category_id')
    @products = Product.all
    @navbar = NavBar.all
    @cart_products = Product.all

    if session[:cart].empty?

    else
      if session[:cart].size > 1
        x = 1
        where_string = ""
        session[:cart].each do |line|
          if x > 1
            where_string += " OR "
          end
          where_string += "id = '"
          where_string += line["id"]
          where_string += "'"
          x += 1
        end
        @shopping_cart_products = Product.where(where_string).all
      else
        @shopping_cart_products = Product.find(session[:cart][0]["id"].to_i)
      end
    end
    @shopping_cart_prod = where_string
  end

  def confirm_shopping_cart
    @customer = Customer.new
    @categories = Category.find(:all, :order => 'category_id')
    @products = Product.all
    @navbar = NavBar.all
    @cart_products = Product.all

    if session[:cart].empty?

    else
      if session[:cart].size > 1
        x = 1
        where_string = ""
        session[:cart].each do |line|
          if x > 1
            where_string += " OR "
          end
          where_string += "id = '"
          where_string += line["id"]
          where_string += "'"
          x += 1
        end
        @shopping_cart_products = Product.where(where_string).all
      else
        @shopping_cart_products = Product.find(session[:cart][0]["id"].to_i)
      end
    end
    @shopping_cart_prod = where_string
  end

  def add_to_shopping_cart
    @categories = Category.find(:all, :order => 'category_id')
    @navbar = NavBar.all
    @cart_products = Product.all
   
    session[:cart].push({"id" => params[:format], "quant" => params[:quant]})
    
    redirect_to action: 'index'

  end

  def single_checkout
    @categories = Category.find(:all, :order => 'category_id')
    @navbar = NavBar.all
    @cart_products = Product.all
   
    session[:cart].push({"id" => params[:format], "quant" => 1})
    
    redirect_to action: 'confirm_shopping_cart'

  end

  def del_from_shopping_cart
    session[:cart].reject! {|h| h["id"] == params[:id] }
    redirect_to action: 'index'
  end
  
  def confirm_order
    # this is the last stop to saving order and submitting to payment
    @categories = Category.find(:all, :order => 'category_id')
    @products = Product.all
    @navbar = NavBar.all
    @cart_products = Product.all
    if params[:username].empty? or params[:name].empty? or params[:email].empty? or params[:phone_number].empty? or params[:street].empty? or params[:city].empty? or params[:state].empty? or params[:zip_code].empty?
      redirect_to action: 'confirm_shopping_cart'
    else
      new_address = Address(params[:street], params[:city], params[:state], params[:zip_code])
      new_customer = Customer(params[:username], params[:name], params[:email], params[:phone_number])
    end
  end
end
