class Post < ApplicationRecord
  # validations
  validates :email, presence: true

  # associations
  has_many :posts
end
