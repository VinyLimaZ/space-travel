json.merge! spacecraft.attributes

if spacecraft.crew?
  json.max_crew_size spacecraft.max_crew_size
end

if spacecraft.payload?
  json.partial! spacecraft.payload, as: :payload
end
