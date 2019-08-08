class Notification < ApplicationRecord
  belongs_to :user
  validates :title, :content, :expiry, presence: true  

  scope :active, ->{where("expiry >= ?", Date.today).order(created_at: :desc)}

  after_commit :push_out

  def notify
    ActionCable.server.broadcast('web_notifications_channel', 
      heading: self.title, body: self.content)
  end

  def notify_specific_user(reciever_id)
    ActionCable.server.broadcast("web_notifications_channel_#{reciever_id}",
      heading: self.title, body: self.content)
  end

  private
    def push_out
      notify if self.push
    end
end
