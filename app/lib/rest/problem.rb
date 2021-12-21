# frozen_string_literal: true

module Rest
  # Defines standard errors basic structure & methods
  # following the recommendations from https://tools.ietf.org/html/rfc7807
  class Problem < ::StandardError
    class BadRequest               < Problem; end   # 400
    class Unauthorized             < Problem; end   # 401
    class Forbidden                < Problem; end   # 403
    class NotFound                 < Problem; end   # 404
    class UnprocessableEntity      < Problem; end   # 422

    attr_reader :status, :description_url, :title
    attr_accessor :request

    ATTRIBUTES = {
                   bad_request: {
                     status:          400,
                     description_url: "https://TBD",
                     title:           I18n.t("rest.problem.bad_request")
                   },
                   unauthorized: {
                     status:          401,
                     description_url: "https://TBD",
                     title:           I18n.t("rest.problem.unauthorized")
                   },
                   forbidden: {
                     status:          403,
                     description_url: "https://TBD",
                     title:           I18n.t("rest.problem.forbidden")
                   },
                   not_found: {
                     status:          404,
                     description_url: "https://TBD",
                     title:           I18n.t("rest.problem.not_found")
                   },
                   unprocessable_entity: {
                     status:          422,
                     description_url: "https://TBD",
                     title:           I18n.t("rest.problem.unprocessable_entity")
                   }
                 }

    def initialize(message)
      class_attributes.tap do |attrs|
        @status          = attrs[:status]
        @description_url = attrs[:description_url]
        @title           = attrs[:title]
      end

      super(message)
    end

    # e.g.: HTTP/1.1 403 Forbidden
    #       Content-Type: application/problem+json
    #       Content-Language: en
    def headers
      {
        "Content-Type" => "application/problem+json",
        "Content-Language" => "en"
      }
    end

    # e.g.: {
    #         "type": "https://example.com/probs/out-of-credit",
    #         "title": "You do not have enough credit.",
    #         "detail": "Your current balance is 30, but that costs 50.",
    #         "instance": "/account/12345/msgs/abc",
    #         "balance": 30,
    #         "accounts": ["/account/12345",
    #                      "/account/67890"]
    #        }
    def body
      {
        type:  description_url,
        title: title,
        status: status,
        detail: message,
        instance: request.path
      }
    end

    private
      def class_attributes
        ATTRIBUTES[self.class.name.split("::").last.underscore.to_sym]
      end
  end
end
