require 'net/http'
require 'uri'

class JsonWebToken
  def self.verify(token)
    JWT.decode(
      token,
      nil,
      true,
      algorithm: 'RS256',
      iss: Rails.application.credentials.dig(:auth0, :domain),
      verify_iss: true,
      aud: Rails.application.credentials.dig(:auth0, :api_identifier),
      verify_aud: true,
    ) do |header|
      jwks_hash[header['kid']]
    end
  end

  def self.jwks_hash
    jwks_raw = Net::HTTP.get URI(`https://#{Rails.application.credentials.dig(:auth0, :domain)}/.well-known/jwks.json`)
    jwks_keys = Array(JSON.parse(jwks_raw)['keys'])
    [
      jwks_keys.map do |k|
      [
        k['kid'],
        OpenSSL::X509::Certificate.new(
          Base64.decode64(k['x5c'].first)
        ).public_key
      ]
      end
    ].to_h
  end
end
