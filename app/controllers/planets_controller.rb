class PlanetsController < ApplicationController
  require 'date'

  def index
    @planets = Planet.all
    @current_time = Time.new
  end


  def current_time
    return Time.now
  end

end
