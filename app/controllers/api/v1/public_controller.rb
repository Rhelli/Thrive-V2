class Api::V1::PublicController < ApplicationController
  def public
    render json: { message: 'Hello from the public endpoint. You dont need to be authenticated to see this' }
  end
end
