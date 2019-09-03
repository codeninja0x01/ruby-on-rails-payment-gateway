class GatewayAuthsController < ApplicationController
  before_action :set_gateway_auth
  include ActionDispatch::Http::URL
  # GET /gateway_auths
  # GET /gateway_auths.json
  def index

    cookies[:sucess_return] = params[:sucess_return]
    cookies[:cancel_return] = params[:cancel_return]

    @purchase_items = current_account.purchase_items.build(gateway_auth_params)

    if gateway_auth_params[:business_id]
      business_account = Account.find_by_account_id(gateway_auth_params[:business_id])
    end

    unless business_account.nil?
      @purchase_items.business = business_account
    end

    if @purchase_items.valid?
      @purchase_items.save
    end 

    render :index
  end

  def make_payment

    @purchase_item = Account::PurchaseItem.find(params[:id])

    if @purchase_item.make_payment
      redirect_to @sucess_url+"/signal=1"
    else
      redirect_to @cancel_url+'/signal=0'
    end
  end

  private
    def set_gateway_auth
        @sucess_url = cookies[:sucess_return]
        @cancel_url = cookies[:cancel_return]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gateway_auth_params
      params.permit(:business_id, :item_name, :item_desc, :item_price)
    end
end

