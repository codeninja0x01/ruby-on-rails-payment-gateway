class Users::RegistrationsController < ApplicationController
  before_action :set_user_registration, only: [:show, :edit, :update, :destroy]
  before_action :require_logout

  layout 'auth'

  # GET /user/registrations/new
  def new
    @user_registration = User.new
  end

  # POST /user/registrations
  # POST /user/registrations.json
  def create
    @user_registration = User.new(user_registration_params)

      if @user_registration.save
        @user_registration.send_activation_email
        redirect_to root_path
        flash[:info] = 'Please check your email to activate your account.'
      else
        render :new
      end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_registration_params
      params.require(:user).permit(:email, :password, :password_confirmation, :terms_of_service, account_attributes: [:id, :account_type_id], info_attributes: [:id, :first_name, :last_name])
    end
end
