module ApplicationHelper
  def route_colour(routename)
    case
    when routename =~ /m/i
      "#d40000"
    when routename =~ /l/i
      "#5555ff"
    else
      "#87cdde"
    end
  end
end
