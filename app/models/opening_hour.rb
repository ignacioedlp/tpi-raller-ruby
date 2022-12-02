class OpeningHour < ApplicationRecord
  belongs_to :branch_office, inverse_of: :opening_hours
  DAYS = {
    "Lunes" => 1,
    "Martes" => 2,
    "Miércoles" => 3,
    "Jueves" => 4,
    "Viernes" => 5,
    "Sábado" => 6,
    "Domingo" => 7
  }

  validates :day, presence: true
  validates :opens, presence: true
  validates :closes, presence: true
  validates :branch_office, presence: true
  validate :day_is_unique, on: :create

  enum day: {"Lunes" => 1,
             "Martes" => 2,
             "Miércoles" => 3,
             "Jueves" => 4,
             "Viernes" => 5,
             "Sábado" => 6,
             "Domingo" => 7}

  def self.days_with_index_and_name_and_opens_and_closes(branch_office)
    days = []
    OpeningHour.days.each do |day, index|
      opening_hour = branch_office&.opening_hours&.find_by(day: index)
      days << {
        index: index,
        name: day,
        opens: opening_hour&.opens ? opening_hour&.opens&.strftime("%H:%M") : "Cerrado",
        closes: opening_hour&.closes ? opening_hour&.closes&.strftime("%H:%M") : "Cerrado"
      }
    end
    days
  end

  def day_is_unique
    if branch_office&.opening_hours&.find_by(day: day)
      errors.add(:day, "Ya existe un horario para este dia")
    end
  end
end
