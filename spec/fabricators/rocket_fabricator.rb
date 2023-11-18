# frozen_string_literal: true

Fabricator(:rocket) do
  name { 'SpaceY' }
  velocity { 10 }
  space_agency
  fuel_in_days { 10 }
  rocket_datum do
    Fabricate.build(:rocket_datum, rocket: nil)
  end
end
