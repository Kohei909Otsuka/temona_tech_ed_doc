class UsersController < ApplicationController
  skip_before_action :set_current_user, only: [:create]

  def create
    r = User.register(
      user_params[:name],
      user_params[:email],
      user_params[:password],
    )

    if r.success?
      render json: UserSerializer.new(r.data).serializable_hash,
        status: :created
      return
    end

    err_response(r.errs, :unprocessable_entity)
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
