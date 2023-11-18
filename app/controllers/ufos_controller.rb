class UfosController < ApplicationController
  def index
    @spacecrafts = Ufo.all
  end

  def show
    @spacecraft = Ufo.find(params[:id])
  end

  def create
    @spacecraft = Ufo.new(ufo_params)

    if @spacecraft.save
      render :show
    else
      render 'spacecrafts/error', status: :unprocessable_entity
    end
  end

  def update
    @spacecraft = Ufo.find(params[:id])

    if @spacecraft.update(ufo_params)
      render :show
    else
      render 'spacecrafts/error', status: :unprocessable_entity
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
