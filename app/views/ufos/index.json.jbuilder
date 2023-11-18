# frozen_string_literal: true

json.ufos do
  json.partial! 'ufos/ufo', collection: @spacecrafts, as: :spacecraft
end
