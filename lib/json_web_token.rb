class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s
  SIGNING_ALGORITHM = 'HS256'.freeze
  class << self
    def encode(payload, header_fields = {}, exp = 1.year.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, SECRET_KEY, SIGNING_ALGORITHM, header_fields)
    end

    def decode(token)
      JWT.decode(token, SECRET_KEY)
    end
  end
end