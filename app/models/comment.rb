# frozen_string_literal: true

class Comment < ApplicationRecord
  # validations
  validates :content, presence: true

  # associations
  belongs_to :post
  has_many :likes, as: :likeable
end
