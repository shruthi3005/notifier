class DevelopmentWorksController < ApplicationController
  before_action :set_development_work, only: [:show, :edit, :update, :destroy, :api_show]

  # GET /development_works
  # GET /development_works.json
  def index
    handle_pages
    @development_works = DevelopmentWork.all
    @development_works = @development_works.where(department_id: params[:department_id]) unless params[:department_id].blank?
    @development_works = @development_works.where("name RLIKE (?)", params[:search].to_s) unless params[:search].blank?
    @development_works = @development_works.joins(:place).
      where("places.panchayat_id" => params[:panchayat_id]) unless params[:panchayat_id].blank?
    @development_works = @development_works.where(fy: params[:fy]) unless params[:fy].blank?
    @development_works = @development_works.where(place_id: params[:place_id]) unless params[:place_id].blank?
    @development_works = @development_works.where(entity_status_id: params[:status_id]) unless params[:status_id].blank?
    @development_works = @development_works.where(valid_type_id: params[:valid_type_id]) unless params[:valid_type_id].blank?
    add_statistics
    @development_works = @development_works.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end

  # GET /development_works/1
  # GET /development_works/1.json
  def api_show
    render partial: "show"
  end

  # GET /development_works/1
  # GET /development_works/1.json
  def show
  end

  # GET /development_works/new
  def new
    @development_work = DevelopmentWork.new
  end

  # GET /development_works/1/edit
  def edit
  end

  # POST /development_works
  # POST /development_works.json
  def create
    @development_work = DevelopmentWork.new(development_work_params)

    respond_to do |format|
      if @development_work.save
        format.html { redirect_to @development_work, notice: 'Development work was successfully created.' }
        format.json { render :show, status: :created, location: @development_work }
      else
        format.html { render :new }
        format.json { render json: @development_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /development_works/1
  # PATCH/PUT /development_works/1.json
  def update
    respond_to do |format|
      if @development_work.update(development_work_params)
        format.html { redirect_to development_works_path(page: prev_page), notice: 'Development work was successfully updated.' }
        format.json { render :show, status: :ok, location: @development_work }
      else
        format.html { render :edit }
        format.json { render json: @development_work.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /development_works/1
  # DELETE /development_works/1.json
  def destroy
    @development_work.destroy
    respond_to do |format|
      format.html { redirect_to development_works_path(page: prev_page), notice: 'Development work was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def add_statistics
      @stats = {}
      @stats[:count] = @development_works.count
      @stats[:sanctioned] = @development_works.pluck(:sanctioned_amount).compact.inject(:+)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_development_work
      @development_work = DevelopmentWork.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def development_work_params
      params.require(:development_work).permit(:place_id, :name, :desc, :fy, :valid_type_id, :estimated_amount, :entity_status_id,
        :sanctioned_amount, :department_id, :foundation_date, :inaugration_date, :status, :remarks, :regional_name_value,
          stored_file_whitelist, stored_image_whitelist, videos_attributes: [:id, :_destroy, :vid_url, :desc])
    end
end
