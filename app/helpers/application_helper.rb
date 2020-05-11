module ApplicationHelper
  def session_duration_options
    options = (1..8).map { |num| [(num * 15).to_s + ' min', num * 15] }
    options
  end

  def svg(name)
    file_path = "#{Rails.root}/app/assets/images/icons/#{name}.svg"
    return (File.read(file_path)).html_safe if File.exists?(file_path)
    fallback_path = "#{Rails.root}/app/assets/images/icons/#{name}.png"
    return image_tag("icons/#{name}.png") if File.exists?(fallback_path)
    '(not found)'
  end

  def toggle_icon(value)
    value ? svg("on") : svg("off")
  end



end
