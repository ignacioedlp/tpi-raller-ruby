class BranchOfficesController < ApplicationController
  before_action :set_branch_office, only: %i[ show edit update destroy ]

  # GET /branch_offices or /branch_offices.json
  def index
    @branch_offices = BranchOffice.all
  end

  # GET /branch_offices/1 or /branch_offices/1.json
  def show
    @opening_hours = OpeningHour.days_with_index_and_name_and_opens_and_closes(@branch_office)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_branch_office
      @branch_office = BranchOffice.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def branch_office_params
      params.require(:branch_office).permit(:name, :address, :phone)
    end
end
