# represents a set of purchases uploaded via tab-separated file
#
class Upload < ActiveRecord::Base
  has_many :purchases

  # returns the gross revenue from all the purchases in this Upload
  #
  def gross_revenue
    purchases.inject(0) { |sum, purchase| sum + purchase.gross_revenue }
  end

  # builds an Upload from a file of tab-separated Purchase lines
  #
  def self.from_file(file)
    result = Upload.new

    File.open file do |f|
      while line = f.gets
        # skip header
        next if f.lineno == 1

        # parse the tab-separated line
        customer_name, item_description, item_price, quantity, merchant_address, merchant_name = line.split /\t/

        # find or construct the Merchant
        merchant         = Merchant.find_or_initialize_by_name merchant_name
        merchant.address = merchant_address
        merchant.save

        # find or construct the Customer
        customer = Customer.find_or_initialize_by_name customer_name
        customer.save

        # create the item
        item             = Item.new
        item.description = item_description
        item.price       = item_price

        # create the purchase to tie it all together
        purchase          = Purchase.new
        purchase.quantity = quantity
        purchase.item     = item
        purchase.customer = customer
        purchase.merchant = merchant

        result.purchases << purchase
      end
    end

    result.save
    result
  end

end
