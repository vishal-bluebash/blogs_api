# frozen_string_literal: true

class ApplicationController < ActionController::API
  include ProblemResponse
  include ResponseRenderer
  include JsonWebToken

  attr_reader :current_user

  before_action :authenticate_request
  skip_before_action :authenticate_request, only: [:route_not_found]

  private
    def authenticate_request
      header = request.headers["Authorization"]
      header = header.split(" ").last if header
      decoded = jwt_decode(header)
      @current_user = User.find(decoded[:user_id])
    end
end
