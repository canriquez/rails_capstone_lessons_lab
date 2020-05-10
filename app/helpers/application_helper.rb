module ApplicationHelper
  def session_duration_options
    options = (1..8).map { |num| [(num * 15).to_s + ' min', num * 15] }
    options
  end

  def svg(name)
    file_path = "#{Rails.root}/app/assets/images/icons/#{name}.svg"
    return ('<i>'+File.read(file_path)+'</i>').html_safe if File.exists?(file_path)
    fallback_path = "#{Rails.root}/app/assets/images/icons/#{name}.png"
    return image_tag("icons/#{name}.png") if File.exists?(fallback_path)
    '(not found)'
  end

  def toggle_icon(value)
    #path = '#{Rails.root}/app/assets/images/icons/'
    #value ? inline_svg_tag("#{path}toggle_on.svg") : inline_svg_tag("#{path}toggle_off.svg")
    value ? svg("on") : svg("off")
  end

end
