class BranchOffice < ApplicationRecord  
  has_many :opening_hours, dependent: :destroy, inverse_of: :branch_office, autosave: true
  has_many :shifts, dependent: :destroy, inverse_of: :branch_office, autosave: true
  has_many :users , dependent: :destroy, inverse_of: :branch_office, autosave: true

end
