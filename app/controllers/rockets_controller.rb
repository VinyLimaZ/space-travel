class RocketsController < ApplicationController
  def index
    @spacecrafts = Rocket.all

    render formats: :json
  end

  def show
    @spacecraft = Rocket.find(params[:id])

    render formats: :json
  end

  def create
    @spacecraft = Rocket.new(rocket_params)

    if @spacecraft.save
      render :show, formats: :json
    else
      render 'spacecrafts/error', as: :json, status: :unprocessable_entity
    end
  end

  def update
    @spacecraft = Rocket.find(params[:id])

    if @spacecraft.update(rocket_params)
      render :show, formats: :json
    else
      render 'spacecrafts/error', as: :json, status: :unprocessable_entity
    end
  end

  private

  def rocket_params
    params.require(:rocket).permit(
      :name, :velocity, :space_agency_id, :fuel_in_days,
      rocket_datum_attributes: [:payload_id]
    )
  end
end
