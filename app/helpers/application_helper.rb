module ApplicationHelper
  require 'date'
  def roles_options
    rt = User.roles.map { |k, _v| [k.split('_').first.capitalize, k] }

    rt
  end

  def type_options
    rt = Transaction.booking_types.map { |k, _v| [k.split('_').first.capitalize, k] }

    rt
  end

  def auth_course_options
    course_options = Group.select('name as course_name, id as course_taught_id')
      .where(id: current_user.authored_courses)
    c_options = course_options.map { |a| [a.course_name, a.course_taught_id] }
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

  def svgb(name)
    #File.open("#{Rails.root}/app/assets/images/icons/#{name}.svg", "rb") do |file|
    File.open(Rails.root + ActionController::Base.helpers.asset_path("#{name}.svg")) do |file|      
      raw file.read
    end
  end

  def toggle_icon(value)
    value ? svg('on') : svg('off')
  end

  def to_date(record)
    record.to_s[0..18]
    
  end

  def status_tag(val)
    tag = '<p class="mt-0 mb-0 d-flex justify-content-between align-items-center">'
    tag += '<span class="badge badge-pill badge-light">'
    tag += val
    if val == 'generated'
      tag += '</span>'
    else
      tag += ' by student</span>'
      tag += '<span class="course-on-btn mt-0 mb-0">'
    end
    tag += svg('check')
    tag += '</span><p>'
    tag.html_safe
  end

  def safe_puts(field)
    return '' if field.nil?

    field
  end 

  def my_bookings_icon
    '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" 
    viewBox="0 0 24 24"><path d="M15 12h-10v1h10v-1zm-4 2h-6v1h6v-1zm4-6h-10v1h10v-1zm0 2h-10v1h10v-1zm0-6h-10v1h10v-1zm0 
    2h-10v1h10v-1zm7.44 10.277c.183-2.314-.433-2.54-3.288-5.322.171
    1.223.528 3.397.911 5.001.089.382-.416.621-.586.215-.204-.495-.535-2.602-.82-4.72-.154-1.134-1.661-.995-1.657.177.005 
    1.822.003 3.341 0 6.041-.003 2.303 1.046 2.348 1.819 4.931.132.444.246.927.339 
    1.399l3.842-1.339c-1.339-2.621-.693-4.689-.56-6.383zm-6.428 
    1.723h-13.012v-16h14v7.894c.646-.342 1.348-.274 1.877.101l.123-.018v-8.477c0-.828-.672-1.5-1.5-1.5h-15c-.828 
    0-1.5.671-1.5 1.5v17c0 .829.672 1.5 1.5 1.5h13.974c-.245-.515-.425-1.124-.462-2z"/>
    </svg>'.html_safe
  end

  def my_enrolled_courses
    ''.html_safe
  end


end
