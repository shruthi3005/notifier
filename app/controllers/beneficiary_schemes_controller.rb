class BeneficiarySchemesController < ApplicationController
  before_action :set_beneficiary_scheme, only: [:show, :api_show, :edit, :update, :destroy]


  # GET /beneficiary_schemes
  # GET /beneficiary_schemes.json
  def index
    handle_pages
    @beneficiary_schemes = BeneficiaryScheme.all
    @beneficiary_schemes = @beneficiary_schemes.where("beneficiary_name RLIKE (?)", params[:search].to_s) unless params[:search].blank?
    @beneficiary_schemes = @beneficiary_schemes.joins(:place).
      where("places.panchayat_id" => params[:panchayat_id]) unless params[:panchayat_id].blank?
    @beneficiary_schemes = @beneficiary_schemes.where(place_id: params[:place_id]) unless params[:place_id].blank?
    @beneficiary_schemes = @beneficiary_schemes.where(scheme_type_id: params[:scheme_type_id]) unless params[:scheme_type_id].blank?
    @beneficiary_schemes = @beneficiary_schemes.where(entity_status_id: params[:status_id]) unless params[:status_id].blank?

    if params[:start_date].present? or params[:end_date].present?        
      start_date = params[:start_date].blank? ? Date.today : params[:start_date]
      end_date = params[:end_date].blank? ? Date.today+7.days : params[:end_date]
      @beneficiary_schemes = @beneficiary_schemes.where("application_date >= ? and application_date <= ?",start_date, end_date)
    end

    @beneficiary_schemes = @beneficiary_schemes.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  # GET /beneficiary_schemes/1
  # GET /beneficiary_schemes/1.json
  def api_show
    render partial: "show"
  end

  # GET /beneficiary_schemes/1
  # GET /beneficiary_schemes/1.json
  def show
  end

  # GET /beneficiary_schemes/new
  def new
    @beneficiary_scheme = BeneficiaryScheme.new
  end

  # GET /beneficiary_schemes/1/edit
  def edit
  end

  # POST /beneficiary_schemes
  # POST /beneficiary_schemes.json
  def create
    @beneficiary_scheme = BeneficiaryScheme.new(beneficiary_scheme_params)

    respond_to do |format|
      if @beneficiary_scheme.save
        format.html { redirect_to beneficiary_schemes_path(page: prev_page), notice: 'Beneficiary scheme was successfully created.' }
        format.json { render :show, status: :created, location: @beneficiary_scheme }
      else
        format.html { render :new }
        format.json { render json: @beneficiary_scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beneficiary_schemes/1
  # PATCH/PUT /beneficiary_schemes/1.json
  def update
    respond_to do |format|
      if @beneficiary_scheme.update(beneficiary_scheme_params)
        format.html { redirect_to beneficiary_schemes_path(page: prev_page), notice: 'Beneficiary scheme was successfully updated.' }
        format.json { render :show, status: :ok, location: @beneficiary_scheme }
      else
        format.html { render :edit }
        format.json { render json: @beneficiary_scheme.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beneficiary_schemes/1
  # DELETE /beneficiary_schemes/1.json
  def destroy
    @beneficiary_scheme.destroy
    respond_to do |format|
      format.html { redirect_to beneficiary_schemes_path(page: prev_page), notice: 'Beneficiary scheme was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beneficiary_scheme
      @beneficiary_scheme = BeneficiaryScheme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def beneficiary_scheme_params
      params.require(:beneficiary_scheme).permit(:place_id, :scheme_type_id, :entity_status_id, :beneficiary_name, 
        :beneficiary_phone, :application_date, :granted_relief, :status, :remarks,
          stored_file_whitelist, stored_image_whitelist)
    end
end
