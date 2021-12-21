# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "version", type: :request do
  path "/version" do
    get "Gets the API version" do
      tags "Version"
      produces "application/json", "application/xml"
      parameter name: :Authorization, in: :header, type: :string
      response "200", "API version" do
        schema type: :object,
          properties: {
            version: {
              type: :string,
              example: "0.0.1"
            }
          }
        let(:user) { create(:user) }
        let(:Authorization) { jwt_token(user)  }
        run_test!
      end
    end
  end
end
