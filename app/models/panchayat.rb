class Panchayat < ApplicationRecord
  include Regional

  belongs_to :taluk
  has_many :places, dependent: :destroy
  accepts_nested_attributes_for :places, allow_destroy: true
  
  validates :name, presence: true

  scope :internal, -> { where(internal: true) }
  scope :external, -> { where(internal: false) }

  def full_name
    "#{"(Party) " if internal}#{rgnl_name}"
  end

  def district
    taluk.district
  end
end
