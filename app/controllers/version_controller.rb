# frozen_string_literal: true

class VersionController < ApplicationController
  skip_before_action :authenticate_request

  def show
    render json: { version: "0.0.1" }, status: :ok
  end
end
