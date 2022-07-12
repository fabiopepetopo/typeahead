# frozen_string_literal: true

module ErrorHandlingConcern
  extend ActiveSupport::Concern

  included do
    rescue_from Record::NotFound, with: :bad_request_exception
    rescue_from ActionController::BadRequest, with: :bad_request_exception
    rescue_from ActionController::ParameterMissing, with: :bad_request_exception
    rescue_from ArgumentError, with: :argument_error
  end

  private

  def argument_error(exception)
    raise exception unless exception.message.match?(/is not a valid/)

    errors = [{
      status: 422,
      error: 'Unprocessable Entity',
      message: exception.message
    }]

    unprocessable_entity_errors(errors)
  end

  def bad_request_exception(exception)
    bad_request_error(message: exception.message)
  end

  def bad_request_error(error = {})
    @error = {
      status: 400,
      error: 'Bad Request'
    }.merge!(error)

    render 'errors/show', status: :bad_request
  end

  def unprocessable_entity_error(error = {})
    @error = {
      status: 422,
      error: 'Unprocessable Entity'
    }.merge!(error)

    render 'errors/show', status: :not_found
  end

  def unprocessable_entity_errors(errors = [])
    @errors = errors.map do |error|
      {
        status: 422,
        error: 'Unprocessable Entity'
      }.merge(error)
    end

    render 'errors/index', status: :unprocessable_entity
  end
end
