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
    @state = State.all

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
    session[:cart] = []
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
    @line_item_products = []
    @subtotal = 0
    session[:cart].each do |line_item|
      product = Product.find(line_item["id"].to_i)
      @line_item_products.push(product)
      @subtotal += (line_item["quant"].to_i * product.price)
    end

    if params[:username].empty? or params[:name].empty? or params[:email].empty? or params[:phone_number].empty? or params[:street].empty? or params[:city].empty? or params[:state].empty? or params[:zip_code].empty?
      redirect_to action: 'confirm_shopping_cart'
    else
      new_address = Address.new(:street => params[:street], :city => params[:city], :state_id => params[:state], :zip_code => params[:zip_code])
      new_address.save!
      new_customer = Customer.new(:username => params[:username], :name => params[:name],:address_id => new_address.id, :email => params[:email], :phone_number => params[:phone_number])
      new_customer.save!
    end
    @tax_rate = State.find(Address.find(new_customer.address_id).state_id).tax_rate
    @tax = @tax_rate.to_f * @subtotal.to_f
    @total = @tax.to_f + @subtotal.to_f 
    session[:customer] = []
    session[:customer] = {:customer => new_customer.id, :address => new_address.id, :subtotal => @subtotal, :tax_rate => @tax_rate}
  end
  def order
    @categories = Category.find(:all, :order => 'category_id')
    @products = Product.all
    @navbar = NavBar.all
    @cart_products = Product.all
    @customer = Customer.find(session[:customer][:customer])
    @address = Address.find(session[:customer][:address])
    @subtotal = session[:customer][:subtotal]
    @tax_rate = session[:customer][:tax_rate]
    @order = Order.new(:customer_id => @customer.id, :address_id => @address.id, :tax_rate => @tax_rate)
    @product = Product.find(session[:cart].first["id"].to_i)
    @order.save!
    @line_item = LineItem.new(:product_id => @product.id, :order_id => @order.id, :quantity => session[:cart].first["quant"].to_i, :price => @product.price)
    @line_item.save!
    session[:cart] = []
  end
end
