# frozen_string_literal: true

class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :likes

  def likes
    self.object.likes.count
  end
end
