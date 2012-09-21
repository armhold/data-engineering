# represents a merchant
#
# note that for simplicity we include the merchant's address here; in a real application we'd likely
# keep the address in another table, perhaps 'addresses'.
#
#
class Merchant < ActiveRecord::Base
  attr_accessible :address, :name
end
