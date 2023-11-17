json.payload do
  json.extract! payload, :name, :weight, :description, :kind
end
