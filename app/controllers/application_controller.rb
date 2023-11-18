# frozen_string_literal: true

class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_error
  rescue_from ActionController::ParameterMissing, with: :param_missing

  def not_found_error
    render 'spacecrafts/not_found_error', status: :not_found
  end

  def param_missing
    render 'spacecrafts/param_missing_error', status: :unprocessable_entity
  end
end
