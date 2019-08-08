class Place < ApplicationRecord
  include Regional

  VALID_TYPES = {
    village: "Village",
    ward: "Ward",
    hamlet: "Hamlet"
  }.freeze

  belongs_to :panchayat
  has_many :beneficiary_schemes
  has_many :development_works
  has_many :citizens

  scope :internal, -> { where(internal: true) }
  scope :external, -> { where(internal: false) }

  before_save :set_full_name
  
  def self.good_search(criteria)
    regexp = /#{criteria}/i; # case-insensitive regexp based on your string

    result = order(:name).where("name LIKE ?", "%#{criteria}%").limit(10)
    result.sort{|x, y| (x =~ regexp) <=> (y =~ regexp) } 
  end

  def taluk
    self.panchayat.taluk
  end

  def district
    self.taluk.district
  end

  def panch_name
    "#{rgnl_name} - #{panchayat.rgnl_name} - #{taluk.rgnl_name}"
  end

  def set_full_name
    self.full_name = "#{name} - #{panchayat.name} - #{taluk.name} - #{district.name}"
  end
end
