class OpeningHourDecorator < ApplicationDecorator
  delegate_all

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
