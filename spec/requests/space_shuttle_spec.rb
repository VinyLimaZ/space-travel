require 'rails_helper'

RSpec.describe "SpaceShuttles", type: :request do
  let(:json) { JSON.parse(response.body, symbolize_names: true) }
  let!(:space_shuttles) { [space_shuttle_one, space_shuttle_two] }
  before { do_request }

  describe "GET /index" do
    let(:do_request) { get "/space_shuttles", as: :json }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it 'returns a json with all space_shuttles' do
      expect(json).to include_json(
        space_shuttles: [
          {
            id: space_shuttle_one.id,
            name: space_shuttle_one.name,
            velocity: space_shuttle_one.velocity,
            fuel_in_days: space_shuttle_one.fuel_in_days,
            type: space_shuttle_one.type,
            max_crew_size: space_shuttle_one.max_crew_size
          },
          {
            id: space_shuttle_two.id,
            name: space_shuttle_two.name,
            velocity: space_shuttle_two.velocity,
            fuel_in_days: space_shuttle_two.fuel_in_days,
            type: space_shuttle_two.type,
            max_crew_size: space_shuttle_two.max_crew_size
          }
        ]
      )
    end
  end

  describe "GET /show" do
    let(:space_shuttle) { space_shuttles.sample }
    let(:space_shuttle_id) { space_shuttle.id }
    let(:do_request) { get "/space_shuttles/#{space_shuttle_id}", as: :json }

    context 'when querying a valid space_shuttle' do
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it 'returns a json with the queried space_shuttle' do
        expect(json).to include_json(
          space_shuttles: {
            id: space_shuttle.id,
            name: space_shuttle.name,
            velocity: space_shuttle.velocity,
            fuel_in_days: space_shuttle.fuel_in_days,
            type: space_shuttle.type,
            max_crew_size: space_shuttle_one.max_crew_size
          }
        )
      end
    end

    context 'when querying a missing space_shuttle' do
      let(:space_shuttle_id) { SpaceShuttle.last.id + 9999 }

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
    let(:do_request) { post "/space_shuttles", as: :json, params: create_params }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    context 'with valid attributes' do
      it 'create a new space_shuttle entity' do
        expect(json).to include_json(
          space_shuttles: {
            name: create_params[:name],
            velocity: create_params[:velocity],
            fuel_in_days: create_params[:fuel_in_days],
            max_crew_size: create_params[:space_shuttle_datum_attributes][:max_crew_size]
          })
      end
    end

    context 'with required params missing' do
      let(:do_request) { post "/space_shuttles", as: :json, params: {} }

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
    let(:do_request) { patch "/space_shuttles/#{space_shuttle_one.id}", as: :json, params: update_params }

    context 'with valid params' do
      it "returns http success" do
        expect(response).to have_http_status(:success)
      end

      it 'renders the updated object' do
        expect(json).to include_json(
          space_shuttles:
          {
            id: space_shuttle_one.id,
            name: update_params[:name],
            velocity: space_shuttle_one.velocity,
            fuel_in_days: space_shuttle_one.fuel_in_days,
            type: space_shuttle_one.type,
            max_crew_size: update_params[:space_shuttle_datum_attributes][:max_crew_size]
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

  let(:space_shuttle_one) { Fabricate.build(:space_shuttle).tap(&:save) }
  let(:space_shuttle_two) { Fabricate.build(:space_shuttle).tap(&:save) }
  let(:space_agency) { Fabricate(:space_agency) }
  let(:create_params) do
    {
      name: 'OVINI',
      velocity: 20,
      space_agency_id: space_agency.id,
      fuel_in_days: 20,
      space_shuttle_datum_attributes: {
        max_crew_size: 30
      }
    }
  end

  let(:update_params) do
    {
      name: 'SpaceW',
      space_shuttle_datum_attributes: {
        max_crew_size: 99
      }
    }
  end
end
