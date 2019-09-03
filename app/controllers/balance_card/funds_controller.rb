class BalanceCard::FundsController < ApplicationController
  before_action :set_balance_card_fund

  # GET /balance_card/funds
  # GET /balance_card/funds.json
  def index
    @balance_card_fund = BalanceCard.new
  end

  # POST /balance_card/funds
  # POST /balance_card/funds.json
  def create
    if @balance_card_fund = BalanceCard.find_by_card_code(balance_card_fund_params[:card_code])

      if @balance_card_fund.valid?
        render :edit
      else
        render :index
      end
    
    else
      flash[:danger] = 'Invalid card number provided. Please make sure you put it correctly.'
      redirect_to funds_path
    end
  end

  # PATCH/PUT /balance_card/funds/1
  # PATCH/PUT /balance_card/funds/1.json
  def update

      @balance_card_fund = BalanceCard.find_by_card_code(params[:id])
      @balance_card_fund.fund_account(params[:amount], current_account)

      if @balance_card_fund.valid?(:fund_account)
        flash[:info] = 'Your account has been funded successfuly'
        redirect_to funds_path
      else
        render :edit
      end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_balance_card_fund
      @balance_card_funds = BalanceCard::History.all.where(account_id: current_account.id)
      # @balance_card_fund = BalanceCard::Fund.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def balance_card_fund_params
      params.require(:balance_card).permit(:card_code)
    end
end
