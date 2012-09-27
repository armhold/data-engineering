# an item that has been purchased
#
# Note that for simplicity we include price here; in a real application it's likely that the price
# would not be tied directly to the item, but rather sit in some other table.
#
class Item < ActiveRecord::Base
  attr_accessible :description, :price

  validates :description, :price, presence: true
end
