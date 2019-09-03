class Users::ConfirmationsController < ApplicationController
	def edit
		user = User.find_by(email: params[:email])
		if user && !user.activated && user.authenticated?(:activation, params[:id])
			user.activate
			flash[:info] = "Account Activated"
			sign_in user
			redirect_to dashboard_path
			return
		end

		unless signed_in?
			redirect_to dashboard_path
		end
		
		flash[:danger] = "Invalid Activation Link"
		redirect_back(fallback_location: dashboard_path)
	end
end
