# frozen_string_literal: true

class ProductsController < ApplicationController
  before_action :find_product, only: %i[edit update destroy]
  before_action :build_product, only: %i[new create]

  def index
    @products = Product.all
  end

  def create
    @product.assign_attributes(product_params)
    if @product.save
      redirect_to products_path
    else
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :price)
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def build_product
    @product = Product.new
  end
end
