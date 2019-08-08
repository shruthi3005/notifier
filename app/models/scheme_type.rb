class SchemeType < ApplicationRecord
  include Regional

  VALID_TYPES = {
    mla: "MLA Scheme",
    govt: "Govt. Scheme"
  }.freeze

  validates :name, :sub_type, presence: true
  validate :valid_scheme  

  def full_name
    "#{name} (#{sub_type})"
  end

  private
    def valid_scheme
      VALID_TYPES.values.include?(sub_type)
    end
end
