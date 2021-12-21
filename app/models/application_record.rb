# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def serializer
    "#{self.class.name}Serializer".constantize
  end
end
