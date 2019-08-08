class DistrictsController < ApplicationController
  before_action :set_district, only: [:show, :edit, :update, :destroy]

  # GET /districts
  # GET /districts.json
  def index
    @districts = District.all.includes(:taluks)
  end

  # GET /districts/1
  # GET /districts/1.json
  def show
  end

  def panchayat_details
    @panchayat = Panchayat.find(params[:id])
  end

  # GET /districts/new
  def new
    @district = District.new
  end

  # GET /districts/1/edit
  def edit
  end

  # POST /districts
  # POST /districts.json
  def create
    @district = District.new(district_params)

    respond_to do |format|
      if @district.save
        format.html { redirect_to @district, notice: 'District was successfully created.' }
        format.json { render :show, status: :created, location: @district }
      else
        format.html { render :new }
        format.json { render json: @district.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /districts/1
  # PATCH/PUT /districts/1.json
  def update
    respond_to do |format|
      if @district.update(district_params)
        format.html { redirect_to @district, notice: 'District was successfully updated.' }
        format.json { render :show, status: :ok, location: @district }
      else
        format.html { render :edit }
        format.json { render json: @district.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /districts/1
  # DELETE /districts/1.json
  def destroy
    @district.destroy
    respond_to do |format|
      format.html { redirect_to districts_url, notice: 'District was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # GET /places/suggest
  def suggest
    search_text = params[:search].to_s rescue nil
    places = []
    unless search_text.blank?
      places = Place.where("full_name RLIKE(?)", search_text).limit(100).map{|x| {id: x.id, name: x.panch_name}}
    end
    render json: places
  end

  def create_entity
    #TODO move entity context getter to a common func
    entity_context, entity_params, entity = get_entity(params[:entity_type])
    record = entity_context.new(send(entity_params))
    if record.save
      redirect_to district_path(record.district, anchor: "#{entity}_#{record.id}"), notice: "Added #{entity} #{record.name}"
    else
      redirect_to district_path(record.district), alert: "Error Saving #{entity} #{record.name} : #{record.errors.full_messages.join(",")}"
    end
  end

  def update_entity
    entity_context, entity_params, entity = get_entity(params[:entity_type])
    record = entity_context.find(params[:id])

    if record.update(send(entity_params))
      redirect_to district_path(record.district, anchor: "#{entity}_#{record.id}"), notice: "Updated #{entity} #{record.name}"
    else
      redirect_to district_path(record.district), alert: "Error Updating #{entity} #{record.name} : #{record.errors.full_messages.join(",")}"
    end
  end

  def entity_form
    # Get entity context before we proceed
    entity_context, entity_params, entity = get_entity(params[:entity_type])
    render nothing: true and return if entity_context.blank?

    if params[:id] == "new"
      record = entity_context.new(send(entity_params))
    else
      record = entity_context.find(params[:id])
    end
    instance_variable_set("@#{entity}", record)

    render partial: "#{entity}_form"
  end

  def village_select
    villages = Place.where(panchayat_id: params[:panchayat_id]).order(:name)
    render partial: "shared/village_selector.html.erb", locals: {villages: villages}
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def district_params
      params.require(:district).permit(:name, :code, :regional_name_value, taluks_attributes: 
        [:id, :_destroy, :name, :code, :regional_name_value, panchayats_attributes:
          [:id, :_destroy, :name, :code, :regional_name_value, places_attributes: 
            [:id, :_destroy, :name, :code, :place_type, :regional_name_value]
          ]
        ])
    end

    def panchayat_params
      params.require(:panchayat).permit(:name, :code, :internal, :taluk_id, :regional_name_value)
    end

    def place_params
      params.require(:place).permit(:name, :code, :internal, :place_type, :panchayat_id, :regional_name_value)
    end

    def taluk_params
      params.require(:taluk).permit(:name, :code, :internal, :district_id, :regional_name_value)
    end

    # Use callbacks to share common setup or constraints between actions.
    def get_entity(name)
      # These are the valid entities and their validators are defined
      if ["Taluk","Panchayat","Place"].include?(name)
        return name.constantize, name.downcase+"_params", name.downcase
      else
        return nil
      end
    end

    def set_district
      @district = District.find(params[:id])
    end
end
