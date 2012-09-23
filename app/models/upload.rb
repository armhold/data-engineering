# represents a set of purchases uploaded via tab-separated file
#
# An upload is also tied to the OpenID user that uploaded it.
#
class Upload < ActiveRecord::Base

  has_many :purchases
  belongs_to :user

  # returns the gross revenue from all the purchases in this Upload
  #
  def gross_revenue
    purchases.inject(0) { |sum, purchase| sum + purchase.gross_revenue }
  end

  # creates, persists and returns an Upload from a file of tab-separated Purchase lines
  #
  def self.from_file(file, user)
    result = Upload.new

    file.open.each.with_index do |line, lineno|
      # skip header
      next if lineno == 0

      # parse the tab-separated line, with some minimal error-detection
      fields = line.split /\t/
      raise StandardError.new("error on line #{lineno + 1}; found #{fields.length} fields instead of 6") if fields.length != 6

      customer_name, item_description, item_price, quantity, street_address, merchant_name = fields

      merchant          = Merchant.find_or_create_by_name merchant_name
      address           = Address.find_or_create_by_merchant_id_and_street merchant.id, street_address
      customer          = Customer.find_or_create_by_name customer_name

      # always create a new item
      item              = Item.new
      item.description  = item_description
      item.price        = item_price

      # create the purchase to tie it all together
      purchase          = Purchase.new
      purchase.quantity = quantity
      purchase.item     = item
      purchase.customer = customer
      purchase.merchant = merchant
      purchase.address  = address

      result.purchases << purchase
    end

    result.user = user
    result.save

    result
  end

end
