# frozen_string_literal: true

module ShortenerUrlCommands
  class Show
    prepend SimpleCommand

    def initialize(short_url:)
      @short_url = short_url
    end

    def call
      return false unless valid_short_url

      origin_url
    end

    private

    attr_reader :short_url

    def hash_id
      ShortenerUrl.get_hash_id(short_url)
    end

    def origin_url
      @url ||= ShortUrl.find_by(hash_id: hash_id)

      return @url.origin_url if @url.present?

      errors.add(:base, :short_url_not_found)
    end

    def valid_short_url
      return true if short_url.present?

      errors.add(:base, :short_url_is_required)
    end
  end
end
