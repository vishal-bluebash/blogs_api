# frozen_string_literal: true

module ResponseRenderer
  extend ActiveSupport::Concern

  def render_json(obj)
    render json: obj,
           each_serializer: obj.is_a?(ActiveRecord::Relation) ? obj.first&.serializer : obj.serializer,
           status: success_http_status
  end

  def success_http_status
    return 201 if params[:action] == "create"
    return 204 if params[:action] == "destroy"
    200
  end
end
