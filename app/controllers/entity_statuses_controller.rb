class EntityStatusesController < ApplicationController
  before_action :admin_only
  before_action :set_entity_status, only: [:show, :edit, :update, :destroy]

  # GET /entity_statuses
  # GET /entity_statuses.json
  def index
    @entity_statuses = EntityStatus.all
  end

  # GET /entity_statuses/1
  # GET /entity_statuses/1.json
  def show
  end

  # GET /entity_statuses/new
  def new
    @entity_status = EntityStatus.new
  end

  # GET /entity_statuses/1/edit
  def edit
  end

  # POST /entity_statuses
  # POST /entity_statuses.json
  def create
    @entity_status = EntityStatus.new(entity_status_params)

    respond_to do |format|
      if @entity_status.save
        format.html { redirect_to entity_statuses_path, notice: 'Entity status was successfully created.' }
        format.json { render :show, status: :created, location: @entity_status }
      else
        format.html { render :new }
        format.js { render :new }
        format.json { render json: @entity_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entity_statuses/1
  # PATCH/PUT /entity_statuses/1.json
  def update
    respond_to do |format|
      if @entity_status.update(entity_status_params)
        format.html { redirect_to entity_statuses_path, notice: 'Entity status was successfully updated.' }
        format.json { render :show, status: :ok, location: @entity_status }
      else
        format.html { render :edit }
        format.js { render :edit }
        format.json { render json: @entity_status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entity_statuses/1
  # DELETE /entity_statuses/1.json
  def destroy
    @entity_status.destroy
    respond_to do |format|
      format.html { redirect_to entity_statuses_url, notice: 'Entity status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_entity_status
      @entity_status = EntityStatus.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entity_status_params
      params.require(:entity_status).permit(:entity_type, :name, :code, :regional_name_value)
    end
end
