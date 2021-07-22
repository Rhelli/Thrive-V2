module Secured
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request!
  end

  SCOPES = {
    '/private' => nil,
    '/private-scoped' => ['read:users']
  }

  private

  def authenticate_request!
    @auth_payload, @auth_header = auth_token

    render json: { errors: ['Insufficient scope #securedconcern'] }, status: :unauthorized unless scope_included
  rescue JWT::VerificiationError, JWT::DecodeError
    render json: { errors: ['Not Authenticated #securedconcern'] }, status: :unauthorized
  end

  def scope_included
    if SCOPES[request.env['PATH_INFO']] === nil
      true
    else
      (String(@auth_payload['scope']).split(' ') & (SCOPES[request.env['PATH_INFO']])).any?
    end
  end

  def http_token
    request.headers['Authorization'].split(' ').last unless !request.headers['Authorization'].present?
  end

  def auth_token
    JsonWebToken.verify(http_token)
  end
end
