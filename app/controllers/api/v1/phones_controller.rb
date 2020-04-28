class Api::V1::PhonesController < Api::BaseController
  before_action :set_create_params, only: [:create]

  # POST /api/v1/phone
  def create
    raise ApiExceptions::PhoneNotPlausible unless Phony.plausible?(@phone_number)
    phone = Phone.create_or_update!(@phone_number)
    Phone.send_twilio_verification_code(phone)
    render status: :ok, json: {}
  end

  def set_create_params
    @phone_number = params[:phone_number]
    @phone_number = '+' + Phony.normalize(@phone_number)
  end
end