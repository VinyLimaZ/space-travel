class Rocket < Spacecraft
  has_one :rocket_datum
  has_one :payload, through: :rocket_datum
end
