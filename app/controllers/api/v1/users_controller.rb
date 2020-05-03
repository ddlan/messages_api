class Api::V1::UsersController < Api::V1::AuthenticatedController
  include EmailMixin
  before_action :set_update_params, only: [:update]

  # PUT /api/v1/users
  def update
    current_user.update_registration_data!(@first_name, @last_name, @email)
    render status: :ok, json: {}
  end

  def set_update_params
    @first_name = params.fetch(:first_name)
    @last_name = params.fetch(:last_name)
    @email = params.fetch(:email)
    raise ApiExceptions::EmailNotPlausible unless is_email_plausible?(@email)
  end
end