class SpacecraftsController < ApplicationController
  def index
    @spacecrafts = Spacecraft.all
    render formats: :json
  end

  def show
    @spacecraft = Spacecraft.find_by_id(params[:id])
    render format: :json
  end
end
