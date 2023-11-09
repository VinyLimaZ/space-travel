class Payload < ApplicationRecord
  validates :name, presence: true
  validates :weight, numericality: { only_integer: true }
  enum kind: {
    sattelite: :sattelite,
    probe: :probe,
    trash_disposal: :trash_disposal,
    fuel: :fuel
  }
end
