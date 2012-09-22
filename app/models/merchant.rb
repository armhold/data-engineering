# represents a merchant
#
# note that for simplicity we include the merchant's address here; in a real application we'd likely
# keep the address in another table, perhaps 'addresses'. The current implementation is flawed in
# that it does not handle the case of a merchant having multiple addresses.
#
# For lack of anything better, we use 'name' as a business key for lookups.
#
#
class Merchant < ActiveRecord::Base
  attr_accessible :address, :name
end
