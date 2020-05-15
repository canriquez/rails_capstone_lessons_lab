module ApplicationHelper
  def auth_course_options
    course_options = Group.select("name as course_name, id as course_taught_id").
                     where(id: current_user.authored_courses)
    c_options = course_options.map {|a| [a.course_name,a.course_taught_id] }
    c_options
  end

  def session_duration_options
    options = (1..8).map { |num| [(num * 15).to_s + ' min', num * 15] }
    options
  end

  def svg(name)
    file_path = "#{Rails.root}/app/assets/images/icons/#{name}.svg"
    return File.read(file_path).html_safe if File.exist?(file_path)

    fallback_path = "#{Rails.root}/app/assets/images/icons/#{name}.png"
    return image_tag("icons/#{name}.png") if File.exist?(fallback_path)

    '(not found)'
  end

  def toggle_icon(value)
    value ? svg('on') : svg('off')
  end

  def to_date(record)
    (Date.parse(record).strftime("%d/%m/%Y")).html_safe
  end

  def status_tag(val)
    if val == "generated"
      tag = '<p class="mt-0 mb-0 d-flex justify-content-between align-items-center">'
      tag += '<span class="badge badge-pill badge-light">' 
      tag += val
      tag += '</span>'
      tag +='<span class="course-off-btn">'
      tag += svg('check')
      tag += '</span><p>'
    else
      tag = '<p class="mt-0 mb-0 d-flex justify-content-between align-items-center">'
      tag += '<span class="badge badge-pill badge-light mt-0 mb-0">' 
      tag += val
      tag += ' by student</span>'
      tag +='<span class="course-on-btn mt-0 mb-0">'
      tag += svg('check')
      tag += '</span><p>'
    end  
    tag.html_safe
  end

  def safe_puts(field)
    return '' if field.nil?
    field
  end

end
