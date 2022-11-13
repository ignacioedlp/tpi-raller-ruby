class Shift < ApplicationRecord

  #tiene un usuario y un admin asociado 
  belongs_to :user
  belongs_to :admin_user, optional: true
  belongs_to :branch_office, inverse_of: :shifts

  DAYS = {
        "Lunes" => 0,
        "Martes" => 1,
        "Miércoles" => 2,
        "Jueves" => 3,
        "Viernes" => 4,
        "Sábado" => 5,
        "Domingo" => 6
    }
  STATUSES = ["Pendiente", "Aceptado", "Rechazado"]

  # Validaciones
  # validar que el horario este entre los horarios de apertura y cierre de la sucursal
  validates :hour, presence: true
  validates :day, presence: true
  
  validate :validate_shift_time
  

  def validate_shift_time
    #Si hay horarios de ese dia de la semana en la sucursal
    if self.branch_office.opening_hours.where(day: self.day).any?
      #Si el horario de inicio es menor al horario de apertura de la sucursal
      if self.hour < self.branch_office.opening_hours.where(day: self.day).first.opens
        errors.add(:start_time, "El horario de atencion es menor al horario de apertura de la sucursal")
      end
      #Si el horario de fin es mayor al horario de cierre de la sucursal
      if self.hour > self.branch_office.opening_hours.where(day: self.day).first.closes
        errors.add(:end_time, "El horario de atencion es mayor al horario de cierre de la sucursal")
      end
    else
      errors.add(:day, "La sucursal no abre ese dia de la semana")
    end
  end

end
