class Rocket < Spacecraft
  has_one :rocket_datum, required: false
  has_one :payload, through: :rocket_datum, required: false
end
