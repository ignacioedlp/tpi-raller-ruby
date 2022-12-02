class BranchOffice < ApplicationRecord
  has_many :opening_hours, inverse_of: :branch_office, autosave: true
  has_many :shifts, inverse_of: :branch_office
  has_many :admin_users, inverse_of: :branch_office, autosave: true

  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :name, uniqueness: true

  before_destroy :check_for_shifts

  def check_for_shifts
    if shifts.any?
      errors.add("No se puede borrar una sucursal con turnos")
      throw :abort
    end
  end
end
