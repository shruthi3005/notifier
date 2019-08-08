class District < ApplicationRecord
  include Regional

  has_many :taluks
  has_many :panchayats, through: :taluks
  has_many :places, through: :panchayats
  
  accepts_nested_attributes_for :taluks, allow_destroy: true
end
