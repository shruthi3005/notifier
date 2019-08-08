class Taluk < ApplicationRecord
  include Regional

  belongs_to :district
  has_many :panchayats, dependent: :destroy
  has_many :places, through: :panchayats
  accepts_nested_attributes_for :panchayats, allow_destroy: true

  scope :internal, -> { where(internal: true) }
  scope :external, -> { where(internal: false) }
end
