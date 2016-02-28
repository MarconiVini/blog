module Common::TimeHelper 
  def render_time_published(time)
    return time_ago_in_words(time) if time > Time.now - 30.days
    time.strftime(get_user_location)
  end

  private
  def get_user_location
    I18n.locale == "pt-BR" ? "%d/%m/%y" : "%m/%d/%y"
  end
end