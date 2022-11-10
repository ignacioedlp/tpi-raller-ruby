class BranchOffice < ApplicationRecord
  belongs_to :branch_office, inverse_of: :opening_hours
end
