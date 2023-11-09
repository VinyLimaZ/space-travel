class Payload < ApplicationRecord
  validates :name, presence: true
  validates :weight, numericality: { only_integer: true }

  enum kind: {
    sattelite: 0,
    probe: 1,
    trash_disposal: 2,
    fuel: 3
  }
end
