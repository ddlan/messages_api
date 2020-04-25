class Api::V1::UsersController < Api::V1::AuthenticatedController
  before_action :set_create_params, only: [:create]


  def create
    raise Errors::TermsConditionsNotAccepted unless @terms_and_conditions_accepted
    raise Errors::PhoneNumberBlank if @phone_number.blank?
  end

  def set_create_params
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @phone_number = params[:phone_number]
    @email = params[:email]
    @terms_and_conditions_accepted = boolean_cast(params[:terms_conditions_accepted] || 0)
  end
end