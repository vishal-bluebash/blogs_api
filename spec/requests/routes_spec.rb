# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Route", type: :request do
  describe "not found" do
    let(:path) { "/non-existing-path" }

    before { get path }

    it "returns the expected custom headers" do
      expect(response.headers["Content-Type"]).to eq("application/problem+json")
      expect(response.headers["Content-Language"]).to eq("en")
    end

    it "returns status code 404" do
      expect(response).to have_http_status(404)
    end

    it "returns the expected body" do
      expect(json).to eq({
        "type" => "https://TBD",
        "title" => I18n.t("rest.problem.not_found"),
        "status" => 404,
        "detail" => "Path #{path} is not defined in existing routes",
        "instance" => path
      })
    end
  end
end
