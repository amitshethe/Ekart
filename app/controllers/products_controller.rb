class ProductsController < ApplicationController
  before_action :find_Product_ID, only: %i[ edit update destroy]
  before_action :build_Product, only: %i[new create]

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

  def find_Product_ID
    @product = Product.find(params[:id])
  end

  def build_Product
    @product = Product.new
  end
end
