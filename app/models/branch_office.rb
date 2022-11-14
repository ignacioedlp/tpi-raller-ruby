class BranchOffice < ApplicationRecord  
  has_many :opening_hours, dependent: :destroy, inverse_of: :branch_office, autosave: true
  has_many :shifts, dependent: :destroy, inverse_of: :branch_office, autosave: true
  has_many :admin_users , dependent: :destroy, inverse_of: :branch_office, autosave: true

  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true
end
