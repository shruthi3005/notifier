class DevelopmentWork < ApplicationRecord
  include Regional
  include Documented
  include Imaged
  
  belongs_to :valid_type
  belongs_to :place
  belongs_to :department
  belongs_to :entity_status

  validates :fy, presence: true

  before_save :set_defaults

  def self.amount_sum
    self.pluck(:sanctioned_amount).compact.inject(:+)
  end

  private
    def set_defaults
      self.sanctioned_amount = 0 if self.sanctioned_amount.blank?
      self.estimated_amount = 0 if self.estimated_amount.blank?
    end
end
