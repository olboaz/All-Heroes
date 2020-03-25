class HeroesController < ApplicationController

def index
  @heroes = Heroe.all
end

def show
  @heroe = Heroe.find(params[:id])
end

end
