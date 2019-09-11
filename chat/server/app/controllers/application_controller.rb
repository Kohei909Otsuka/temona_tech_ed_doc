class ApplicationController < ActionController::API
  include ActionController::Cookies
  before_action :set_current_user

  private

  def set_current_user
    return @current_user if @current_user

    session_id = cookies[:session_id]
    r = SessionStorage.get(session_id)
    user_id = r.data

    if user_id.nil?
      err_response([], :unauthorized)
      return
    end

    user = User.find(user_id)
    user.session_id = session_id
    @current_user = user
  end

  def err_response(errs, status)
    render json: {errs: errs}, status: status
  end
end
