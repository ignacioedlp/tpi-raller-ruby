class AdminUserDecorator < ApplicationDecorator
  delegate_all

  def branch_office
    if object.branch_office.nil?
      "N/A"
    else
      object.branch_office
    end
  end
end
