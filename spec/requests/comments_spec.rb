# frozen_string_literal: true

require "swagger_helper"

RSpec.describe "Comments", type: :request do
  let(:user_1) { create(:user) }

  describe "Comments API" do
    path "/posts/{post_id}/comments" do
      post "Comment" do
        tags "Comment"
        consumes "application/json"
        produces "application/json"
        security [ jwt_token: [] ]
        parameter name: :Authorization, in: :header, type: :string
        parameter name: :post_id, in: :path, type: :string, format: :uuid
        parameter name: :params, in: :body, schema: {
          "$ref" => "#/components/schemas/comment"
        }

        response "201", :created do
          let(:params) {
                          {
                            content: "first comment",
                          }
                        }
          let(:post_id) { create(:post).id }
          let(:Authorization) { jwt_token(user_1)  }
          run_test!
        end

        response "404", :not_found do
          let(:params) {
                          {
                            content: "first comment"
                          }
                        }
          let(:post_id) { 1111 }
          let(:Authorization) { jwt_token(user_1)  }
          run_test!
        end

        response "401", :unauthorized do
          let(:params) {
                          {
                            content: "first comment"
                          }
                        }
          let(:post_id) { create(:post).id }
          let(:Authorization) { ""  }
          run_test!
        end
      end
    end
  end
end
