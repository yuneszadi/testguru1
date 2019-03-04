module ApplicationHelper
  def show_flash(type)
    content_tag :p, flash[type], class: "flash #{type}" if flash[:alert]
  end
end
