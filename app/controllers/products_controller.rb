class ProductsController < ApplicationController
  before_action :intialize_Product_ID, only: %i[ edit update destroy]
  before_action :intialize_Product_object, only: %i[new create]

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

  def intialize_Product_ID
    @product = Product.find(params[:id])
  end

  def intialize_Product_object
    @product = Product.new
  end
end
