module SessionsHelper
    def sign_in(user)
        cookies.permanent[:remember_token] = user.remember_token
        #make current_user available in controllers and views
        current_user = user
    end

    def sign_out
        current_user = nil
        cookies.delete(:remember_token)
    end

    def signed_in?
        !current_user.nil?
    end

    def current_user?(user)
        user == current_user
    end

    def signed_in_user
        unless signed_in?
       # store_location
        redirect_to signin_path, notice: "Please sign in"
        end
    end
    
    #define assignment
    def current_user=(user)
        @current_user = user
    end

    def current_user
        #find user by cookie if currently undefined
        @current_user ||= User.find_by_remember_token(cookies[:remember_token])
    end

    def create_bookmark
        if signed_in?
            @bookmark = current_user.bookmarks.build
        end
    end

end
