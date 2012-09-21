# represents a purchase of a quantity of items by a customer
#
class Purchase < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant
  belongs_to :upload

  attr_accessible :quantity

  # attr_accessible :title, :body
end
