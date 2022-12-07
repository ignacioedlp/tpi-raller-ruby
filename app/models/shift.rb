class Shift < ApplicationRecord
  # Atributos accesibles
  DAYS = {
    "Lunes" => 1,
    "Martes" => 2,
    "Miércoles" => 3,
    "Jueves" => 4,
    "Viernes" => 5,
    "Sábado" => 6,
    "Domingo" => 7
  }

  # Relaciones con otros modelos
  belongs_to :user
  belongs_to :admin_user, optional: true
  belongs_to :branch_office, inverse_of: :shifts

  # Validaciones
  validates :date, presence: true
  validates :branch_office, presence: true
  validates :user, presence: true

  # Validaciones customs
  validate :hour_is_between_opening_and_closing_hours
  validate :comment_and_admin_user_are_present_if_completed
  validate :the_user_has_no_shifts_at_the_same_time_in_the_same_day, on: :create
  validate :date_must_be_in_the_future

  # Métodos
  def the_user_has_no_shifts_at_the_same_time_in_the_same_day
    if date.present? && user.present?
      if user.shifts.find_by(date: date.beginning_of_day..date.end_of_day)
        errors.add(:date, "el usuario ya tiene un turno en ese día")
      end
    end
  end

  def comment_and_admin_user_are_present_if_completed
    if completed == true
      if comment.blank?
        errors.add(:comment, "debe ingresar uno")
      end
      if admin_user.blank?
        errors.add(:admin_user, "debe seleccionar un empleado")
      end
    end
  end

  def hour_is_between_opening_and_closing_hours
    if date.present? && branch_office.present?
      hour_shift = branch_office.opening_hours.find_by(day: date.strftime("%u").to_i)
      if hour_shift.present?
        if date.hour < hour_shift.opens.hour || date.hour > hour_shift.closes.hour

          errors.add(:date, "debe estar entre los horarios de apertura y cierre de la sucursal")
        end

      else
        errors.add(:date, "la sucursal no abre ese día")
      end
    end
  end

  def date_must_be_in_the_future
    if date.present? && date < Date.today
      errors.add(:date, "no puede ser en el pasado")
    end
  end
end
