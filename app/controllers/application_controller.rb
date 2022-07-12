# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :set_response_format

  include ErrorHandlingConcern

  private

  def set_response_format
    request.format = :json
  end
end
