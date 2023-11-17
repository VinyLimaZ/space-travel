Fabricator(:travel) do
  beginning_date { 1.day.from_now }
  duration { 1 }
  planet
  spacecraft
  description { 'Isso é definitivamente uma descrição' }
  status { 'scheduled' }
end
