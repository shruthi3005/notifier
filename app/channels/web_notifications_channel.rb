class WebNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "web_notifications_channel"
  end

  def subscribed(reciever_id)
    stream_from "web_notifications_channel_#{params[:reciever_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end

