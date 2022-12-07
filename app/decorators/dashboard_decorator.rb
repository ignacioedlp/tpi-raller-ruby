class DashboardDecorator < ApplicationDecorator
  def shifts
    object.shifts.count
  end

  def shifts_completed
    object.shifts.where(completed: true).count
  end

  def shifts_pending
    object.shifts.where(completed: false).count
  end
end
