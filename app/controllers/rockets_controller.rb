class RocketsController < ApplicationController
  def index
    @spacecrafts = Rocket.all
  end

  def show
    @spacecraft = Rocket.find(params[:id])
  end

  def create
    @spacecraft = Rocket.new(rocket_params)

    if @spacecraft.save
      render :show
    else
      render 'spacecrafts/error', status: :unprocessable_entity
    end
  end

  def update
    @spacecraft = Rocket.find(params[:id])

    if @spacecraft.update(rocket_params)
      render :show
    else
      render 'spacecrafts/error', status: :unprocessable_entity
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
