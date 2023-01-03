# frozen_string_literal: true

module ShortenerUrlCommands
  class Create
    prepend SimpleCommand

    def initialize(user:, params: {})
      @user   = user
      @params = params.symbolize_keys
    end

    def call
      return false unless valid

      user.short_urls.create!(hash_id: generate_hash_id, origin_url: params[:origin_url])

      short_url
    end

    private

    attr_reader(:user, :params)

    def generate_hash_id
      @generate_hash_id ||= ShortenerUrl.get_hash_id(short_url)
    end

    def short_url
      @short_url ||= ShortenerUrl.encode(custom_short_url: params[:custom_short_url])
    end

    def valid
      valid_custom_short_url && valid_origin_url && valid_exists_url
    end

    def valid_origin_url_is_link
      # TODO: valid origin url is link
    end

    def valid_exists_url
      return true unless ShortUrl.exists?(hash_id: generate_hash_id)

      errors.add(:base, :short_url_is_duplicate)
    end

    def valid_custom_short_url
      return true if params[:custom_short_url].blank?
      return true if params[:custom_short_url].size >= 6

      errors.add(:base, :short_url_invalid_length)
    end

    def valid_origin_url
      return true if params[:origin_url].present?

      errors.add(:base, :origin_url_is_required)
    end
  end
end
