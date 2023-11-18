# frozen_string_literal: true

class UfoDatum < ApplicationRecord
  belongs_to :ufo,
             inverse_of: :ufo_datum,
             dependent: :destroy
  has_many :document, as: :documentable
  has_many :image, as: :imageable

  validates :max_crew_size, numericality: { only_integer: true, allow_nil: true }
end
