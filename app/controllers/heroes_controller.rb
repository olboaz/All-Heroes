class HeroesController < ApplicationController
skip_before_action :authenticate_user!, only: [:index, :show]

def index
  if params[:name]
    sql_query = "name ILIKE :name AND latitude IS NOT NULL AND longitude IS NOT NULL"
    @heroes = policy_scope(Heroe.geocoded).where(sql_query, name: "%#{params[:name]}%") # renvoit tous les héros geocded
  else
    @heroes = policy_scope(Heroe.geocoded) # renvoit tous les héros geocoded
  end

  @markers = @heroes.map do |heroe|
    {
      lat: heroe.latitude,
      lng: heroe.longitude,
      infoWindow: render_to_string(partial: "info_window", locals: { heroe: heroe }),
      image_url: helpers.asset_url('superhero.svg')
    }
  end
end

def show
  @heroe = Heroe.find(params[:id])
  authorize @heroe
end

def new
  @heroe = Heroe.new
  authorize @heroe
end

def create
  @heroe = Heroe.new(heroe_params)
    authorize @heroe
    @heroe.user = current_user
    if @heroe.save
      redirect_to heroe_path(@heroe)
    else
      render :new
    end
end

def edit
  @heroe = Heroe.find(params[:id])
  authorize @heroe
end

def update
  @heroe = Heroe.find(params[:id])
  authorize @heroe
  @heroe.user = current_user
  @heroe.update(heroe_params)
  if @heroe.save
    redirect_to heroe_path(@heroe)
  else
    render :new
  end
end

private

def heroe_params
    params.require(:heroe).permit(:name, :description, :address, :heigth, :weight, :image_hero, photos: [])
end

end
