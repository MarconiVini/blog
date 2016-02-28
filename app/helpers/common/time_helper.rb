module Common::TimeHelper 
  def render_time_published(time)
    return "#{distance_of_time_in_words_to_now(time)} #{sulfix}" if time > Time.now - 30.days
    time.strftime(get_user_location)
  end

  private

  def sulfix
    I18n.locale == "pt-BR" ? "atrás" : "ago"
  end

  def get_user_location
    I18n.locale == "pt-BR" ? "%d/%m/%y" : "%m/%d/%y"
  end
end