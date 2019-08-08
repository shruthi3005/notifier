module Imaged
  extend ActiveSupport::Concern

  included do
    has_many :stored_images, as: :media, dependent: :destroy
    accepts_nested_attributes_for :stored_images, allow_destroy: true
  end

  def image_url
    self.stored_images.first.image_url rescue nil
  end
end
