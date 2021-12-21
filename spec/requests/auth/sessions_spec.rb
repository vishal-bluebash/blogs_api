# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Sessions", type: :request do
  describe "Sessions API" do
    path "/auth/sessions" do
      post "Authentication" do
        tags "Sessions"
        consumes "application/json"
        produces "application/json"
        parameter name: :params, in: :body, schema: {
          type: :object,
          properties: {
            email: { type: :string },
            password: { type: :string },
          },
          required: ["email", "password"]
        }

        let(:user) { create(:user, email: "dummy@email.com", password: "dummy@123") }
        let(:params) { { email: user.email, password: "dummy@123" } }

        response "200", :success do
          run_test!
        end

        response "401", :unauthorized do
          let(:params) { { email: "dummy@gmail.com" } }
          run_test!
        end
      end
    end
  end
end
