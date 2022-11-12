class ShiftsController < ApplicationController
  before_action :set_shift, only: %i[ show edit update destroy ]

  # GET /shifts or /shifts.json
  def index
    @shifts = Shift.all
    authorize @shifts
  end

  # GET /shifts/1 or /shifts/1.json
  def show
    authorize @shift
  end

  # GET /shifts/new
  def new
    @shift = Shift.new
    authorize @shift
    @days = { "Lunes" => 0, "Martes" => 1, "Miércoles" => 2, "Jueves" => 3, "Viernes" => 4, "Sábado" => 5, "Domingo" => 6 }
  end

  # GET /shifts/1/edit
  def edit
    authorize @shift
    @days = { "Lunes" => 0, "Martes" => 1, "Miércoles" => 2, "Jueves" => 3, "Viernes" => 4, "Sábado" => 5, "Domingo" => 6 }
  end

  # POST /shifts or /shifts.json
  def create

    params[:shift][:user_id] = current_user.id
    params[:shift][:day] = params[:shift][:day].to_i 
    @shift = Shift.new(shift_params)
    authorize @shift


    respond_to do |format|
      if @shift.save
        format.html { redirect_to shift_url(@shift), notice: "Shift was successfully created." }
        format.json { render :show, status: :created, location: @shift }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shifts/1 or /shifts/1.json
  def update
    authorize @shift

    params[:shift][:day] = params[:shift][:day].to_i 
    respond_to do |format|
      if @shift.update(shift_params)
        format.html { redirect_to shift_url(@shift), notice: "Shift was successfully updated." }
        format.json { render :show, status: :ok, location: @shift }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @shift.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shifts/1 or /shifts/1.json
  def destroy
    @shift.destroy
    authorize @shift

    respond_to do |format|
      format.html { redirect_to shifts_url, notice: "Shift was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shift
      @shift = Shift.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def shift_params
      params.require(:shift).permit(:day, :hour, :branch_office_id, :user_id, :reason, :status)
    end
end
