class PlanetsController < ApplicationController
  require 'date'
  helper_method :set_current_sign

  def index
    @planets = Planet.all
    t = Time.new
    @current_time = t.getlocal
    @planets.each do |planet|
      planet.set_current_sign
    end
  end

  def update
    @planets = Planet.all
    redirect_to root_path
  end



  def changes_sign_at(planet)
    # Algorithm
    # Compute the sign that the planet is in at time_counter (starting at Time.new).
    # Check if it matches the current *current_sign* in db.
    # If not, update changes_sign_at with time_counter.
    # If so, update time_counter accordingly and repeat.
    # Possibly need to compute the velocity using swe4r too if I want to adjust time_counter with the appropriate step.
  end

end
