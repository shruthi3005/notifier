class Department < ApplicationRecord
  include Regional
  validates :name, :email, :phone, presence: true

  default_scope { order(:name) }
end
