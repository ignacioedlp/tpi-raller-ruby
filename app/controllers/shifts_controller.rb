class ShiftsController < ApplicationController
  before_action :set_shift, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index
    @shifts = Shift.where(user_id: current_user.id).decorate
  end

  def show
    @shift = @shift.decorate
  end

  def new
    @branch_office = BranchOffice.find(params[:branch_office_id])
    @shift = Shift.new
  end

  def edit
    if !@shift.completed?
      @branch_office = BranchOffice.find(@shift.branch_office_id)
    else
      redirect_to shifts_path, alert: "No se puede editar un turno que ya fue aceptado o rechazado"
    end
  end

  def create
    params[:shift][:user_id] = current_user.id
    @shift = Shift.new(shift_params)
    respond_to do |format|
      if @shift.save
        format.html { redirect_to shift_url(@shift), notice: "Turno creado!" }
        format.json { render :show, status: :created, location: @shift }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to shift_url(@shift), notice: "Turno actualizado!" }
        format.json { render :show, status: :ok, location: @shift }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @shift.destroy

    respond_to do |format|
      format.html { redirect_to shifts_url, notice: "Turno eliminado!" }
      format.json { head :no_content }
    end
  end

  private

  def set_shift
    @shift = Shift.find(params[:id])
  end

  def shift_params
    params.require(:shift).permit(:date, :branch_office_id, :user_id, :reason)
  end
end
