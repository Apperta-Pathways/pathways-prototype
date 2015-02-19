module ApplicationHelper

  def all_cats
    Category.all
  end

  def flash_message(type, msg)
    flash[type] ||= []
    flash[type] << msg
  end

  def success_message
    icon 'check', flash[:success]
  end

  def error_message
    icon 'thumbs-down', flash[:error]
  end

  def render_flash
    rendered = []
    if flash[:success]
      rendered << content_tag(:div, success_message, class: 'alert alert-success')
    end
    if flash[:error]
      rendered << content_tag(:div, flash[:error], class: 'alert alert-error')
    end
    return rendered.join('')
  end

end
