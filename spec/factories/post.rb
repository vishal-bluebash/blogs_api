# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { FFaker::Name.name }
    user_id { create(:user).id }
  end
end
