class Post < ApplicationRecord
  before_validation :generate_friendly_url
  validates :friendly_url, uniqueness: true

  def Post.get_by_url(url)
    Post.where("friendly_url = ?", url).first
  end

  private
  def generate_friendly_url
    friendly_url = normalize_title

    friendly_url = set_unique_or_generate_new_url(friendly_url)

    self.friendly_url = friendly_url
  end

  def set_unique_or_generate_new_url(url)
    loop do
      if !Post.exists?(friendly_url: url)
        break
      else
        url = "#{url}-#{Time.now.strftime("%d-%m-%y")}"
      end
    end
    url
  end

  def normalize_title
    I18n.transliterate(self.title).downcase.strip.gsub(/ /, "-")
  end
end
