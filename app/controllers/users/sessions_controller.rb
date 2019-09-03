class Users::SessionsController < Users::ApplicationController
  before_action :require_logout, only: [:create, :new]

  layout 'auth'

  # login page
  def new
  end

  # checking login credential
  def create
    email = params[:session][:email]
    password = params[:session][:password]
    
      if email.present? && password.present?
       
        if (user = User.find_by(email: email)).try(:authenticate, password)
       
          
            # login the user and set the session id

            # remember the user
            params[:session][:remember_me] == '1' ? remember(user) : forget(user)

            respond_to do |format|

              if sign_in user
                format.html { redirect_to dashboard_path and return}
                format.json { head :no_content }
              else
                format.html { render 'new' , info: 'Account not activated. Check your email for the activation link' and return}
                format.json { head :no_content }
              end

            end
        end
          flash.now[:danger] = 'Invalid Email or Password'
          render 'new'
          return
      end
      flash.now[:danger] = 'Please Provide Email and Password'
      render 'new'
  end

  def destroy
    sign_out if signed_in?
    redirect_to signin_path
  end
end
