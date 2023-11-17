json.merge! spacecraft.attributes

if spacecraft.has_crew?
  json.max_crew_size spacecraft.max_crew_size
end

if spacecraft.has_payload?
  json.partial! spacecraft.payload, as: :payload
end
