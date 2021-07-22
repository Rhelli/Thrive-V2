class Api::V1::UsersController < ApplicationController
  include Secured

  def index
    @users = User.all
    render json: { users: @users }, status: :ok
  end
end
