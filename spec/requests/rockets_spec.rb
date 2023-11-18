require 'rails_helper'

RSpec.describe "Rockets", type: :request do
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let!(:rockets) { [rocket_one, rocket_two] }
  before { do_request }

  describe "GET /index" do
    let(:do_request) { get "/rockets", as: :json }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'returns a json with all rockets' do
      expect(json).to include_json(
        rockets: [
          {
            id: rocket_one.id,
            name: rocket_one.name,
            velocity: rocket_one.velocity,
            fuel_in_days: rocket_one.fuel_in_days,
            type: rocket_one.type,
            payload: {
              name: rocket_one.payload.name,
              weight: rocket_one.payload.weight,
              description: rocket_one.payload.description,
              kind: rocket_one.payload.kind
            }
          },
          {
            id: rocket_two.id,
            name: rocket_two.name,
            velocity: rocket_two.velocity,
            fuel_in_days: rocket_two.fuel_in_days,
            type: rocket_two.type,
            payload: {
              name: rocket_two.payload.name,
              weight: rocket_two.payload.weight,
              description: rocket_two.payload.description,
              kind: rocket_two.payload.kind
            }
          }
        ]
      )
    end
  end

  describe "GET /show" do
    let(:rocket) { rockets.sample }
    let(:rocket_id) { rocket.id }
    let(:do_request) { get "/rockets/#{rocket_id}", as: :json }

    context 'when querying a valid rocket' do
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it 'returns a json with the queried rocket' do
        expect(json).to include_json(
          rockets: {
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
          }
        )
      end
    end

    context 'when querying a missing rocket' do
      let(:rocket_id) { Rocket.last.id + 9999 }

      it 'returns http not_found' do
        expect(response).to have_http_status(:not_found)
      end

      it 'returns a not found error message' do
        expect(json).to include_json(
          error: {
            message: 'Record not found'
          }
        )
      end
    end
  end


  describe "POST /create" do
    let(:do_request) { post "/rockets", as: :json, params: create_params }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    context 'with valid attributes' do
      it 'create a new rocket entity' do
        expect(json).to include_json(
          rockets: {
            name: create_params[:name],
            velocity: create_params[:velocity],
            fuel_in_days: create_params[:fuel_in_days],
            payload: {
              id: payload.id,
              name: payload.name,
              weight: payload.weight,
              description: payload.description,
              kind: payload.kind
            }
          })
      end
    end

    context 'with required params missing' do
      let(:do_request) { post "/rockets", as: :json, params: {} }

      it 'returns http unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders an params missing error message' do
        expect(json).to include_json(
          error: {
            message: 'Please verify the params sent, something is missing'
          }
        )
      end
    end
  end

  describe "PATCH /update" do
    let(:do_request) { patch "/rockets/#{rocket_one.id}", as: :json, params: update_params }

    context 'with valid params' do
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it 'renders the updated object' do
        expect(json).to include_json(
          rockets:
          {
            id: rocket_one.id,
            name: update_params[:name],
            velocity: rocket_one.velocity,
            fuel_in_days: rocket_one.fuel_in_days,
            type: rocket_one.type,
            payload: {
              id: payload_two.id,
              name: payload_two.name,
              weight: payload_two.weight,
              description: payload_two.description,
              kind: payload_two.kind
            }
          }
        )
      end
    end

    context 'with missing or invalid params' do
      let(:update_params) {}

      it 'returns http unprocessable_entity' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'renders a params missing error' do
        expect(json).to include_json(
          error: {
            message: 'Please verify the params sent, something is missing'
          }
        )
      end
    end
  end

  let(:rocket_one) { Fabricate.build(:rocket).tap(&:save) }
  let(:rocket_two) { Fabricate.build(:rocket).tap(&:save) }
  let(:space_agency) { Fabricate(:space_agency) }
  let(:payload) { Fabricate(:payload) }
  let(:payload_two) { Fabricate(:payload) }
  let(:create_params) do
    {
      name: 'SpaceZ',
      velocity: 20,
      space_agency_id: space_agency.id,
      fuel_in_days: 20,
      rocket_datum_attributes: {
        payload_id: payload.id
      }
    }
  end

  let(:update_params) do
    {
      name: 'SpaceW',
      rocket_datum_attributes: {
        payload_id: payload_two.id
      }
    }
  end
end
