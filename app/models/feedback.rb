class Feedback < ApplicationRecord
  include Regional
  include Documented
  include Imaged

  VALID_TYPES = {
    suggestion: "ಸಲಹೆ - Suggestion",
    requirement: "ಬೇಡಿಕೆ - Requirement",
    complaint: "ದೂರು - Complaint"
  }.freeze

  belongs_to :place
  belongs_to :user
  belongs_to :department, optional: true
  belongs_to :entity_status, optional: true

  validates :name, :details, :feedback_type, presence: true
  validate :feedback_type_valid

  def self.select_without columns
    select(column_names - columns.map(&:to_s))
  end

  def feedback_type_valid
    errors.add(:feedback_type, "Invalid - should be in #{VALID_TYPES.values.join(", ")}") unless VALID_TYPES.values.include?(feedback_type)
  end
end
