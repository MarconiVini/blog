require "yaml"
module Admin::LinksHelper

  def build_top_links
    build_links("header")
  end

  def build_lateral_links
    build_links("lateral")
  end

  def build_links(resource)
    YAML.load_file("config/admin_links.yml")[resource].collect do |link|
      active = (evaluete_path(link.last) == request.path) ? "active" : ""
      content_tag(:li, link_to(link.first, evaluete_path(link.last)), class: active)
    end.join.html_safe  
  end

  private

  def evaluete_path(resource)
    return "#" if resource.empty?
    begin
      eval(resource)
    rescue
      resource
    end      
  end
end
