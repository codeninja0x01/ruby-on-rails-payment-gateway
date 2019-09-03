class DashboardController < ApplicationController
  before_action :require_login
	
  def index
  	@transactions ||= current_account.transactions.recent_transaction
  end
end
