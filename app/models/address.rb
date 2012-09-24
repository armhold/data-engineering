# a merchant's address
#
# We use a combination of merchant_id and street as a business key for lookups.
#
# a real application would have street1, street2, city, zip, etc.
#
class Address < ActiveRecord::Base
  belongs_to :merchant
  attr_accessible :street
end
