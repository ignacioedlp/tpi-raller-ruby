class Shift < ApplicationRecord

  #tiene un usuario y un admin asociado 
  belongs_to :user
  belongs_to :admin_user, optional: true
  belongs_to :branch_office, inverse_of: :shifts

  DAYS = {
        "Lunes" => 1,
        "Martes" => 2,
        "Miércoles" => 3,
        "Jueves" => 4,
        "Viernes" => 5,
        "Sábado" => 6,
        "Domingo" => 7
    }

  STATUSES = ["Pendiente", "Aceptado", "Rechazado"]

  # Validaciones
  # validar que el horario este entre los horarios de apertura y cierre de la sucursal
  validates :date, presence: true
  validates :branch_office, presence: true
  validates :user, presence: true
  validate :hour_is_between_opening_and_closing_hours
  # Validar si tiene un comentario y un empleado si el estado es rechazado o aceptado
  validate :comment_and_admin_user_are_present_if_status_is_rejected_or_accepted
  validate :the_user_has_no_shifts_at_the_same_time, on: :create

  def the_user_has_no_shifts_at_the_same_time
    if Shift.where(user_id: user_id, date: date).any?
      errors.add(:date, "El usuario ya tiene un turno para ese dia")
    end
  end



  def comment_and_admin_user_are_present_if_status_is_rejected_or_accepted
    if self.status == "Rechazado" || self.status == "Aceptado"
      if self.comment.blank?
        errors.add(:comment, "Debe ingresar un comentario")
      end
      if self.admin_user.blank?
        errors.add(:admin_user, "Debe seleccionar un empleado")
      end
    end
  end
  

  # TODO: Averiguar como solucionar el problema de los horarios con los minutos 
  def hour_is_between_opening_and_closing_hours
    if date.present? && branch_office.present?
      hour_shift = branch_office.opening_hours.find_by(day: date.strftime("%u").to_i)
      if hour_shift.present?
        if date.hour < hour_shift.opens.hour || date.hour > hour_shift.closes.hour

          errors.add(:date, "El horario debe estar entre los horarios de apertura y cierre de la sucursal")
        end

      else
        errors.add(:date, "La sucursal no abre ese día")
      end
    end
  end


  


  

end
