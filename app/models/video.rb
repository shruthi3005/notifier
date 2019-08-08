class Video < ApplicationRecord
  belongs_to :media, polymorphic: true
  validates :vid_url, :desc, presence: true
end
