module ApplicationHelper
  def show_flash(type)
    if flash[:alert]
      content_tag :p, flash[type], class: "flash #{type}"
    end
  end

  def request_path
    session[:request_page]
  end
end
