class StoreController < ApplicationController
  def index
    @time =  Time.now
    @count = index_visit_count
    @products = Product.order(:title)
    @cart = current_cart
  end

  def index_visit_count
    if session[:counter].nil?
      session[:counter] = 0
    end
    session[:counter] += 1
  end
end
