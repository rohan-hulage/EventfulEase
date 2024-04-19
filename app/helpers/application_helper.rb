module ApplicationHelper

    def current_user
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def current_vendor
        @current_vendor ||= User.find(session[:vendor_id]) if session[:vendor_id]
    end

    def logged_in?
        !!current_user
        !!current_vendor
    end

end
