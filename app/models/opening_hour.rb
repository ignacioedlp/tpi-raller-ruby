class OpeningHour < ApplicationRecord
    has_many :opening_hours, dependent: :destroy, inverse_of: :branch_office, autosave: true
end
