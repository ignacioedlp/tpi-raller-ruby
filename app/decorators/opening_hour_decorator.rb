class OpeningHourDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  def name
    day
  end
  

  def opens
    object.opens&.strftime("%H:%M %p") || "Closed"
  end

  def closes
    object.closes&.strftime("%H:%M %p") || "Closed"
  end

end
