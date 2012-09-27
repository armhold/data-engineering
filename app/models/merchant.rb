# represents a merchant
#
# For lack of anything better, we use 'name' as a business key for lookups.
# A merchant may have multiple addresses.
#
class Merchant < ActiveRecord::Base
  attr_accessible :name

  has_many :addresses

  validates :name, presence: true
end
