class PlanetsController < ApplicationController
  require 'date'

  def index
    @planets = Planet.all
    @current_time = Time.new
    @planets.each do |planet|
      planet.set_current_sign
      planet.set_changes_sign_at
      if planet.name != "Sun"
        planet.set_is_retrograde
      end
      planet.save
    end
  end

  def update
    @planets = Planet.all
    redirect_to root_path
  end

end
