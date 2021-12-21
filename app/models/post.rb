# frozen_string_literal: true

class Post < ApplicationRecord
  # validations
  validates :title, presence: true

  # associations
  belongs_to :user
  has_many :comments
  has_many :likes, as: :likeable
end
