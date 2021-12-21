# frozen_string_literal: true

class User < ApplicationRecord
  include JsonWebToken

  has_secure_password

  # validations
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  # associations
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
end
