class OpeningHoursController < ApplicationController
  before_action :set_opening_hour, only: %i[ show edit update destroy ]

  # GET /opening_hours or /opening_hours.json
  def index
    @opening_hours = OpeningHour.all
  end

  # GET /opening_hours/1 or /opening_hours/1.json
  def show
  end

  # GET /opening_hours/new
  def new
    @opening_hour = OpeningHour.new
    @days = { "Lunes" => 0, "Martes" => 1, "Miércoles" => 2, "Jueves" => 3, "Viernes" => 4, "Sábado" => 5, "Domingo" => 6 }
  end

  # GET /opening_hours/1/edit
  def edit
  end

  # POST /opening_hours or /opening_hours.json
  def create
    debugger
    # quiero que el day sea un integer y no un string antes de crear el opening_hour
    
    
    
    @opening_hour = OpeningHour.new()

    respond_to do |format|
      if @opening_hour.save
        format.html { redirect_to opening_hour_url(@opening_hour), notice: "Opening hour was successfully created." }
        format.json { render :show, status: :created, location: @opening_hour }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @opening_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opening_hours/1 or /opening_hours/1.json
  def update
    respond_to do |format|
      if @opening_hour.update(opening_hour_params)
        format.html { redirect_to opening_hour_url(@opening_hour), notice: "Opening hour was successfully updated." }
        format.json { render :show, status: :ok, location: @opening_hour }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @opening_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opening_hours/1 or /opening_hours/1.json
  def destroy
    @opening_hour.destroy

    respond_to do |format|
      format.html { redirect_to opening_hours_url, notice: "Opening hour was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opening_hour
      @opening_hour = OpeningHour.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def opening_hour_params
      params.require(:opening_hour).permit(:day, :opens, :closes, :branch_office_id)
    end
end
