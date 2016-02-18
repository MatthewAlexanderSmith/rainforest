class ReviewsController < ApplicationController
  before_action :load_product
  before_action :ensure_logged_in, only: [:create, :destroy]

  def show
    @review = Review.find(params[:id])
  end

  def create
    @review = @product.reviews.build(review_params)
    @review.user = current_user

    respond_to do |format|
      if @review.save
        format.html { redirect_to  product_url(@product.id), notice: 'Review added.'}
        format.js {} # This will look for app/views/reviews/create.js.erb
      else
        format.html {render 'products/show', alert: 'There was an error.'}
        format.js {} # This will look for app/views/reviews/create.js.erb
      end
    end

  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to :back
  end


  private

  def review_params
    params.require(:review).permit(:comment, :product_id)
  end

  def load_product
    @product = Product.find(params[:product_id])
  end

end
