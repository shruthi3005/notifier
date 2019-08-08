class Api::V1::EventsController < Api::BaseController
  def index
    events = Event.where("date >= ? AND date <= ?",Date.today, (Date.today + 7.days)).order(:date, :start_time).paginate(page: params[:page], per_page: 10)
    render json: events.map{|x|
      {
        "id": x.id,
        "name": x.rgnl_name,
        "details": x.details,
        "date": x.date.strftime("%d-%m-%Y"),
        "start_time": x.start_time,
        "end_time": x.end_time,
        "venue": x.venue,
        "remarks": x.remarks,
        "created_at": x.created_at,
        "updated_at": x.updated_at
      }
    }
  end

  def show
    event = Event.find(params[:id])
    render json: {
      "id": event.id,
      "name": event.rgnl_name,
      "details": event.details,
      "date": event.date.strftime("%d-%m-%Y"),
      "start_time": event.start_time,
      "end_time": event.end_time,
      "venue": event.venue,
      "remarks": event.remarks,
      "created_at": event.created_at,
      "updated_at": event.updated_at
    }
  end
end
