# frozen_string_literal: true

class User < ApplicationRecord
  has_many :short_urls, dependent: :destroy
end
