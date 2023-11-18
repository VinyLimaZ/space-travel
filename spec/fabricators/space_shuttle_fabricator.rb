# frozen_string_literal: true

Fabricator(:space_shuttle) do
  name { 'Busão' }
  velocity { 10 }
  space_agency
  fuel_in_days { 10 }
  space_shuttle_datum do
    Fabricate.build(:space_shuttle_datum, space_shuttle: nil)
  end
end
