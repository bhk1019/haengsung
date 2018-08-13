class Planet < ApplicationRecord

  def set_current_sign
    self.current_sign = longitude_to_sign(self.current_longitude)
  end

  def next_sign_change_from(time)
    step = 60
    now = time
    one_step_from_now = now + step
    initial_longitude = longitude_at(one_step_from_now)
    while self.current_sign == longitude_to_sign(initial_longitude).to_s do
      one_step_from_now += step
      initial_longitude = longitude_at(one_step_from_now)
    end
    return one_step_from_now
  end

  def set_changes_sign_at
    self.changes_sign_at = self.next_sign_change_from(Time.new)
  end

  def sign_at(time)
    return longitude_to_sign(self.longitude_at(time))
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

  def is_retrograde_at(time)
    now = time
    one_minute_from_now = now + 60
    return self.longitude_at(now) > self.longitude_at(one_minute_from_now)
  end

  def is_direct_at(time)
    return !self.is_retrograde_at(time)
  end

  def is_retrograde?
    return self.is_retrograde_at(Time.now)
  end

  def is_direct?
    return self.is_direct_at(Time.now)
  end

  def set_is_retrograde
    self.is_retrograde = self.is_retrograde?
  end

  def next_station_from(time)
    step = 60
    now = time
    one_step_from_now = now + step
    original_direction = self.is_direct_at(now)
    current_direction = original_direction
    while current_direction == original_direction do
      current_direction = self.longitude_at(one_step_from_now) > self.longitude_at(now)
      now = one_step_from_now
      one_step_from_now = now + step
    end
    return one_step_from_now
  end

  def set_next_station
    self.next_station = self.next_station_from(Time.now)
  end



end
