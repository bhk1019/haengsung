class PlanetsController < ApplicationController
  require 'date'

  def index
    @planets = Planet.all
    @current_time = Time.new
    @planets.each do |planet|
      if planet.current_sign.nil? || planet.changes_sign_at.nil? || planet.changes_sign_at < @current_time
        planet.set_current_sign
        planet.set_changes_sign_at
        planet.save
      end
      if planet.name != "Sun" && planet.name != "Moon"
        if  planet.is_retrograde.nil? || planet.next_station.nil? || planet.next_station < @current_time
          planet.set_is_retrograde
          planet.set_next_station
          planet.save
        end
      end
      planet.save
    end
  end

  def update
    @planets = Planet.all
    redirect_to root_path
  end

end
