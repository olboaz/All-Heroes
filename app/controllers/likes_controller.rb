class LikesController < ApplicationController
  before_action :find_heroe
  before_action :find_like, only: [:destroy]

  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      flash[:success] = 'Thanks for liking!'
      authorize @heroe.likes.create(user_id: current_user.id)
    end
    redirect_to hero_path(@heroe)
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      authorize @like.destroy
    end
    redirect_to hero_path(@heroe)
  end

  private

  def find_heroe
    @heroe = Heroe.find(params[:hero_id])
  end

  def find_like
    @like = @heroe.likes.find(params[:id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, heroe_id: params[:hero_id]).exists?
  end

end
