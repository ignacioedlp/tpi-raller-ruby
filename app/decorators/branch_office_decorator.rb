class BranchOfficeDecorator < ApplicationDecorator
  delegate_all

  def shifts
    object.shifts.count
  end
end
