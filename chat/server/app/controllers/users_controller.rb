class UsersController < ApplicationController

  def create
    r = User.register(
      user_params[:name],
      user_params[:email],
      user_params[:password],
    )

    if r.success?
      render json: r.data, status: :created
      return
    end

    err_response(r.errs, :unprocessable_entity)
  end

  private

  def user_params
    params.permit(:name, :email, :password)
  end
end
