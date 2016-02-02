class CategoriesController < ApplicationController
  before_action :load_product, only: [:create, :destroy]

  def new
  end

  def create
    @category = @product.categories.build(category_params)

    if @category.save
      redirect_to :back
    else
      render 'product/show'
    end
  end

  def destroy

  end

  private
  def category_params
    require(:category).permit(:tag)
  end

  def load_product
    @product = Product.(params[:product_id])
  end
end
