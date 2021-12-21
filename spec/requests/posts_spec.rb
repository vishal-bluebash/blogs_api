# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Posts", type: :request do
  let(:user_1) { FactoryBot.create(:user) }
  let(:post_1) { FactoryBot.create(:post) }

  describe "Posts API" do
    get "Find all Posts" do
      tags "Posts"
      consumes "application/json"
      produces "application/json"

      response "200", :success do
        schema type: :array, items: { "$ref" => "#/components/schemas/post" }
      end
    end

    path "/posts" do
      post "Post" do
        tags "posts"
        consumes "application/json"
        produces "application/json"
        security [ jwt_token: [] ]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :params, in: :body, schema: {
          "$ref" => "#/components/schemas/post"
        }

        response "201", :created do
          let(:params) {
                          {
                            title: "first post",
                          }
                        }
          let(:Authorization) { jwt_token(user_1)  }
          run_test!
        end

        response "422", :unprocessable_entity do
          let(:params) {
                          {
                            name: "<invalid attribute name>",
                          }
                        }
          let(:Authorization) { jwt_token(user_1)  }
          run_test!
        end

        response "401", :unauthorized do
          let(:params) {
            {
              title: "ok"
            }
          }
          let(:Authorization) { ""  }
          run_test!
        end
      end
    end
  end
end
