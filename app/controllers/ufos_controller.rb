class UfosController < ApplicationController
  def index
    @spacecrafts = Ufo.all

    render formats: :json
  end

  def show
    @spacecraft = Ufo.find(params[:id])

    render formats: :json
  end

  def create
    @spacecraft = Ufo.new(ufo_params)

    if @spacecraft.save
      render :show, formats: :json
    else
      render 'spacecrafts/error', as: :json, status: :unprocessable_entity
    end
  end

  def update
    @spacecraft = Ufo.find(params[:id])

    if @spacecraft.update(ufo_params)
      render :show, formats: :json
    else
      render 'spacecrafts/error', as: :json, status: :unprocessable_entity
    end
  end

  private

  def ufo_params
    params.require(:ufo).permit(
      :name, :velocity, :space_agency_id, :fuel_in_days,
      ufo_datum_attributes: [:max_crew_size]
    )
  end
end
