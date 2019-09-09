class ApplicationController < ActionController::API

  def err_response(errs, status)
    render json: {errs: errs}, status: status
  end
end
