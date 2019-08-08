class Api::V1::FeedbacksController < Api::BaseController

  def create
    feedback = Feedback.new(feedback_params)
    feedback.user = current_user

    if feedback.save
      render json: feedback
    else
      render json: feedback.errors, status: :unprocessable_entity
    end    
  end

  # GET /feedbacks
  def index
    feedbacks = current_user.feedbacks.order(created_at: :desc).select_without([:details]).paginate(page: params[:page], per_page: 10)
    render json: feedbacks.map{|x|
      {
        "id": x.id,
        "status": (x.entity_status.rgnl_name rescue "NA"),
        "department": (x.department.rgnl_name rescue "NA"),
        "place": x.place.rgnl_name,
        "feedback_type": x.feedback_type,
        "action_taken": x.action_taken,
        "name": x.rgnl_name,
        "created_at": x.created_at,
        "updated_at": x.updated_at,
        "image": x.image_url
      }
    } 
  end

  # GET /feedbacks/1
  def show
    feedback = Feedback.find(params[:id])
    render json: {
      "id": feedback.id,
      "status": (feedback.entity_status.rgnl_name rescue "NA"),
      "department": (feedback.department.rgnl_name rescue "NA"),
      "place": feedback.place.rgnl_name,
      "feedback_type": feedback.feedback_type,
      "action_taken": feedback.action_taken,
      "name": feedback.rgnl_name,
      "created_at": feedback.created_at,
      "updated_at": feedback.updated_at,
      "images": feedback.stored_images.map{|x| x.image_url}
    }
  end

  private
    def feedback_params
      params.require(:feedback).permit(:place_id, :feedback_type, :department_id, 
        :name, :details, :action_taken, :entity_status_id,:regional_name_value,
          stored_file_whitelist, stored_image_whitelist)
    end

end
