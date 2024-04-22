class SessionsController < ApplicationController
  protect_from_forgery with: :null_session

  def new
  end

  def create
    account = Registration.find_by(email: params[:session][:email])

    if account&.authenticate(params[:session][:password])
      reset_session
      session[:account_email] = account.email
      session[:account_role] = account.register_as


      if account.register_as == 'user'
        redirect_to home_path
      elsif account.register_as == 'vendor'
        redirect_to vendor_profile_path
      else
        flash.now[:alert] = "Unauthorized role"
        render :new
      end
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_url
  end
end
