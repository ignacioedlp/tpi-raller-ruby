class BranchOfficesController < ApplicationController
  before_action :set_branch_office, only: %i[show edit update destroy]

  def index
    @branch_offices = BranchOffice.all
  end

  def show
    @opening_hours = OpeningHour.days_with_index_and_name_and_opens_and_closes(@branch_office)
  end

  private

  def set_branch_office
    @branch_office = BranchOffice.find(params[:id])
  end

  def branch_office_params
    params.require(:branch_office).permit(:name, :address, :phone)
  end
end
