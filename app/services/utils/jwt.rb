class Utils::Jwt

  HMAC_SECRET = ENV['HMAC_SECRET']

  def self.encode(payload)
    JWT.encode payload, HMAC_SECRET, 'HS256'
  end

  def self.decode(token)
    JWT.decode token, HMAC_SECRET
  end

  def self.email_from_token(token)
    decoded_token = self.decode(token)
    decoded_token.first['email']
  end
end
