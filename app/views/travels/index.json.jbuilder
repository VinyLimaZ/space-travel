json.travels do
  json.partial! 'travels/travel', collection: @travels, as: :travel
end
