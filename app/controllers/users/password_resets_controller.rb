class Users::PasswordResetsController < ApplicationController
  before_action :get_user, only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  layout 'auth'

  # GET /auth/password_rests/new
  def new
  
  end

  # GET /auth/password_rests/1/edit
  def edit
    
  end

  # POST /auth/password_rests
  # POST /auth/password_rests.json
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)

    if @user
        @user.create_reset_digest
        @user.send_password_reset_email
        flash[:info] = 'Email has been sent with password reset instructions'
        redirect_to root_path
    else
        flash[:warning] = 'Email address not found'
        render :new
    end
  end

  # PATCH/PUT /auth/password_rests/1
  # PATCH/PUT /auth/password_rests/1.json
  def update
    if password_blank?
      flash.now[:danger] = "Password Can't be blank"
    elsif @user.update_attributes(user_params)
      sign_in @user
      flash[:success] = "Password has been reset."
      redirect_to dashboard_path
      return
    end
    render :edit
  end

  private
  def get_user
    @user = User.find_by(email: params[:email])

  end

  def password_blank?
    user_params[:password].blank?
  end

  # Confirms a valid user
  def valid_user
    unless (@user && @user.activated && @user.authenticated?(:reset, params[:id]))
      redirect_to root_path
    end
  end

  # Check expiration of rest token.
  def check_expiration
    if @user.password_rest_expired? 
      flash.now[:danger] = "Password confirmation has been expired"
    end
  end

  def user_params
     params.require(:user).permit(:password, :password_confirmation)
  end
end
