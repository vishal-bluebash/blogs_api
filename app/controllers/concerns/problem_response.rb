# frozen_string_literal: true

# Return a standard json response
# for selected 4xx REST errors
module ProblemResponse
  extend ActiveSupport::Concern

  MAPPED_RAILS_ERRORS = {
    ActiveRecord::RecordNotFound => Rest::Problem::NotFound,
    JWT::DecodeError             => Rest::Problem::Unauthorized,
    JWT::InvalidIssuerError      => Rest::Problem::Unauthorized,
    JWT::ExpiredSignature        => Rest::Problem::Unauthorized,
    JWT::VerificationError       => Rest::Problem::Unauthorized,
  }

  # Use a custom error for non-existing paths
  # instead of ActionController::RoutingError
  #
  def route_not_found
    I18n.t("errors.route.not_found", path: request.path).tap do |message|
      raise Rest::Problem::NotFound.new(message)
    end
  end

  included do
    %w[NotFound BadRequest Unauthorized Forbidden UnprocessableEntity]
      .map { |class_name| "Rest::Problem::#{class_name}".constantize }
      .each do |error_class|
        rescue_from error_class do |error|
          render_error(error)
        end
      end

    ProblemResponse::MAPPED_RAILS_ERRORS.each do |error_class, problem_class|
      rescue_from error_class do |e|
        render_error problem_class.new(e.message)
      end
    end

    private
      def render_error(error)
        error.request = request
        set_response_headers(error.headers)
        render json: error.body, status: error.status
      end

      def set_response_headers(hash)
        hash.each do |header_name, header_value|
          response.set_header(header_name, header_value)
        end
      end
  end
end
