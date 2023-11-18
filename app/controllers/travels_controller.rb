# frozen_string_literal: true

class TravelsController < ApplicationController
  def index
    @travels = Travel.all
  end

  def show
    @travel = Travel.find(params[:id])
  end

  def create
    @travel = Travel.new(travel_params)

    if @travel.save
      render :show, format: :json
    else
      render :error, as: :json, status: :unprocessable_entity
    end
  end

  def update
    @travel = Travel.find(params[:id])

    if @travel.update(update_params)
      render :show, format: :json
    else
      render :error, format: :json
      render 'spacecrafts/error', as: :json, status: :unprocessable_entity
    end
  end

  private

  def travel_params
    params.require(:travel).permit(
      :beginning_date, :duration, :planet_id, :spacecraft_id, :description
    )
  end

  def update_params
    @update_params ||= travel_params.merge(status: params[:status])
  end
end
