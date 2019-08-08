class CitizensController < ApplicationController
  before_action :admin_only
  before_action :set_citizen, only: [:show, :edit, :update, :destroy]

  # GET /citizens
  # GET /citizens.json
  def index
    handle_pages
    @citizens = Citizen.all
    @citizens = @citizens.where("phone RLIKE (?)", params[:search]) unless params[:search].blank?
    @citizens = @citizens.joins(:place).
      where("places.panchayat_id" => params[:panchayat_id]) unless params[:panchayat_id].blank?
    @citizens = @citizens.where(position_id: params[:position_id]) unless params[:position_id].blank?
    @citizens = @citizens.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  # GET /citizens/1
  # GET /citizens/1.json
  def show
  end

  # GET /citizens/new
  def new
    @citizen = Citizen.new
  end

  # GET /citizens/1/edit
  def edit
  end

  # POST /citizens
  # POST /citizens.json
  def create
    @citizen = Citizen.new(citizen_params)

    respond_to do |format|
      if @citizen.save
        format.html { redirect_to citizens_path(page: prev_page), notice: 'Citizen was successfully created.' }
        format.json { render :show, status: :created, location: @citizen }
      else
        format.html { render :new }
        format.js { render :new }
        format.json { render json: @citizen.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /citizens/1
  # PATCH/PUT /citizens/1.json
  def update
    respond_to do |format|
      if @citizen.update(citizen_params)
        format.html { redirect_to citizens_path(page: prev_page), notice: 'Citizen was successfully updated.' }
        format.json { render :show, status: :ok, location: @citizen }
      else
        format.html { render :edit }
        format.js { render :edit }
        format.json { render json: @citizen.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /citizens/1
  # DELETE /citizens/1.json
  def destroy
    @citizen.destroy
    respond_to do |format|
      format.html { redirect_to citizens_path(page: prev_page), notice: 'Citizen was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_citizen
      @citizen = Citizen.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def citizen_params
      params.require(:citizen).permit(:name, :age, :dob, :email, :phone, :gender, :addl_details, 
        :pincode, :address, :regional_name_value, :position_id, :place_id)
    end
end
