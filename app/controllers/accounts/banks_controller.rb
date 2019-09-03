class Accounts::BanksController < ApplicationController
  before_action :set_accounts_bank, only: [:edit, :update, :destroy]

  # GET /accounts/banks
  def index
    if current_account.banks.nil?
      redirect_to new_bank_path
    end
    
    @accounts_banks = current_account.banks
  end

  def new
      @accounts_bank = current_account.banks.build
      # @accounts_banks = current_account.banks
  end

  # GET /accounts/banks/1/edit
  def edit
    redirect_to new_bank_path if current_account.banks.nil?
  end

  # POST /accounts/banks
  def create
    @accounts_bank = current_account.banks.build(accounts_bank_params)

      if @accounts_bank.valid?
        current_account.save!
        
        redirect_to banks_path
        flash[:info] = 'You bank details has been linked to your account'
      else
        render :new 
      end
  end

  # PATCH/PUT /accounts/banks/1
  def update
      if @accounts_bank.update(accounts_bank_params)
        redirect_to banks_path
        flash[:info] = 'Your bank details has been successfully updated.'
      else
        render :edit
      end
  end

  # DELETE /accounts/banks/1
  def destroy
    @accounts_bank.destroy
      redirect_to banks_path
      flash[:info] = 'Your bank details has been successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_accounts_bank
      @accounts_bank = current_account.banks.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def accounts_bank_params
      params.require(:account_bank).permit(:bank_account_number, :bank_holder_name, :bank_list_id)
    end
end
