module Regional
  extend ActiveSupport::Concern

  included do
    has_one :regional_name, as: :holder, dependent: :destroy

    delegate :name, to: :regional_name, prefix: true

    attr_accessor :regional_name_value
    after_save :set_regional_name, unless: Proc.new{|x| x.regional_name_value.blank?}
  end

  # Only add the regional name from reference 
  def rgnl_name
    # "#{self.regional_name.name+" - " rescue nil}#{self.name}"
     "#{self.regional_name.name rescue nil}"
  end

  protected
    def set_regional_name
      rgn = self.regional_name.blank? ? RegionalName.new(holder: self) : self.regional_name
      rgn.name = regional_name_value
      unless rgn.save
        self.errors.add(:regional_name_value, "#{rgn.errors.full_messages.join(",")}")
      end
    end
end
