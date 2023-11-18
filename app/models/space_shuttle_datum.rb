# frozen_string_literal: true

class SpaceShuttleDatum < ApplicationRecord
  belongs_to :space_shuttle,
             inverse_of: :space_shuttle_datum,
             dependent: :destroy
  has_many :document, as: :documentable
  has_many :image, as: :imageable

  validates :max_crew_size, numericality: { only_integer: true }
end
