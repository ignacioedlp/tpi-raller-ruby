class OpeningHour < ApplicationRecord
    belongs_to :branch_office, inverse_of: :opening_hours
    DAYS = {
        "Lunes" => 0,
        "Martes" => 1,
        "Miércoles" => 2,
        "Jueves" => 3,
        "Viernes" => 4,
        "Sábado" => 5,
        "Domingo" => 6
    }
    

    validates :day, presence: true
    validates :opens, presence: true
    validates :closes, presence: true
    validates :branch_office, presence: true

    validate :validates_closes_is_greater_than_opens

    enum day: {"Lunes" => 0, "Martes" => 1, "Miércoles" => 2, "Jueves" => 3, "Viernes" => 4, "Sábado" => 5, "Domingo" => 6 }




    def validates_closes_is_greater_than_opens
        if closes && opens && closes < opens
            errors.add(:closes, "must be greater than opens")
        end
    end

    def self.days_with_index_and_name_and_opens_and_closes(branch_office)
        days = []
        OpeningHour.days.each do |day, index|
            opening_hour = branch_office.opening_hours.find_by(day: index)
            days << {
                index: index,
                name: day,
                opens: opening_hour&.opens ? opening_hour&.opens&.strftime("%H:%M") : "Cerrado",
                closes: opening_hour&.closes ? opening_hour&.closes&.strftime("%H:%M") : "Cerrado"
            }
        end
        days
    end




end
