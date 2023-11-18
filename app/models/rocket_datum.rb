# frozen_string_literal: true

class RocketDatum < ApplicationRecord
  belongs_to :rocket,
             inverse_of: :rocket_datum,
             dependent: :destroy

  belongs_to :payload
  has_many :document, as: :documentable
  has_many :image, as: :imageable
end
