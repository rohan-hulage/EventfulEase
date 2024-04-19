class SessionsController < ApplicationController

    def new

    end

    def create
        user = User.find_by(email: params[:session][:email])
        vendor = Vendor.find_by(email: params[:session][:email])

        if user&.authenticate(params[:session][:password])
          reset_session
          session[:user_id] = user.id
          redirect_to home_path
        elsif vendor&.authenticate(params[:session][:password])
          reset_session
          session[:vendor_id] = vendor.id
          redirect_to home_path
        else
          flash.now[:alert] = "Invalid email or password"
          render :new
        end
      end

      def destroy
        session[:user_id] = nil
        redirect_to root_url
      end
end
