class PlanetsController < ApplicationController

  def index
    @planet = Planet.all
  end

end
