# frozen_string_literal: true

json.merge! spacecraft.attributes
json.partial! spacecraft.payload, as: :payload
