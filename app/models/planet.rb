class Planet < ApplicationRecord
  attr_accessor :current_sign

  def set_current_sign
    current_longitude = current_longitude_of(self)
    @current_sign = longitude_to_sign(current_longitude)
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

  def longitude_to_sign(longitude)
    sign_ordinal = longitude.divmod(30)
    sign = nil
    case sign_ordinal[0]
    when 0
      sign = :Aries
    when 1
      sign = :Taurus
    when 2
      sign = :Gemini
    when 3
      sign = :Cancer
    when 4
      sign = :Leo
    when 5
      sign = :Virgo
    when 6
      sign = :Libra
    when 7
      sign = :Scorpio
    when 8
      sign = :Sagittarius
    when 9
      sign = :Capricorn
    when 10
      sign = :Aquarius
    when 11
      sign = :Pisces
    else
      sign = nil
    end
    return sign
  end

  
end
