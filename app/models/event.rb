class Event < ApplicationRecord
  include Regional
  include Documented
  include Imaged

  validates :start_time, :end_time, :date, :name, :venue, presence: true
  validate :schedule_overlap

  private
    def schedule_overlap
    end
end
