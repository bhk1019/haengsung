class Planet < ApplicationRecord
  attr_accessor :current_sign

  def set_current_sign
    @current_sign = longitude_to_sign(self.current_longitude)
  end

  def set_changes_sign_at
    step = 3600
    steps_until_change = 0
    @changes_sign_at = Time.new
    initial_longitude = self.current_longitude
    until @current_sign != longitude_to_sign(initial_longitude) do  
      @changes_sign_at += step
      initial_longitude = longitude_at(@changes_sign_at)
    end
  end

  def longitude_at(time)
    year = time.year
    month = time.month
    day = time.day
    min_as_fraction = time.min / 60.0
    hour = time.hour + min_as_fraction
    jd = Swe4r::swe_julday(year, month, day, hour)
    body = Swe4r::swe_calc_ut(jd, self.swe_id, Swe4r::SEFLG_MOSEPH)
    return body[0]
  end

  def current_longitude
    self.longitude_at(Time.new)
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

  def current_degree
    current_degree = self.current_longitude.divmod(30)
    return current_degree[1].round
  end

  def next_sign
    return longitude_to_sign(self.current_longitude + 30)
  end

  def is_retrograde?
    now = Time.new
    one_minute_from_now = now + 60
    return self.longitude_at(now) > self.longitude_at(one_minute_from_now)
  end

end
