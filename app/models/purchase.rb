# represents a purchase of a quantity of items by a customer
#
class Purchase < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant
  belongs_to :address
  belongs_to :upload
  belongs_to :item

  attr_accessible :quantity

  def gross_revenue
    quantity * item.price
  end


end
