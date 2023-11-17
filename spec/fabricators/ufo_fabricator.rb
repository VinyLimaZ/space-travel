Fabricator(:ufo) do
  name { 'OVNI' }
  velocity { 10 }
  space_agency
  fuel_in_days { 10 }
  ufo_datum do
    Fabricate.build(:ufo_datum, ufo: nil)
  end
end
