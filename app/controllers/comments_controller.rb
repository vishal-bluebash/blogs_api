# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_post

  def create
    comment = @post.comments.build(comment_params)
    if comment.save
      head :created
    else
      raise Rest::Problem::UnprocessableEntity.new(comment.errors.full_messages)
    end
  end

  private
    def comment_params
      params.fetch(:comment, params).permit(:content).tap do |wl|
        wl[:user_id] = current_user.id
      end
    end

    def set_post
      @post = Post.find(params[:post_id])
    end
end
