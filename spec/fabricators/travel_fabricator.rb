# frozen_string_literal: true

Fabricator(:travel) do
  beginning_date { 1.day.from_now }
  duration { 1 }
  planet
  spacecraft { Fabricate.build(:ufo) }
  description { 'Isso é definitivamente uma descrição' }
  status { 'scheduled' }
end
