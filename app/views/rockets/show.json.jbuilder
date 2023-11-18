# frozen_string_literal: true

json.rockets do
  json.partial! 'rockets/rocket', spacecraft: @spacecraft
end
