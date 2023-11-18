require 'rails_helper'

RSpec.describe "Ufos", type: :request do
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let!(:ufos) { [ufo_one, ufo_two] }
  before { do_request }

  describe "GET /index" do
    let(:do_request) { get "/ufos", as: :json }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'returns a json with all ufos' do
      expect(json).to include_json(
        ufos: [
          {
            id: ufo_one.id,
            name: ufo_one.name,
            velocity: ufo_one.velocity,
            fuel_in_days: ufo_one.fuel_in_days,
            type: ufo_one.type,
            max_crew_size: ufo_one.max_crew_size
          },
          {
            id: ufo_two.id,
            name: ufo_two.name,
            velocity: ufo_two.velocity,
            fuel_in_days: ufo_two.fuel_in_days,
            type: ufo_two.type,
            max_crew_size: ufo_two.max_crew_size
          }
        ]
      )
    end
  end

  describe "GET /show" do
    let(:ufo) { ufos.sample }
    let(:ufo_id) { ufo.id }
    let(:do_request) { get "/ufos/#{ufo_id}", as: :json }

    context 'when querying a valid ufo' do
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it 'returns a json with the queried ufo' do
        expect(json).to include_json(
          ufos: {
            id: ufo.id,
            name: ufo.name,
            velocity: ufo.velocity,
            fuel_in_days: ufo.fuel_in_days,
            type: ufo.type,
            max_crew_size: ufo_one.max_crew_size
          }
        )
      end
    end

    context 'when querying a missing ufo' do
      let(:ufo_id) { Ufo.last.id + 9999 }

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
    let(:do_request) { post "/ufos", as: :json, params: create_params }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    context 'with valid attributes' do
      it 'create a new ufo entity' do
        expect(json).to include_json(
          ufos: {
            name: create_params[:name],
            velocity: create_params[:velocity],
            fuel_in_days: create_params[:fuel_in_days],
            max_crew_size: create_params[:ufo_datum_attributes][:max_crew_size]
          })
      end
    end

    context 'with required params missing' do
      let(:do_request) { post "/ufos", as: :json, params: {} }

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
    let(:do_request) { patch "/ufos/#{ufo_one.id}", as: :json, params: update_params }

    context 'with valid params' do
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it 'renders the updated object' do
        expect(json).to include_json(
          ufos:
          {
            id: ufo_one.id,
            name: update_params[:name],
            velocity: ufo_one.velocity,
            fuel_in_days: ufo_one.fuel_in_days,
            type: ufo_one.type,
            max_crew_size: update_params[:ufo_datum_attributes][:max_crew_size]
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

  let(:ufo_one) { Fabricate.build(:ufo).tap(&:save) }
  let(:ufo_two) { Fabricate.build(:ufo).tap(&:save) }
  let(:space_agency) { Fabricate(:space_agency) }
  let(:create_params) do
    {
      name: 'OVINI',
      velocity: 20,
      space_agency_id: space_agency.id,
      fuel_in_days: 20,
      ufo_datum_attributes: {
        max_crew_size: 30
      }
    }
  end

  let(:update_params) do
    {
      name: 'SpaceW',
      ufo_datum_attributes: {
        max_crew_size: 99
      }
    }
  end
end
