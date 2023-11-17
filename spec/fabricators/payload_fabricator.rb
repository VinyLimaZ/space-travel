Fabricator(:payload) do
  name { 'Carregamento' }
  weight { 100 }
  kind { Payload.kinds.keys.sample }
end
