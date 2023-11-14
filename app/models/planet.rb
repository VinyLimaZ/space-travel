class Planet < ApplicationRecord
  has_many :travels

  validates :name, presence: true
  validates :earth_distance, numericality: { only_integer: true, greater_than: 0 }
end
