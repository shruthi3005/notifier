class Appointment < ApplicationRecord
  include Documented

  belongs_to :user
  belongs_to :entity_status, optional: true

  validates :event_name, :org_name, :org_name, :venue, :req_date, :req_time, :details, presence: true

  def self.select_without columns
    select(column_names - columns.map(&:to_s))
  end
  
end
