class ReviewsController < ApplicationController

  before_filter :authorize

  def create
    @review = Review.new(
      rating: params[:review][:rating],
      description: params[:review][:description],
      product_id: params[:product_id],
      user_id: current_user.id
    )

    if @review.save
      redirect_to "/products/#{params[:product_id]}"
    else
      redirect_to "/products/#{params[:product_id]}"
    end
  end

  def destroy
    Review.destroy(params[:id])
    redirect_to "/products/#{params[:product_id]}"
  end

  private

  def authorize
    unless current_user
      redirect_to '/login'
    end
  end

end
