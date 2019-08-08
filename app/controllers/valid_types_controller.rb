class ValidTypesController < ApplicationController
  before_action :admin_only
  before_action :set_valid_type, only: [:show, :edit, :update, :destroy]

  # GET /valid_types
  # GET /valid_types.json
  def index
    @valid_types = ValidType.all
  end

  # GET /valid_types/1
  # GET /valid_types/1.json
  def show
  end

  # GET /valid_types/new
  def new
    @valid_type = ValidType.new
  end

  # GET /valid_types/1/edit
  def edit
  end

  # POST /valid_types
  # POST /valid_types.json
  def create
    @valid_type = ValidType.new(valid_type_params)
    @valid_type.typed = true

    respond_to do |format|
      if @valid_type.save
        format.html { redirect_to valid_types_path, notice: 'Entity Type was successfully created.' }
        format.json { render :show, status: :created, location: @valid_type }
      else
        format.html { render :new }
        format.js { render :new }
        format.json { render json: @valid_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /valid_types/1
  # PATCH/PUT /valid_types/1.json
  def update
    respond_to do |format|
      if @valid_type.update(valid_type_params)
        format.html { redirect_to valid_types_path, notice: 'Entity Type was successfully updated.' }
        format.json { render :show, status: :ok, location: @valid_type }
      else
        format.html { render :edit }
        format.js { render :edit }
        format.json { render json: @valid_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /valid_types/1
  # DELETE /valid_types/1.json
  def destroy
    @valid_type.destroy
    respond_to do |format|
      format.html { redirect_to valid_types_url, notice: 'Entity status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_valid_type
      @valid_type = ValidType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def valid_type_params
      params.require(:valid_type).permit(:entity_type, :name, :code, :regional_name_value)
    end
end
