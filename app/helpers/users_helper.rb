module UsersHelper
  
  # Sign in the given user.
  def sign_in(user)
    if user.activated?
      session[:user_id] = user.id
      user.traces.create(sign_in_at: Time.now.utc, sign_in_ip: request.remote_ip)
      flash[:success] =  "Welcome Back #{user.info.first_name.titleize}!"
    end
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember_me
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Sign out the current user.
  def sign_out
    forget(current_user)
    session[:user_id] = nil
    flash[:info] = "You are Logged out"
  end

  # Returns the current logged-in user (if any).
  def current_user
  	if (user = session[:user_id])

    @current_user ||= User.find_by(id: user) if user
    
    elsif (user_id = cookies.signed[:user_id])
        user = User.find(user_id)

        if user && user.authenticated?(:remember, cookies[:remember_token])
          sign_in user
          @current_user = user
        end
    end
  end

  def forget(user)
    user.forget_me
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Returns true if the user is signed in, false otherwise.
  def signed_in?
  	!!current_user
  end

  def require_login
    unless signed_in?
      flash[:warning] = "You must be logged in to access this page"
      redirect_to signin_path # halts request cycle
    end
  end

  def require_logout
    unless !signed_in?
      redirect_to dashboard_path # halts request cycle
    end
  end

  def user_activated?
    current_user.activated?
  end
  
end
