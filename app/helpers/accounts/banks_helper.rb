module Accounts::BanksHelper
	def build_bank(resource)
		resource = resource.build_bank
		resource.build_bank_list
		resource
	end
end
