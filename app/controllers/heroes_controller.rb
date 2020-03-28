class HeroesController < ApplicationController
skip_before_action :authenticate_user!, only: [:index, :show]

def index
  if params[:name]
    sql_query = "name ILIKE :name AND latitude IS NOT NULL AND longitude IS NOT NULL"
    @heroes = Heroe.geocoded.where(sql_query, name: "%#{params[:name]}%") # renvoit tous les héros geocded
  else
    @heroes = Heroe.geocoded # renvoit tous les héros geocded
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
end

private

def heroe_params
    params.require(:heroe).permit(:name, :description, :address, :heigth, :weight, :image_hero)
end

end
