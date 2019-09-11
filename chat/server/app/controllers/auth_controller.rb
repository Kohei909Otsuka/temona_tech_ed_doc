class AuthController < ApplicationController

  skip_before_action :set_current_user, only: [:create]

  def create
    r = User.login(login_params[:email], login_params[:password])
    if r.success?
      cookies[:session_id] = r.data.session_id
      head :ok
      return
    end

    err_response(r.errs, :not_found)
  end

  def destroy
    r = @current_user.logout
    if r.success?
      cookies.delete(:session_id)
      head :ok
      return
    end

    err_response(r.errs, :not_found)
  end

  private

  def login_params
    params.permit(:email, :password)
  end
end
