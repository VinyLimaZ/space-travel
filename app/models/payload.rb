class Payload < ApplicationRecord
  has_many :document, as: :documentable
  has_many :image, as: :imageable

  validates :name, presence: true
  validates :weight, numericality: { only_integer: true }

  enum kind: {
    sattelite: 0,
    probe: 1,
    trash_disposal: 2,
    fuel: 3
  }
end
