class StoredImage < ApplicationRecord
  mount_uploader :image, ImageUploader

  belongs_to :media, polymorphic: true, optional: true
end
