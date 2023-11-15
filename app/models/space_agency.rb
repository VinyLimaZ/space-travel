class SpaceAgency < ApplicationRecord
  has_many :document, as: :documentable
  validates :name, presence: true
end
