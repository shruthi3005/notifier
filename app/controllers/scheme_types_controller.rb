class SchemeTypesController < ApplicationController
  before_action :set_scheme_type, only: [:show, :edit, :update, :destroy]

  # GET /scheme_types
  # GET /scheme_types.json
  def index
    @scheme_types = SchemeType.all
  end

  # GET /scheme_types/1
  # GET /scheme_types/1.json
  def show
  end

  # GET /scheme_types/new
  def new
    @scheme_type = SchemeType.new
  end

  # GET /scheme_types/1/edit
  def edit
  end

  # POST /scheme_types
  # POST /scheme_types.json
  def create
    @scheme_type = SchemeType.new(scheme_type_params)

    respond_to do |format|
      if @scheme_type.save
        format.html { redirect_to scheme_types_path, notice: 'Entity status was successfully created.' }
        format.json { render :show, status: :created, location: @scheme_type }
      else
        format.html { render :new }
        format.js { render :new }
        format.json { render json: @scheme_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /scheme_types/1
  # PATCH/PUT /scheme_types/1.json
  def update
    respond_to do |format|
      if @scheme_type.update(scheme_type_params)
        format.html { redirect_to scheme_types_path, notice: 'Entity status was successfully updated.' }
        format.json { render :show, status: :ok, location: @scheme_type }
      else
        format.html { render :edit }
        format.js { render :edit }
        format.json { render json: @scheme_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /scheme_types/1
  # DELETE /scheme_types/1.json
  def destroy
    @scheme_type.destroy
    respond_to do |format|
      format.html { redirect_to scheme_types_url, notice: 'Entity status was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_scheme_type
      @scheme_type = SchemeType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def scheme_type_params
      params.require(:scheme_type).permit(:sub_type, :name, :regional_name_value)
    end
end
