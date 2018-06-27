class PlanetsController < ApplicationController
  require 'date'
  helper_method :set_current_sign

  def index
    @planets = Planet.all
    @current_time = Time.new
    @planets.each do |planet|
      planet.set_current_sign
      planet.set_changes_sign_at
    end
  end

  def update
    @planets = Planet.all
    redirect_to root_path
  end

end
