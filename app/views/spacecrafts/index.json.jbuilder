# frozen_string_literal: true

json.spacecrafts do
  json.partial! 'spacecrafts/spacecraft', collection: @spacecrafts, as: :spacecraft
end
