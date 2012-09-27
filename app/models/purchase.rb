# represents a purchase of a quantity of items by a customer, from a merchant, at a given address.
#
# A purchase is always tied to an Upload (i.e. the file it was uploaded in).
#
class Purchase < ActiveRecord::Base
  belongs_to :customer
  belongs_to :merchant
  belongs_to :address
  belongs_to :upload
  belongs_to :item

  attr_accessible :customer, :merchant, :address, :upload, :item, :quantity

  validates :customer, :merchant, :address, :upload, :item, :quantity, presence: true

  def gross_revenue
    quantity * item.price
  end

end
