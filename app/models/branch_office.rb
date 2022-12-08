class BranchOffice < ApplicationRecord
  # Relaciones
  has_many :opening_hours, inverse_of: :branch_office, autosave: true
  has_many :shifts, inverse_of: :branch_office
  has_many :admin_users, inverse_of: :branch_office, autosave: true

  # Validaciones
  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :name, uniqueness: true

  before_destroy :check_for_shifts

  def check_for_shifts
    if shifts.where(completed: false).any?
      errors.add(:base, "No se puede eliminar una sucursal con turnos pendientes")
      throw(:abort)
    end
  end
end
