# frozen_string_literal: true

json.rockets do
  json.partial! 'rockets/rocket', collection: @spacecrafts, as: :spacecraft
end
