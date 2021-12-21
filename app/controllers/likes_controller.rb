# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :find_likeable

  def create
    like = current_user.likes.build(likeable: @likeable)
    if like.save
      head :created
    else
      raise Rest::Problem::UnprocessableEntity.new(like.errors.full_messages)
    end
  end

  private
    def find_likeable
      @klass = params[:likeable_type].capitalize.constantize
      @likeable = @klass.find(params[:likeable_id])
    end
end
