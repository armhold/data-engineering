# represents a set of purchases uploaded via tab-separated file
#
# An upload is also tied to the OpenID user that uploaded it.
#
class Upload < ActiveRecord::Base

  has_many :purchases
  belongs_to :user

  validates :user, presence: true
  validates_associated :purchases, presence: true

  # returns the gross revenue from all the purchases in this Upload
  #
  def gross_revenue
    purchases.inject(0) { |sum, purchase| sum + purchase.gross_revenue }
  end

  # creates, persists and returns an Upload from a file of tab-separated Purchase lines
  #
  def self.from_file(file, user)
    result = Upload.new

    Upload.transaction do
      file.open.each.with_index do |line, lineno|
        # skip header
        next if lineno == 0

        # parse the tab-separated line, with some minimal error-detection
        fields = line.split /\t/
        raise StandardError.new("error on line #{lineno + 1}; found #{fields.length} fields instead of 6") if fields.length != 6

        customer_name, item_description, item_price, quantity, street_address, merchant_name = fields

        merchant = Merchant.find_or_create_by_name merchant_name
        address  = Address.find_or_create_by_merchant_id_and_street merchant, street_address
        customer = Customer.find_or_create_by_name customer_name

        purchase = result.purchases.build(quantity: quantity, customer: customer, merchant: merchant, address: address)
        purchase.build_item(description: item_description, price: item_price)

        # annoying that "build" does not seem to set purchase.upload => upload.
        # The unit test won't validate purchase without this, even though it persists just fine.
        purchase.upload = result
      end

      result.user = user
      result.save
    end

    result
  end

end
