class HeroesController < ApplicationController
skip_before_action :authenticate_user!, only: [:index, :show]

def index
  @heroes = Heroe.geocoded # renvoir tous les héros geocded

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

end
