class Api::V1::CommonsController < Api::BaseController
  skip_before_action :api_auth, only: [:places]
  # before_action :check_app, only: [:places]

  # GET common/departments
  def departments
    render json: Department.all.order(:name).includes(:regional_name).map{|x| {id: x.id, name: x.rgnl_name}}
  end

  # GET common/places
  def places
    search_text = params[:search].to_s rescue nil
    places = []
    unless search_text.blank?
      places = Place.external.where("name RLIKE(?)", search_text).limit(100).map{|x| {id: x.id, name: x.panch_name}}
    end
    render json: places
  end

  # GET common/status_list
  def status_list
    model = params[:model].constantize
    if (model::VALID_TYPES.respond_to?(:values) rescue false)
      render json: model::VALID_TYPES.values.sort
    else
      render json: []
    end
  end
end
