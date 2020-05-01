class Api::V1::PhonesController < Api::BaseController
  before_action :set_create_params, only: [:create, :verification_code]

  # POST /api/v1/phone
  def create
    phone = Phone.create_or_update!(@phone_number)
    Phone.send_twilio_verification_code(phone)
    render status: :ok, json: {}
  end

  # GET /api/v1/verification_code/:phone_number
  def verification_code
    phone = Phone.find_by(number: @phone_number)
    raise ApiExceptions::PhoneNotFound unless phone.present?
    phone.update_verification_code!
    Phone.send_twilio_verification_code(phone)
    render status: :ok, json: {}
  end

  def set_create_params
    raise ApiExceptions::MissingParameters unless params[:phone_number]
    @phone_number = params[:phone_number]
    raise ApiExceptions::PhoneNotPlausible unless Phony.plausible?(@phone_number)
    @phone_number = Phone.normalize_number(@phone_number)
  end
end
