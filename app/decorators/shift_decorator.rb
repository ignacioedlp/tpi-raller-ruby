class ShiftDecorator < ApplicationDecorator
  delegate_all

  def hour
    object.date.strftime("%H:%M %p")
  end

  def name
    OpeningHour::DAYS.key(object.date.strftime("%u").to_i)
  end

  def day_with_hour
    "#{name} #{date}"
  end

  def status_span
    if !object.completed?
      helpers.content_tag :span, class: "bg-warning px-2 py-1 text-dark bg-opacity-50 rounded-pill" do
        "Pendiente"
      end
    else
      helpers.content_tag :span, class: "bg-success px-2 py-1 text-dark bg-opacity-50 rounded-pill" do
        "Aceptado"
      end
    end
  end
end
