module ApplicationHelper

  def logo
    image_tag("logo.png", :alt => "Sample App", :class => "round")
  end

  # return a title on a per page basis
  def title( given_title = nil )
    base_title = "Ruby on Rails Tutorial Sample App"
    if @title.nil?
      base_title
    elsif ! @title.nil?
      "#{base_title} | #{@title}"
    else
      "#{base_tite} | #{given_title}"
    end
  end

end
