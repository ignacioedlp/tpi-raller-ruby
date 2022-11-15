class BranchOffice < ApplicationRecord  
  has_many :opening_hours, inverse_of: :branch_office, autosave: true
  has_many :shifts, dependent: :destroy, inverse_of: :branch_office, autosave: true
  has_many :admin_users, inverse_of: :branch_office, autosave: true

  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :name, uniqueness: true

  # Validar que no se pueda eliminar una sucursal si tiene turnos asociados
  before_destroy :check_for_shifts

  def check_for_shifts
    if self.shifts.any?
      errors.add(:base, "No se puede eliminar una sucursal con turnos asociados")
      throw :abort
    end
  end
  
end
