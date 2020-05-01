class Api::V1::AuthenticatedController < Api::BaseController

  before_action :authenticate, except: [:login]
  before_action :set_login_params, only: [:login]

  def login
    phone = Phone.find_by(number: @phone_number)
    raise ApiExceptions::PhoneNotFound unless phone.present?
    raise ApiExceptions::VerificationCodeInvalid unless phone.verification_code == @verification_code
    raise ApiExceptions::VerificationCodeExpired unless phone.verification_code_expires_at > Time.now

    user = User.find_or_create!(@phone_number)
    token = JsonWebToken.encode(user_id: user.id)
    render status: :ok, json: { jwt_token: token, is_new_account: user.registration_incomplete? }
  end

  def authenticate
    begin
      decoded_payload = JsonWebToken.decode(request_jwt_token)
      @current_user = User.find(decoded_payload[:user_id])
    rescue JWT::DecodeError
      raise ApiExceptions::AuthorizationTokenInvalid
    rescue ActiveRecord::RecordNotFound
      raise ApiExceptions::UserNotFound
    end
  end

  def set_login_params
    raise ApiExceptions::MissingParameters unless params[:verification_code] && params[:phone_number]
    @verification_code = params[:verification_code].to_s.strip
    raise ApiExceptions::VerificationCodeInvalid unless Phone.verification_code_plausible?(@verification_code)
    @phone_number = params[:phone_number]
    raise ApiExceptions::PhoneNotPlausible unless Phony.plausible?(@phone_number)
    @phone_number = Phone.normalize_number(@phone_number)
  end
end