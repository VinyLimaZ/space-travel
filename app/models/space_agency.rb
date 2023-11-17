class SpaceAgency < ApplicationRecord
  has_many :document, as: :documentable
  has_many :image, as: :imageable
  has_many :spacecrafts

  validates :name, presence: true
end
