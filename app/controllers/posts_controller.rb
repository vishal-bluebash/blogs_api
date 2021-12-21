# frozen_string_literal: true

class PostsController < ApplicationController
  skip_before_action :authenticate_request, only: [:index]

  def index
    @posts = Post.all.includes(:likes, comments: [:likes])
    render json: @posts, include: params[:include]
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      render_json post
    else
      raise Rest::Problem::UnprocessableEntity.new(post.errors.full_messages)
    end
  end

  private
    def post_params
      params.fetch(:post, params).permit(:title)
    end
end
