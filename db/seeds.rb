# frozen_string_literal: true

planet = Fabricate.times(4,:planet).last
space_agency = Fabricate.times(4,:space_agency).last
payload = Fabricate.times(4, :payload).last

rocket_datum = Fabricate.build(:rocket_datum, payload: payload)
rocket = Fabricate.build(:rocket, rocket_datum: rocket_datum)
rocket.save

ufo_datum = Fabricate.build(:ufo_datum)
ufo = Fabricate.build(:ufo, ufo_datum: ufo_datum)
ufo.save

space_shuttle_datum = Fabricate.build(:space_shuttle_datum)
space_shuttle = Fabricate.build(:space_shuttle, space_shuttle_datum: space_shuttle_datum)
space_shuttle.save

Fabricate(:travel,  planet: planet, spacecraft: rocket)
Fabricate(:travel,  planet: planet, spacecraft: ufo)
Fabricate(:travel,  planet: planet, spacecraft: space_shuttle)
