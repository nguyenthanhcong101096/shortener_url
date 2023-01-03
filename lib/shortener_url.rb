# frozen_string_literal: true

class ShortenerUrl
  class << self
    BASE62      = [*0..9, *"a".."z", *"A".."Z"].freeze
    BASE        = BASE62.length
    CODE_LENGTH = 6

    def encode(custom_short_url: nil)
      custom_short_url || BASE62.sample(CODE_LENGTH).join
    end

    def get_hash_id(short_url)
      hash_id = 0

      short_url.chars.each_with_index do |c, i|
        index = BASE62.join.index(c)

        break if index.negative?

        hash_id += index * (CODE_LENGTH**(6 - i - 1))
      end

      hash_id
    end
  end
end
