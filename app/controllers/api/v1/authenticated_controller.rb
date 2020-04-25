class Api::V1::AuthenticatedController < Api::BaseController

  before_action :authenticate, except: [:login]

  def login

  end
end