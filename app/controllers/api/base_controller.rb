
class Api::BaseController < ActionController::API
  include ActionController::MimeResponds

  HTTP_HEADER_DEVICE_TOKEN = 'X-Device-Token'.freeze
  HTTP_HEADER_APP_VERSION = 'App-Version'.freeze
  HTTP_HEADER_AUTHORIZATION = 'Authorization'.freeze

  rescue_from StandardError, with: :render_standard_error
  rescue_from KeyError, with: :render_key_error
  rescue_from ApiExceptions::ClientException, with: :render_client_exception
  rescue_from ApiExceptions::ServerException, with: :render_server_exception
  rescue_from ApiExceptions::UnauthorizedException, with: :render_unauthorized_exception

  def request_device_token
    request.headers[HTTP_HEADER_DEVICE_TOKEN]
  end

  def request_app_version
    request.headers[HTTP_HEADER_APP_VERSION]
  end

  def request_jwt_token
    header = request.headers[HTTP_HEADER_AUTHORIZATION]
    header.split(' ').last if header
  end

  def render_standard_error
    # TODO(Elman): can log this somewhere. These should be unexpected exceptions we need to fix
    render status: :internal_server_error, json: {
        status: :internal_server_error,
        message: 'internal server error'
    }
  end

  def render_key_error(e)
    render status: :bad_request, json: {
        status: :bad_request,
        message: e.message
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

  def render_unauthorized_exception(e)
    render_exception(
        status: e.status || :unauthorized,
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