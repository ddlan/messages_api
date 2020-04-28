
class Api::BaseController < ActionController::API
  include ActionController::MimeResponds

  HTTP_HEADER_DEVICE_TOKEN = 'X-Device-Token'.freeze
  HTTP_HEADER_APP_VERSION = 'App-Version'.freeze

  rescue_from StandardError, with: :render_standard_error
  rescue_from ApiExceptions::ClientException, with: :render_client_exception
  rescue_from ApiExceptions::ServerException, with: :render_server_exception

  def request_device_token
    request.headers[HTTP_HEADER_DEVICE_TOKEN]
  end

  def render_standard_error(e)
    render status: :internal_server_error, json: {
        status: e.status || :internal_server_error,
        message: 'internal server error'
    }
  end

  def render_client_exception(e)
    render_exception(
        status: e.status || :bad_request,
        message: e.message
    )
  end

  def render_server_exception(e)
    render_exception(
        status: e.status || :internal_server_error,
        message: e.message
    )
  end

  def render_exception(status:, message:)
    render status: status, json: {
        message: message
    }
  end

  def boolean_cast(value)
    @boolean_type ||= ActiveRecord::Type::Boolean.new
    @boolean_type.cast(value)
  end
end