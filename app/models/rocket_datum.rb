class RocketDatum < ApplicationRecord
  belongs_to :rocket,
    inverse_of: :rocket_datum,
    dependent: :destroy

  belongs_to :payload
end
