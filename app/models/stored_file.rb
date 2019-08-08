class StoredFile < ApplicationRecord
  mount_uploader :document, DocumentUploader

  belongs_to :storage, polymorphic: true, optional: true
end
