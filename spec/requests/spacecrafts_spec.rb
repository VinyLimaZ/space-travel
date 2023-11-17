require 'rails_helper'

RSpec.describe "Spacecrafts", type: :request do
  let!(:spacecrafts) { [rocket, space_shuttle, ufo] }
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  describe "GET /index" do
    it "returns http success" do
      get "/spacecrafts", as: :json

      expect(response).to have_http_status(:success)
      expect(json).to include_json(
        spacecrafts: [
          {
            id: rocket.id,
            name: rocket.name,
            velocity: rocket.velocity,
            fuel_in_days: rocket.fuel_in_days,
            type: rocket.type,
            payload: {
              name: rocket.payload.name,
              weight: rocket.payload.weight,
              description: rocket.payload.description,
              kind: rocket.payload.kind
            }
          },
          {
            id: space_shuttle.id,
            name: space_shuttle.name,
            velocity: space_shuttle.velocity,
            fuel_in_days: space_shuttle.fuel_in_days,
            type: space_shuttle.type,
            max_crew_size: space_shuttle.max_crew_size
          },
          {
            id: ufo.id,
            name: ufo.name,
            velocity: ufo.velocity,
            fuel_in_days: ufo.fuel_in_days,
            type: ufo.type,
            max_crew_size: ufo.max_crew_size
          }
        ]
      )
    end
  end

  describe "GET /show" do
    let(:spacecraft) { spacecrafts.sample }

    it "returns http success" do
      get "/spacecrafts/#{spacecraft.id}", as: :json

      expect(response).to have_http_status(:success)
      expect(json).to include_json(
        spacecrafts:
          {
            id: spacecraft.id,
            name: spacecraft.name,
            velocity: spacecraft.velocity,
            fuel_in_days: spacecraft.fuel_in_days,
            type: spacecraft.type
          }
      )
    end
  end

  let(:space_agency) { Fabricator(:space_agency) }
  let(:payload) { Fabricator(:payload) }
  let(:rocket) { Fabricate.build(:rocket).tap(&:save) }
  let(:space_shuttle) { Fabricate.build(:space_shuttle).tap(&:save) }
  let(:ufo) { Fabricate.build(:ufo).tap(&:save) }
end
