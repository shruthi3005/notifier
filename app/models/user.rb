class User < ApplicationRecord

  VALID_TYPES = {
    admin: "Admin",
    customer: "Customer"
  }.freeze

  VALID_GENDERS = %w{male female others}.freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  
  has_one :citizen
  has_many :beneficiary_schemes
  has_many :feedbacks
  has_many :appointments

  validates :name, :gender, presence: true
  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..40},
                       :on => :create
  validates :phone, :presence => true, uniqueness: true, :numericality => true,
    :length => {is: 10}
  validate :gender_set

  before_create :validate_password
  after_commit :update_citizen_data, :associate_records, on: :create
  after_update :update_citizen_data, if: :details_changed?

  attr_accessor :position_id, :place_id

  def admin?
    return user_type == VALID_TYPES[:admin]
  end

  def name_phone
    "#{name} - #{phone}"
  end

  def valid_password?(password)
    if ::Rails.env == "development" # and password == "RESTRICT TO ONE MASTER PW"
      true
    else
      super
    end
  end

  def validate_password
    errors.add(:password, "cannot be blank") and return if password.blank?
    errors.add(:password, "cannot be \"password\"") if password == "password"
    errors.add(:password_confirmation, "does not match") if password != password_confirmation
  end

  def update_access_token
    self.access_token = loop do
      random_token = SecureRandom.hex(32)
      break random_token unless User.exists?(access_token: random_token)
    end
    self.access_token_expiry = Time.now + 14.days
    self.save
  end

  def update_citizen_data
    cit = Citizen.where(phone: phone).first_or_initialize
    cit.name = name
    cit.email = email
    cit.gender = gender
    cit.position_id = position_id
    cit.place_id = place_id
    cit.dob = dob
    cit.pincode = pincode
    cit.address = address
    cit.user = self
    cit.save(validate: false)
  end

  private
    def associate_records
      BeneficiaryScheme.where(beneficiary_phone: self.phone).update_all(user_id: self.id)
    end

    def details_changed?
      attrs = ["name", "age", "dob", "email", "phone", "gender", "addl_details", "pincode", "address", "regional_name_value", "position_id", "place_id"]

      if (self.saved_changes.keys & attrs).any?
        return true
      end

      return false
    end

    def gender_set
      errors.add(:gender, "Invalid, options: #{VALID_GENDERS.join}") unless (VALID_GENDERS.include?(self.gender.downcase) rescue false)
    end
end
