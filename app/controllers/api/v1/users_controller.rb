class Api::V1::UsersController < Api::V1::AuthenticatedController
  before_action :set_user_params, only: [:create]


  def create
  #  TODO
  end

  def set_user_params
    @first_name = params[:first_name]
    @last_name = params[:last_name]
    @phone_number = params[:phone_number]
    @email = params[:email]
  end
end