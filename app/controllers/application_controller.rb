class ApplicationController < ActionController::Base
  helper_method :current_account
  protect_from_forgery with: :null_session

  def current_account
    if session[:account_email].present?
      @current_account ||= Registration.find_by(email: session[:account_email])
    else
      nil
    end
  end
end
