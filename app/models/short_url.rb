# frozen_string_literal: true

class ShortUrl < ApplicationRecord
  belongs_to :user

  validates :origin_url, presence: true
  validates :hash_id, presence: true
end
