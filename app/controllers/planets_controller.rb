class PlanetsController < ApplicationController
  require 'date'
  helper_method :set_current_sign

  def index
    @planets = Planet.all
    @current_time = Time.new
  end

  def update
    @planets = Planet.where("changes_sign_at < ?", Time.new)
    @planets.each do |planet|
      planet.update_attribute(:current_sign => 'Aries')
    end
    redirect_to root_path
  end

  def current_longitude_of(planet)
    current_time = Time.new
    year = current_time.year
    month = current_time.month
    day = current_time.day
    hour = current_time.hour
    jd = Swe4r::swe_julday(year, month, day, hour)
    body = Swe4r::swe_calc_ut(jd, planet.swe_id, Swe4r::SEFLG_MOSEPH)
    return body[0]
  end

  def longitude_to_sign_orb(longitude)
    sign_orb_array = longitude.divmod(30)
    sign_number = sign_orb_array[0]
    case sign_number
    when 0
      sign_orb_array[0] = 'Aries'
    when 1
      sign_orb_array[0] = 'Taurus'
    when 2
      sign_orb_array[0] = 'Gemini'
    when 3
      sign_orb_array[0] = 'Cancer'
    when 4
      sign_orb_array[0] = 'Leo'
    when 5
      sign_orb_array[0] = 'Virgo'
    when 6
      sign_orb_array[0] = 'Libra'
    when 7
      sign_orb_array[0] = 'Scorpio'
    when 8
      sign_orb_array[0] = 'Sagittarius'
    when 9
      sign_orb_array[0] = 'Capricorn'
    when 10
      sign_orb_array[0] = 'Aquarius'
    when 11
      sign_orb_array[0] = 'Pisces'
    else
      sign_orb_array[0] = nil
    end
    return sign_orb_array
  end

end
