class Position < ApplicationRecord
  include Regional

  VALID_TYPES = {
    internal: "Internal",
    public: "Public"
  }.freeze

  validates :name, :pos_type, presence: true
  validate :valid_position

  scope :internal, -> { where(pos_type: VALID_TYPES[:internal]) }
  scope :external, -> { where(pos_type: VALID_TYPES[:public]) }

  private
    def valid_position
      errors.add(:pos_type, "Invalid Position Selected") unless VALID_TYPES.values.include?(pos_type)
    end
end
