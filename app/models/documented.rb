module Documented
  extend ActiveSupport::Concern

  included do
    has_many :stored_files, as: :storage, dependent: :destroy
    accepts_nested_attributes_for :stored_files, allow_destroy: true
  end
end
