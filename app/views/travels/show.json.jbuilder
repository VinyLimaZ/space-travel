# frozen_string_literal: true

json.travels do
  json.partial! 'travels/travel', travel: @travel
end
