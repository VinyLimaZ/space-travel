class UfoDatum < ApplicationRecord
  belongs_to :ufo,
    inverse_of: :ufo_datum,
    dependent: :destroy

  validates :max_crew_size, numericality: { only_integer: true }
end
