class GatewayController < ApplicationController
  before_action :require_login

  def initializer
    back_to = params[:back_to]

  	if account = Account.find_by(account_id: params[:account_id])
  		if current_account.transact(params[:amount].to_i, account)
  			redirect_to back_to+"/?signal=1"
  			return
  		end
  	end
  	
    redirect_to back_to+"/?signal=0"
  end
end
