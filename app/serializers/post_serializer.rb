# frozen_string_literal: true

class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :created_at, :likes
  has_many :comments

  def likes
    self.object.likes.count
  end
end
