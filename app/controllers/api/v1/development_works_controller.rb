class Api::V1::DevelopmentWorksController < Api::BaseController
  def index
    works = DevelopmentWork.where.not(sanctioned_amount: nil).
      order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    render json: works.map{|x| 
      {
        "id": x.id,
        "department": x.department.rgnl_name,
        "place": x.place.panch_name,
        "desc": x.desc,
        "sanctioned_amount": x.sanctioned_amount,
        "foundation_date": x.foundation_date,
        "inaugration_date": x.inaugration_date,
        "name": x.rgnl_name,
        "remarks": x.remarks,
        "created_at": x.created_at,
        "updated_at": x.updated_at,
        "status": (x.entity_status.rgnl_name rescue "NA"),
        "image": x.image_url
      }
    }
  end

  def show
    work = DevelopmentWork.find(params[:id])
    render json: {
      "id": work.id,
      "department": work.department.rgnl_name,
      "place": work.place.panch_name,
      "desc": work.desc,
      "sanctioned_amount": work.sanctioned_amount,
      "foundation_date": work.foundation_date,
      "inaugration_date": work.inaugration_date,
      "name": work.rgnl_name,
      "remarks": work.remarks,
      "created_at": work.created_at,
      "updated_at": work.updated_at,
      "status": (work.entity_status.rgnl_name rescue "NA"),
      "images": work.stored_images.map{|x| x.image_url}
    }
  end
end
