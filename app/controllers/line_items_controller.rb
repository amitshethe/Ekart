# frozen_string_literal: true

class LineItemsController < ApplicationController
  before_action :find_item, only: %i[destroy add_quantity reduce_quantity]

  def create
    line_item = update_line_item_details 
    if line_item.save
      redirect_to cart_path(@current_cart)
    else
      redirect_to request.referrer, alert: "Please try again"
    end
  end

  def destroy
    @line_item.destroy
    redirect_to cart_path(@current_cart)
  end

  def add_quantity
    @line_item.quantity ||= 0
    @line_item.quantity += 1
    if @line_item.update(:quantity => @line_item.quantity)
      redirect_to cart_path(@current_cart)
    else
      redirect_to request.referrer, alert: "Quantity did not add"
    end
  end

  def reduce_quantity
    if @line_item.quantity == 1
      @line_item.destroy
      redirect_to request.referrer
    else
      @line_item.quantity -= 1 if @line_item.quantity > 1
      if @line_item.update(:quantity => @line_item.quantity)
        redirect_to cart_path(@current_cart)
      else
        redirect_to request.referrer, alert: "Quantity did not reduced"
      end
    end
  end

  private

  def line_item_params
    params.require(:line_item).permit(:quantity, :product_id, :cart_id)
  end

  def find_item
    @line_item = LineItem.find(params[:id])
  end

  def update_line_item_details 
    chosen_product = Product.find(params[:product_id])
    if @current_cart.products.include?(chosen_product)
      @line_item = @current_cart.line_items.find_by(product_id: chosen_product)
      @line_item.quantity += 1
    else
      @line_item = LineItem.new
      @line_item.cart = @current_cart
      @line_item.product = chosen_product
      @line_item.quantity = 1
    end
    @line_item
  end
end