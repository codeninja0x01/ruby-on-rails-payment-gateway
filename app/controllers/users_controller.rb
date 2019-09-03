class UsersController < Users::ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login
  before_action :require_same_user

  def show
  end

  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
      if @user.update(user_params)
        redirect_to dashboard_path
        flash[:success] = 'User Info was successfully updated.' 
      else
        render :edit
      end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, info: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, info_attributes: [:id, :first_name, :last_name])
    end

  def require_same_user
    if current_user != @user
      flash[:danger] = "Invalide input provide"
      redirect_to user_path(current_user)
    end
  end
end
