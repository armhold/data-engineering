# a merchant's address
#
# a real application would have street1, street2, city, zip, etc.
#
class Address < ActiveRecord::Base
  belongs_to :merchant
  attr_accessible :street
end
