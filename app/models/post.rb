require 'rouge/plugins/redcarpet'
require "assistent/redcarpet_renderer"

class Post < ApplicationRecord
  before_validation :generate_friendly_url
  validates :friendly_url, uniqueness: true

  scope :published, -> { where(disabled: false) }

  def Post.get_by_url(url)
    Post.where("friendly_url = ?", url).first
  end

  def render
    options = {
      filter_html:     true,
      hard_wrap:       true, 
      link_attributes: { rel: 'nofollow', target: "_blank" },
      space_after_headers: true, 
      fenced_code_blocks: true
    }

    extensions = {
      autolink:           false,
      superscript:        true,
      disable_indented_code_blocks: true
    }
    #TODO - cache this render somewhere
    r = Redcarpet::Markdown.new(RedcarpetRenderer.new(extensions), options)
    r.render(self.body)
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
