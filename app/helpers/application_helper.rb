module ApplicationHelper
  def session_duration_options
    options = (1..8).map { |num| [(num * 15).to_s + ' min', num * 15] }
    puts 'look here'
    p options
    options
  end
end
