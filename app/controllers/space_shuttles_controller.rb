class SpaceShuttlesController < ApplicationController
  def index
    @spacecrafts = SpaceShuttle.all

    render formats: :json
  end

  def show
    @spacecraft = SpaceShuttle.find(params[:id])

    render formats: :json
  end

  def create
    @spacecraft = SpaceShuttle.new(space_shuttle_params)

    if @spacecraft.save
      render :show, formats: :json
    else
      render 'spacecrafts/error', as: :json, status: :unprocessable_entity
    end
  end

  def update
    @spacecraft = SpaceShuttle.find(params[:id])

    if @spacecraft.update(space_shuttle_params)
      render :show, formats: :json
    else
      render 'spacecrafts/error', as: :json, status: :unprocessable_entity
    end
  end

  private

  def space_shuttle_params
    params.require(:space_shuttle).permit(
      :name, :velocity, :space_agency_id, :fuel_in_days,
      space_shuttle_datum_attributes: [:max_crew_size]
    )
  end
end
