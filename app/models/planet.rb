class Planet < ApplicationRecord
  attr_accessor :current_sign

  def set_current_sign
    @current_sign = longitude_to_sign(self.current_longitude)
  end

  def set_changes_sign_at
    time_step = 86400
    changes_sign_at = Time.new
    next_sign = self.current_sign
    while next_sign == self.current_sign
      next_sign = longitude_to_sign(self.longitude_at(changes_sign_at + time_step))
      if next_sign != self.current_sign
        time_step = 3600
        next_sign = longitude_to_sign(self.longitude_at(changes_sign_at + time_step))
        if next_sign != self.current_sign
          @changes_sign_at = changes_sign_at
          return
        end
        while next_sign == self.current_sign
          next_sign = longitude_to_sign(self.longitude_at(changes_sign_at + time_step))
          if next_sign != self.current_sign
            @changes_sign_at = changes_sign_at
            return
          end
          changes_sign_at += time_step
        end
      end
      changes_sign_at += time_step
    end
  end

  def longitude_at(time)
    year = time.year
    month = time.month
    day = time.day
    hour = time.hour
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

end
