class CartsController < ApplicationController
  before_action :intialize_Cart_Object, only: %i[show destroy]

  def destroy
    @cart.destroy
    session[:cart_id] = nil
    redirect_to root_path
  end

  private 
  def intialize_Cart_Object
    @cart = @current_cart
  end
end
