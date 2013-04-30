module ApplicationHelper

  def full_title(page_title)
    base_title = "Marshall"
    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def auth_check()
    if session[:auth] = true
      redirect_to root_path
    end
  end

end
