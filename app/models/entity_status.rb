class EntityStatus < ApplicationRecord
  include Regional

  VALID_TYPES = {
    dev_work: "DevelopmentWork",
    benf_scheme: "BeneficiaryScheme",
    feedback: "Feedback",
    appointment: "Appointment"
  }.freeze

  validates :name, :code, :entity_type, presence: true

  default_scope {where(typed: false)}
end
