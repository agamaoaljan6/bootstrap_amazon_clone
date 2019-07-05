class ProductsController < ApplicationController
before_action :authenticate_user!, except: [:index, :show] 
# authenticate_user! is found in application_controller 
before_action :set_products, only: [:edit, :update, :show, :destroy]

  def index
      @products = Product.all
  end
  
  def new 
      @product = Product.new
  end

  def create
      @product = Product.new(product_params)
      @product_user = current_user
      if @product.save
      flash[:success] = "Product was successfully listed!"
      redirect_to product_path(@product)
      else
      @product.errors
      render 'new'
      end
  end
  
  def show
      @review = Review.new
      @reviews = @product.reviews.order(created_at: :desc)
  end

  def edit 
  end

  def update

      if @product.update(product_params)
          flash[:success] = "Product was successfully updated!"
          redirect_to product_path(@product)
      else
          render 'edit'
      end
  end

  def destroy
  @product.destroy
  flash[:danger] = "Product list was successfully deleted!"
  redirect_to products_path
  end

  private

  def product_params
      params.require(:product).permit(:title, :description, :price)
  end

  def set_products
      @product = Product.find(params[:id]) #querying a product
  end
end
