class Api::V1::BeneficiarySchemesController < Api::BaseController
  def index
    schemes = BeneficiaryScheme.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    render json: schemes.map{|x| 
      {
        "id": x.id,
        "place": x.place.panch_name,
        "scheme_type": x.scheme_type.rgnl_name,
        "beneficiary_phone": x.beneficiary_phone,
        "beneficiary_name": x.beneficiary_name,
        "application_date": x.application_date,
        "granted_relief": x.granted_relief,
        "status": (x.entity_status.rgnl_name rescue "NA"),
        "remarks": x.remarks,
        "created_at": x.created_at,
        "image": x.image_url
      }
    }
  end

  def show
    scheme = BeneficiaryScheme.find(params[:id])
    render json: {
      "id": scheme.id,
      "place": scheme.place.panch_name,
      "scheme_type": scheme.scheme_type.rgnl_name,
      "beneficiary_phone": scheme.beneficiary_phone,
      "beneficiary_name": scheme.beneficiary_name,
      "application_date": scheme.application_date,
      "granted_relief": scheme.granted_relief,
      "status": (scheme.entity_status.rgnl_name rescue "NA"),
      "remarks": scheme.remarks,
      "created_at": scheme.created_at,
      "images": scheme.stored_images.map{|x| x.image_url}
    }
  end
end
