class Api::V1::AppointmentsController < Api::BaseController

  def create
    appointment = Appointment.new(appointment_params)
    appointment.user = current_user

    if appointment.save
      render json: appointment
    else
      render json: appointment.errors, status: :unprocessable_entity
    end    
  end

  # GET /appointments
  def index
    appointments = current_user.appointments.order(created_at: :desc).select_without([:details, :remarks]).paginate(page: params[:page], per_page: 10)
    render json: appointments.map{|x|
      {
        "id": x.id,
        "title": x.event_name,
        "status": (x.entity_status.rgnl_name rescue "NA"),
        "organisation": (x.org_name),
        "venue": x.venue,
        "req_date": x.req_date,
        "req_time": x.req_time,
        "opt_date": x.opt_date,
        "opt_time": x.opt_time,
        "created_at": x.created_at,
        "updated_at": x.updated_at
      }
    } 
  end

  # GET /appointments/1
  def show
    appointment = Appointment.find(params[:id])
    render json: {
      "id": appointment.id,
      "title": appointment.event_name,
      "status": (appointment.entity_status.rgnl_name rescue "NA"),
      "organisation": (appointment.org_name),
      "venue": appointment.venue,
      "req_date": appointment.req_date,
      "req_time": appointment.req_time,
      "opt_date": appointment.opt_date,
      "opt_time": appointment.opt_time,
      "details": appointment.details,
      "remarks": appointment.remarks,
      "created_at": appointment.created_at,
      "updated_at": appointment.updated_at
    }
  end

  private
    def appointment_params
      params.require(:appointment).permit(:org_name, :event_name, :venue, :details, :req_date, 
        :req_time, :opt_date, :opt_time, :remarks)
    end

end
