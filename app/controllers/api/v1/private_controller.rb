class Api::V1::PrivateController < ApplicationController
  include Secured

  def private
    render json: 'Hello from a provate endpoint! You need to be authenticated to see this endpoint!'
  end

  def private_scoped
    render json: { message: 'Hello from a provate endpoint! You need to be authenticated and have a scope to see this endpoint!' }
  end
end
