class SpaceAgency < ApplicationRecord
  has_many :document, as: :documentable
  has_many :image, as: :imageable

  validates :name, presence: true
end
