class Citizen < ApplicationRecord
  include Regional
  
  belongs_to :position
  belongs_to :user, optional: true
  belongs_to :place

  validates :name, :gender, presence: true
  validates :phone, :presence => true, uniqueness: true, :numericality => true,
    :length => {is: 10}
  # before_save :set_age

  private
    def set_age
      now = Time.now.utc.to_date
      self.age = (now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1))
    end
end
