# frozen_string_literal: true

class SpacecraftsController < ApplicationController
  def index
    @spacecrafts = Spacecraft.all
  end

  def show
    @spacecraft = Spacecraft.find_by_id(params[:id])
  end
end
