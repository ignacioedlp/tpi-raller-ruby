class ShiftDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def hour 
    object.hour.strftime("%H:%M %p")
  end


  # saber el dia de la semana en base al numero del dia

  def name 
    OpeningHour::DAYS.key(object.day)
  end


  def day_with_hour 
    "#{name} #{hour}"
  end


  def status_span_color 
    if object.status == "Aceptado"
      "badge badge-success"
    elseif object.status == "Rechazado"
      "badge badge-danger"
    else
      "badge badge-warning"
    end
  end


end
