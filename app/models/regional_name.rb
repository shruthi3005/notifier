class RegionalName < ApplicationRecord
  belongs_to :holder, polymorphic: true
end
