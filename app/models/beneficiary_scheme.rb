class BeneficiaryScheme < ApplicationRecord
  include Documented
  include Imaged

  belongs_to :place
  belongs_to :scheme_type
  belongs_to :entity_status
  belongs_to :user, optional: true

  validates :scheme_type, :application_date, :beneficiary_name, :beneficiary_phone, presence: true
  before_save :associate_user

  private
    def associate_user
      self.user = User.find_by(phone: beneficiary_phone) rescue nil
    end

end
