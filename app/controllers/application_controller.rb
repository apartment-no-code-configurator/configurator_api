require "#{Rails.root}/lib/error_handling/all_errors.rb"

class ApplicationController < ActionController::API

  include ErrorHandling::ErrorClasses

  rescue_from BadRequestError, AuthenticationError, ForbiddenError, UnprocessibleEntityError, with: :render_error_response

  private

  def cleanup_params(params)
    params.to_h.deep_symbolize_keys
  end

  def require_params(controller_identifier)
    params.require(controller_identifier)
  end

  def render_error_response(error)
    render json: error.message, status: error.status_code
  end

end
