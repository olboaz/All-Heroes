class HeroesController < ApplicationController
skip_before_action :authenticate_user!, only: [:index, :show]

def index
  @heroes = Heroe.geocoded # renvoir tous les héros geocded

  @markers = @heroes.map do |heroe|
    {
      lat: heroe.latitude,
      lng: heroe.longitude
    }
  end

end

def show
  @heroe = Heroe.find(params[:id])
end

end
