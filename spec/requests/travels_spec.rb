# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Travels', type: :request do
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let!(:travels) { [travel_one, travel_two] }
  before { do_request }

  describe 'GET /index' do
    let(:do_request) { get '/travels', as: :json }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'returns a json with all travels' do
      expect(json).to include_json(
        travels: [
          {
            id: travel_one.id,
            beginning_date: travel_one.beginning_date,
            duration: travel_one.duration,
            planet_id: travel_one.planet_id,
            spacecraft_id: travel_one.spacecraft_id,
            description: travel_one.description,
            status: travel_one.status
          },
          {
            id: travel_two.id,
            beginning_date: travel_two.beginning_date,
            duration: travel_two.duration,
            planet_id: travel_two.planet_id,
            spacecraft_id: travel_two.spacecraft_id,
            description: travel_two.description,
            status: travel_two.status
          }
        ]
      )
    end
  end

  describe 'GET /show' do
    let(:travel) { travels.sample }
    let(:travel_id) { travel.id }
    let(:do_request) { get "/travels/#{travel_id}", as: :json }

    context 'when querying a valid travel' do
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'returns a json with the queried travel' do
        expect(json).to include_json(
          travels: {
            id: travel.id,
            beginning_date: travel.beginning_date,
            duration: travel.duration,
            planet_id: travel.planet_id,
            spacecraft_id: travel.spacecraft_id,
            description: travel.description,
            status: travel.status
          }
        )
      end
    end

    context 'when querying a missing travel' do
      let(:travel_id) { Travel.last.id + 9999 }

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

  describe 'POST /create' do
    let(:do_request) { post '/travels', as: :json, params: create_params }

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    context 'with valid attributes' do
      it 'create a new travel entity' do
        expect(json).to include_json(
          travels: {
            beginning_date: create_params[:beginning_date],
            duration: create_params[:duration],
            planet_id: create_params[:planet_id],
            spacecraft_id: create_params[:spacecraft_id],
            description: create_params[:description],
            status: scheduled_status[:status]
          }
        )
      end
    end

    context 'with required params missing' do
      let(:do_request) { post '/travels', as: :json, params: {} }

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

  describe 'PATCH /update' do
    let(:do_request) { patch "/travels/#{travel_one.id}", as: :json, params: update_params }

    context 'with valid params' do
      it 'returns http success' do
        expect(response).to have_http_status(:success)
      end

      it 'renders the updated object' do
        expect(json).to include_json(
          travels:
          {
            id: travel_one.id,
            beginning_date: travel_one.beginning_date,
            duration: travel_one.duration,
            planet_id: travel_one.planet_id,
            spacecraft_id: travel_one.spacecraft_id,
            description: travel_one.description,
            status: update_params[:status]
          }
        )
      end
    end

    context 'with missing or invalid params' do
      let(:update_params) { {} }

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

  let(:travel_one) { Fabricate.build(:travel).tap(&:save) }
  let(:travel_two) { Fabricate.build(:travel).tap(&:save) }
  let(:planet) { Fabricate(:planet) }
  let(:ufo) { Fabricate(:ufo) }

  let(:create_params) do
    {
      beginning_date: Date.tomorrow.strftime,
      duration: 1,
      planet_id: planet.id,
      spacecraft_id: ufo.id,
      description: 'descrição'
    }
  end

  let(:update_params) { { status: 'aborted' } }
  let(:scheduled_status) { { status: 'scheduled' } }
end
