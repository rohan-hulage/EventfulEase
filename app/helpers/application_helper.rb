module ApplicationHelper

    def current_user
      @current_user ||= Registration.find(session[:user_email]) if session[:user_email]
    end

    def current_vendor
        @current_vendor ||= Registration.find(session[:vendor_email]) if session[:vendor_email]
    end

    def logged_in?
        !!current_user
        !!current_vendor
    end

end
