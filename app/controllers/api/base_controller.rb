
class Api::BaseController < ActionController::API
  include ActionController::MimeResponds

  HTTP_HEADER_DEVICE_TOKEN = 'X-Device-Token'.freeze
  HTTP_HEADER_APP_VERSION = 'App-Version'.freeze

  def request_device_token
    request.headers[HTTP_HEADER_DEVICE_TOKEN]
  end

  def boolean_cast(value)
    @boolean_type ||= ActiveRecord::Type::Boolean.new
    @boolean_type.cast(value)
  end
end