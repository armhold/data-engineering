# represents a customer who has made a purchase
#
# For lack of anything better, we use 'name' as a business key for lookups.
#
class Customer < ActiveRecord::Base
  attr_accessible :name
end
