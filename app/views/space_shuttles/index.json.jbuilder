# frozen_string_literal: true

json.space_shuttles do
  json.partial! 'space_shuttles/space_shuttle', collection: @spacecrafts, as: :spacecraft
end
