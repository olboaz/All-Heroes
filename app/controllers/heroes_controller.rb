class HeroesController < ApplicationController
skip_before_action :authenticate_user!, only: [:index, :show]

def index
  @heroes = Heroe.all
end

def show
  @heroe = Heroe.find(params[:id])
end

end
