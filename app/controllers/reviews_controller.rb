class ReviewsController < ApplicationController

  def new
    @heroe = Heroe.find(params[:heroe_id])
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @heroe = Heroe.find(params[:heroe_id])
    @review.heroe = @heroe
    if @review.save
      redirect_to heroe_path(@heroe)
    else
      render new
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy
    redirect_to heroe_path(@review.heroe)
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

end
