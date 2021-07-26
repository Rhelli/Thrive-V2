class Api::V1::UsersController < SecuredController

  def index
    @users = User.all
    render json: { users: @users }, status: :ok
  end
end
