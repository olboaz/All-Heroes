class ReviewsController < ApplicationController

  def new
    @heroe = Heroe.find(params[:hero_id])
    @review = Review.new
    authorize @review
  end

  def create
    @review = Review.new(review_params)
    authorize @review
    @heroe = Heroe.find(params[:hero_id])
    @review.user = current_user
    @review.heroe = @heroe
    if @review.save
      redirect_to hero_path(@heroe)
    else
      flash[:alert] = "Something do not work"
      render :new
    end
  end

  def destroy
    @review = Review.find(params[:id])
    authorize @review
    @review.destroy
    redirect_to hero_path(@review.heroe)
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

end
