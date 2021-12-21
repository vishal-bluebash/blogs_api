# frozen_string_literal: true

class Auth::SessionsController < ApplicationController
  skip_before_action :authenticate_request

  def create
    @user = User.find_by_email(params[:email])
    if @user&.authenticate(params[:password])
      token = jwt_encode(user_id: @user.id)
      render json: { token: token }, status: :ok
    else
      raise Rest::Problem::Unauthorized.new(I18n.t("sessions.wrong_login_or_password"))
    end
  end
end
