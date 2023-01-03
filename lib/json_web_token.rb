# frozen_string_literal: true

class JsonWebToken
  class << self
    EXPIRED_TIME = 30.days
    ALGORITHM    = "HS256"
    SECRET_KEY   = "EXAMPLE_SECRET_KEY"

    def encode(data = {})
      JWT.encode(payload(data), SECRET_KEY, ALGORITHM)
    end

    def decode(token = "")
      JWT.decode(token, SECRET_KEY, true, algorithm: ALGORITHM).first
    end

    def payload(data)
      {
        exp: Time.current.to_i + EXPIRED_TIME.to_i,
        jti: SecureRandom.uuid
      }.merge(data)
    end
  end
end
