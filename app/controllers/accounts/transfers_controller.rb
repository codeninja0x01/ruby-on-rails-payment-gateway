class Accounts::TransfersController < ApplicationController
  before_action :require_login
  
  def index
  end

  def create
    transfer_amount = transfer_params[:transfer_amount].to_d
    transfer_to = transfer_params[:transfer_to].to_i
    note = transfer_params[:note]

    if receiver = Account.find_by_account_id(transfer_to)

      current_account.transfer_fund(transfer_amount, Account.find_by_account_id(transfer_to), note)

      if current_account.valid?(:transfer_fund)
        flash[:info] = 'Transfer is successful'
        redirect_to dashboard_path and return
      else
        render :index and return
      end
    end
    
    flash.now[:danger] = 'Sorry we couldn\'t find the receiver account .'
    render :index
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def transfer_params
      params.require(:transfer).permit(:transfer_to, :transfer_amount, :note)
    end
end
